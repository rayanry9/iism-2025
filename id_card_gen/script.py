import os
import csv
import io
import glob
import tempfile
from PIL import Image, ImageDraw, ImageFont, ImageOps, ImageFilter
import pandas as pd

# barcode library
try:
    import barcode
    from barcode.writer import ImageWriter
except Exception as e:
    raise ImportError("Please install python-barcode: pip install python-barcode Pillow") from e

# ------------------------- USER CONFIG -------------------------
csv_path = "data.csv"                        # your CSV path
photos_folder = "images"                    # photos folder
pictogram_folder = "pictograms"             # sport icons
output_folder = "final_ids"                 # output folder
os.makedirs(output_folder, exist_ok=True)

# Background images (two variants)
student_bg_path = "ID_Student_Front.png"  # normal participant background (your provided)
staff_bg_path = "ID_Staff_Front.png"              # staff background (your provided)

# fonts (adjust paths or install system fonts)
# Provide robust fallbacks to PIL default fonts if custom font not available

name_font_big = ImageFont.truetype("../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf",40)
name_font_small = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf",26)
uni_font = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProRegular.otf",56)
role_font = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProHeavy.otf",96)
small_font = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf",56)
code_font=ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProDemi.otf",45)

# visual params
photo_diameter = 360        # pixel diameter of circular photo
photo_border = 18           # ring width
photo_center_x = 960        # center X of photo on canvas
photo_center_y = 260        # center Y of photo on canvas

# Card size assumed (use your background size, adjust if different)
CARD_W, CARD_H = 1000, 1400

# text colors
WHITE = (255, 255, 255)
BLACK = (20, 20, 20)
ORANGE = (232, 95, 33)   # sample orange, tweak if needed
DARK = (30, 30, 30)

# ------------------------- HELPERS -------------------------

def make_circle_avatar(img, diameter, border=12, border_color=ORANGE):
    """Return circular avatar with border"""
    # resize and crop to square
    img = img.convert("RGBA")
    w, h = img.size
    side = min(w,h)
    # center crop
    left = (w-side)//2
    top = (h-side)//2
    img = img.crop((left, top, left+side, top+side)).resize((diameter, diameter), Image.LANCZOS)

    # mask
    mask = Image.new("L", (diameter, diameter), 0)
    draw = ImageDraw.Draw(mask)
    draw.ellipse((0,0,diameter-1,diameter-1), fill=255)

    # avatar base
    avatar = Image.new("RGBA", (diameter, diameter), (0,0,0,0))
    avatar.paste(img, (0,0), mask)

    # ring
    if border > 0:
        ring_size = diameter + border*2
        ring = Image.new("RGBA", (ring_size, ring_size), (0,0,0,0))
        dr = ImageDraw.Draw(ring)
        # outer circle
        dr.ellipse((0,0,ring_size-1,ring_size-1), fill=border_color)
        # inner hole
        hole_bbox = (border, border, border+diameter-1, border+diameter-1)
        dr.ellipse(hole_bbox, fill=(0,0,0,0))
        # paste avatar onto ring
        ring.paste(avatar, (border, border), avatar)
        return ring
    else:
        return avatar

def generate_barcode_image(code_text, max_width=700, height=110):
    """Generate Code128 barcode using python-barcode and return PIL image"""
    CODE128 = barcode.get_barcode_class('code128')
    writer = ImageWriter()
    # configure writer options
    writer_options = {
        "module_height": height/10.0,
        "module_width": 0.3,
        "quiet_zone": 2.0,
        "font_size": 18,
        "text_distance": 4.0,
        "background": "white",
        "foreground": "black",
        "write_text": False
    }
    with tempfile.NamedTemporaryFile(suffix='.png', delete=False) as tf:
        temp_name = tf.name
    try:
        bar = CODE128(code_text, writer=writer)
        bar.save(temp_name.replace('.png',''), options=writer_options)
        # python-barcode creates file with extension, open it
        filename = temp_name.replace('.png','') + '.png'
        img = Image.open(filename).convert("RGBA")
        # resize maintaining aspect to fit max_width
        w, h = img.size
        scale = min(1.0, max_width / w)
        new_size = (int(w*scale), int(h*scale))
        img = img.resize(new_size, Image.LANCZOS)
        # cleanup generated file
        try:
            os.remove(filename)
        except:
            pass
        return img
    finally:
        # try remove tmp file if exists
        try:
            if os.path.exists(temp_name):
                os.remove(temp_name)
        except:
            pass

def split_name_two_lines(full_name):
    """Return (line1, line2) per rule: last word on line2"""
    parts = [p for p in full_name.strip().split() if p]
    if not parts:
        return "", ""
    if len(parts) == 1:
        return parts[0], ""
    line2 = parts[-1]
    line1 = " ".join(parts[:-1])
    return line1, line2

# ------------------------- Read CSV -------------------------
df = pd.read_csv(csv_path, dtype=str).fillna("")
# Ensure columns present
expected = ["name","college","blood","phone","sport","role","staff","code"]
for c in expected:
    if c not in df.columns:
        df[c] = ""

# ------------------------- Processing Loop -------------------------
for idx, row in df.iterrows():
    name = row["name"].strip()
    college = row["college"].strip()
    blood = row["blood"].strip()
    phone = row["phone"].strip()
    sport = row["sport"].strip()
    role = row["role"].strip() or "Participant"
    staff_flag = (str(row["staff"]).strip().lower() == "t")
    code_text = str(row["code"]).strip()

    # Format college
    if "iit" not in college.lower() and college:
        college_display = "IIT " + college
    else:
        college_display = college

    # split name
    name_l1, name_l2 = split_name_two_lines(name)

    # choose background
    bg_path = staff_bg_path if staff_flag else student_bg_path
    if not os.path.exists(bg_path):
        # fallback: create plain white bg if not present
        canvas = Image.new("RGBA", (CARD_W, CARD_H), (255,255,255,255))
    else:
        canvas = Image.open(bg_path).convert("RGBA")
        # if bg size differs from expected, resize to CARD_W x CARD_H
        if canvas.size != (CARD_W, CARD_H):
            canvas = canvas.resize((CARD_W, CARD_H), Image.LANCZOS)

    draw = ImageDraw.Draw(canvas)

    # Paste circular photo
    photo_path = "./"+photos_folder+"/"+code_text+".webp"
    if photo_path and os.path.exists(photo_path):
        try:
            pimg = Image.open(photo_path).convert("RGBA")
        except:
            pimg = None
    else:
        pimg = None

    # if no photo, use placeholder solid circle (orange)
    if pimg is None:
        placeholder = Image.new("RGBA", (photo_diameter, photo_diameter), (200,200,200))
        avatar = make_circle_avatar(placeholder, photo_diameter, border=photo_border, border_color=ORANGE)
    else:
        avatar = make_circle_avatar(pimg, photo_diameter, border=photo_border, border_color=ORANGE)

    # compute paste location for avatar (top center area)
    av_w, av_h = avatar.size
    paste_x = photo_center_x - av_w // 2
    paste_y = photo_center_y - av_h // 2
    canvas.paste(avatar, (paste_x, paste_y), avatar)

    # Role (top-right)
    role_text = role.upper()
    # draw role text (orange)
    role_x = CARD_W - 140
    role_y = 80
    draw.text((role_x, role_y), role_text, font=role_font, fill=ORANGE, anchor="rs")

    # Draw name left area (under logo)
    name_x = 140
    name_y_top = photo_center_y + av_h//2 + 20
    # first line larger
    draw.text((name_x, name_y_top), name_l1, font=name_font_big, fill=BLACK, anchor="ls")
    # second (last name)
    draw.text((name_x, name_y_top + 70), name_l2, font=name_font_small, fill=BLACK, anchor="ls")

    # College (below name)
    draw.text((name_x, name_y_top + 140), college_display, font=uni_font, fill=BLACK, anchor="ls")

    # Blood group and phone (below college)
    draw.text((name_x, name_y_top + 200), f"Blood Group - {blood}", font=small_font, fill=BLACK, anchor="ls")
    draw.text((name_x, name_y_top + 240), f"Ph. Number - {phone}", font=small_font, fill=BLACK, anchor="ls")

    # Sport pictogram (bottom-right area)
    pict_path = os.path.join(pictogram_folder, f"{sport.capitalize()}.png")

    if os.path.exists(pict_path):
        pict = Image.open(pict_path).convert("RGBA")
        pict.thumbnail((350,350),Image.LANCZOS)
        pict_x = CARD_W - pict.width-40
        pict_y = name_y_top + 300
        canvas.paste(pict, (pict_x, pict_y), pict)

    # Generate barcode
    if code_text:
        try:
            barcode_img = generate_barcode_image(code_text, max_width=1400, height=80)
            # paste barcode centered horizontally near bottom
            bc_w, bc_h = barcode_img.size
            bc_x = (CARD_W - bc_w) // 2
            bc_y = CARD_H - bc_h - 100
            canvas.paste(barcode_img, (bc_x, bc_y), barcode_img)
            # code text below barcode
            draw.text((CARD_W//2, bc_y + bc_h + 22), code_text, font=code_font, fill=BLACK, anchor="mm")
        except Exception as e:
            print(f"Barcode generation failed for {code_text}: {e}")

    # Save final image
    save_name = f"{code_text or name.replace(' ','_')}.png"
    out_path = os.path.join(output_folder, save_name)
    canvas.save(out_path)
    print("Saved:", out_path)

print("All IDs generated.")
