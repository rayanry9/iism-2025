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
uni_font = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProRegular.otf",20)
role_font = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProHeavy.otf",34)
small_font = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProBold.otf",20)
code_font=ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProDemi.otf",16)

# visual params
photo_diameter = 220        # pixel diameter of circular photo
photo_center_x = 239        # center X of photo on canvas
photo_center_y = 235        # center Y of photo on canvas

# Card size assumed (use your background size, adjust if different)
CARD_W, CARD_H = 538, 742

# text colors
WHITE = (255, 255, 255)
BLACK = (20, 20, 20)
DARK = (30, 30, 30)

# ------------------------- HELPERS -------------------------

def make_circle_avatar(img, diameter):
    """Return a clean circular avatar with NO border."""
    img = img.convert("RGBA")
    w, h = img.size
    side = min(w, h)

    # Center crop to square
    left = (w - side) // 2
    top = (h - side) // 2
    img = img.crop((left, top, left + side, top + side))
    img = img.resize((diameter, diameter), Image.LANCZOS)

    # Create circle mask
    mask = Image.new("L", (diameter, diameter), 0)
    draw = ImageDraw.Draw(mask)
    draw.ellipse((0, 0, diameter - 1, diameter - 1), fill=255)

    # Apply mask (circle crop)
    avatar = Image.new("RGBA", (diameter, diameter), (0, 0, 0, 0))
    avatar.paste(img, (0, 0), mask)

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
        avatar = make_circle_avatar(placeholder, photo_diameter)
    else:
        avatar = make_circle_avatar(pimg, photo_diameter)

    # compute paste location for avatar (top center area)
    canvas.paste(avatar, (150, 130), avatar)

    # Role (top-right)
    role_text = role.upper()
    # draw role text (orange)
    role_x = CARD_W -40
    role_y = 150
    draw.text((505, 85), role_text, font=role_font, fill="#EF4823", anchor="rs")

    # Draw name left area (under logo)
    name_x = 28.92
    name_y_top = 470
    # first line larger
    draw.text((name_x, name_y_top), name_l1, font=name_font_big, fill=BLACK, anchor="ls")
    # second (last name)
    draw.text((name_x, name_y_top + 42), name_l2, font=name_font_big, fill=BLACK, anchor="ls")

    # College (below name)
    draw.text((name_x, 544), college_display.upper(), font=name_font_small, fill=BLACK, anchor="ls")

    # Blood group and phone (below college)
    label = "Blood Group - "
    value = blood  # e.g. "A+"

    # Draw first part (uni_font)
    draw.text((name_x, 580), label, font=uni_font, fill=BLACK, anchor="ls")

    # Measure width of first part
    label_width = draw.textbbox((0, 0), label, font=uni_font)[2]

    # Draw second part (small_font) right after the first
    draw.text((name_x + label_width, 580), value, font=small_font, fill=BLACK, anchor="ls")

    label = "Ph. Number - "
    value = phone  # e.g. "9344702682"

    draw.text((name_x, 605), label, font=uni_font, fill=BLACK, anchor="ls")

    label_width = draw.textbbox((0, 0), label, font=uni_font)[2]

    draw.text((name_x + label_width, 605), value, font=small_font, fill=BLACK, anchor="ls")



    # Sport pictogram (bottom-right area)
    pict_path = os.path.join(pictogram_folder, f"{sport.capitalize()}.png")

    if os.path.exists(pict_path):
        pict = Image.open(pict_path).convert("RGBA")
        pict.thumbnail((168,168),Image.LANCZOS)
        canvas.paste(pict, (340, 440), pict)

    # Generate barcode
    if code_text:
        try:
            barcode_img = generate_barcode_image(code_text, max_width=285, height=65)
            canvas.paste(barcode_img, (115,640), barcode_img)
            # code text below barcode
            spaced_code_text="  ".join(code_text)
            draw.text((CARD_W//2-13, 705), spaced_code_text, font=code_font, fill=BLACK, anchor="mm")
        except Exception as e:
            print(f"Barcode generation failed for {code_text}: {e}")

    # Save final image
    save_name = f"{code_text or name.replace(' ','_')}.png"
    out_path = os.path.join(output_folder, save_name)
    canvas.save(out_path)
    print("Saved:", out_path)

print("All IDs generated.")
