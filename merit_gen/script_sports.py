import os
import pandas as pd
from PIL import Image, ImageDraw, ImageFont
import re

# ===================== CONFIG =====================
BACKGROUND_IMAGE = "sports.png"
CSV_FILE = "sports_data.csv"
OUTPUT_DIR = "output_certificates"

# Certificate text positions (tweak if needed)
NAME_Y = 1162
INSTITUTE_Y = 1463
SPORTS_Y = 1578

# ==================================================

os.makedirs(OUTPUT_DIR, exist_ok=True)

# ---------- Data Cleaning Helpers ----------
def clean_spaces(text):
    """Remove extra spaces and normalize spacing."""
    if pd.isna(text):
        return ""
    text = text.strip()
    text = re.sub(r"\s+", " ", text)
    return text

def clean_sports(sports):
    """Clean sports list: remove extra commas & spaces."""
    if pd.isna(sports):
        return ""
    items = sports.split(",")
    items = [clean_spaces(i) for i in items if clean_spaces(i)]
    return ", ".join(items)

# ---------- Load CSV ----------
df = pd.read_csv(CSV_FILE)

# ---------- Load Image ----------
bg = Image.open(BACKGROUND_IMAGE).convert("RGBA")
W, H = bg.size

# ---------- Fonts ----------
font_name = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProMedium.otf", 144)
font_text = ImageFont.truetype("../fonts/optima-nova-lt-pro/OptimaNovaLTProRegular.otf", 60)

for idx, row in df.iterrows():
    name = clean_spaces(row.get("name", ""))
    institute = clean_spaces(row.get("institute", ""))
    sport = clean_sports(row.get("sport", ""))
    place=row.get("position","")

    if place.upper()=="FIRST": place="1st"
    elif place.upper()=="SECOND": place="2nd"
    elif place.upper()=="THIRD": place="3rd"
    elif place.upper()=="FOURTH": place="4th"

    # Create a fresh copy for each certificate
    img = bg.copy()
    draw = ImageDraw.Draw(img)

    # ---------- Draw Name (Centered) ----------
    name_bbox = draw.textbbox((0, 0), name, font=font_name)
    name_width = name_bbox[2] - name_bbox[0]
    name_x = 590 + (2024 - name_width) // 2

    draw.text(
        (name_x, NAME_Y),
        name.upper(),
        fill="#191C2A",
        font=font_name
    )

    # ---------- Draw Institute (Centered in first blank) ----------
    inst_bbox = draw.textbbox((0, 0), institute, font=font_text)
    inst_width = inst_bbox[2] - inst_bbox[0]
    inst_x = 1080 + (520 - inst_width) // 2


    draw.text(
        (inst_x, INSTITUTE_Y),
        institute,
        fill="#191C2A",
        font=font_text
    )
        # ---------- Draw Sports (Centered in third blank) ----------
    sports_bbox = draw.textbbox((0, 0), sport, font=font_text)
    sports_width = sports_bbox[2] - sports_bbox[0]
    sports_x = 850 + (800 - sports_width) // 2

    draw.text(
        (sports_x, SPORTS_Y),
        sport,
        fill="#191C2A",
        font=font_text
    )
    # ---------- Draw Position (Centered in second blank) ----------
    pos_bbox = draw.textbbox((0, 0), place, font=font_text)
    pos_width = pos_bbox[2] - pos_bbox[0]
    pos_x = 1835 + (520 - pos_width) // 2


    draw.text(
        (pos_x, INSTITUTE_Y),
        place,
        fill="#191C2A",
        font=font_text
    )
        # ---------- Save (avoid overwriting) ----------
    safe_name = re.sub(r"[^a-zA-Z0-9_]", "", name.replace(" ", "_"))

    base_path = os.path.join(OUTPUT_DIR,sport,str(place), safe_name)
    output_path = f"{base_path}.png"
    os.makedirs(os.path.join(OUTPUT_DIR,sport,str(place)), exist_ok=True)

    counter = 1
    while os.path.exists(output_path):
        output_path = f"{base_path}{counter}.png"
        counter += 1

    img.save(output_path)


    print(f"Generated: {output_path}")

print("✅ All certificates generated successfully!")
