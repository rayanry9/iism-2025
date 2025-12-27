import os
import pandas as pd
from PIL import Image, ImageDraw, ImageFont
import re

# ===================== CONFIG =====================
BACKGROUND_IMAGE = "cert-staff.png"
CSV_FILE = "data-staff.csv"
OUTPUT_DIR = "output_certificates"

# Certificate text positions (tweak if needed)
NAME_Y = 1152
INSTITUTE_Y = 1458
SPORTS_Y = 1458

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

def wrap_text(text, font, draw, max_width):
    """
    Wrap text into multiple lines so that each line
    does not exceed max_width.
    """
    words = text.split(" ")
    lines = []
    current_line = ""

    for word in words:
        test_line = current_line + (" " if current_line else "") + word
        bbox = draw.textbbox((0, 0), test_line, font=font)
        test_width = bbox[2] - bbox[0]

        if test_width <= max_width:
            current_line = test_line
        else:
            lines.append(current_line)
            current_line = word

    if current_line:
        lines.append(current_line)

    return lines

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
    sports = clean_sports(row.get("sports", ""))

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
    inst_x = 860 + (520 - inst_width) // 2


    draw.text(
        (inst_x, INSTITUTE_Y),
        institute,
        fill="#191C2A",
        font=font_text
    )
    if sports=="Cricket" or sports=="Football" or sports=="Hockey" or sports=="Volleyball" or sports=="Basketball" or sports=="Chess" or sports == "Table Tennis" or sports == "Tennis" or sports =="Squash":
        # ---------- Draw Sports (Centered in second blank) ----------
            sports_bbox = draw.textbbox((0, 0), sports, font=font_text)
            sports_width = sports_bbox[2] - sports_bbox[0]
            sports_x = 1880 + (800 - sports_width) // 2

            draw.text(
                (sports_x, SPORTS_Y),
                sports,
                fill="#191C2A",
                font=font_text
            )
    else:
        # ---------- Draw Sports (Auto-wrap if needed) ----------
        MAX_LINES = 3
        LINE_SPACING = 12  # vertical gap between lines

        sports_lines = wrap_text(sports, font_text, draw, 900)

        if len(sports_lines)==3:
            font_text.size=48
            # Limit to MAX_LINES (optional safety)
            if len(sports_lines) > MAX_LINES:
                sports_lines = sports_lines[:MAX_LINES]

            total_height = len(sports_lines) * font_text.size + (len(sports_lines) - 1) * LINE_SPACING
            start_y = SPORTS_Y - total_height // 2 - 40

            for i, line in enumerate(sports_lines):
                line_bbox = draw.textbbox((0, 0), line, font=font_text)
                line_width = line_bbox[2] - line_bbox[0]

                line_x = 1920 + (900 - line_width) // 2
                line_y = start_y + i * (font_text.size + LINE_SPACING+4)

                draw.text(
                    (line_x, line_y),
                    line,
                    fill="#191C2A",
                    font=font_text
                )

        elif len(sports_lines)==2:
            # Limit to MAX_LINES (optional safety)
            if len(sports_lines) > MAX_LINES:
                sports_lines = sports_lines[:MAX_LINES]

            total_height = len(sports_lines) * font_text.size + (len(sports_lines) - 1) * LINE_SPACING
            start_y = SPORTS_Y - total_height // 2

            for i, line in enumerate(sports_lines):
                line_bbox = draw.textbbox((0, 0), line, font=font_text)
                line_width = line_bbox[2] - line_bbox[0]

                line_x = 1920 + (800 - line_width) // 2
                line_y = start_y + i * (font_text.size + LINE_SPACING)

                draw.text(
                    (line_x, line_y),
                    line,
                    fill="#191C2A",
                    font=font_text
                )

        else: 
            # ---------- Draw Sports (Centered in second blank) ----------
            sports_bbox = draw.textbbox((0, 0), sports, font=font_text)
            sports_width = sports_bbox[2] - sports_bbox[0]
            # sports_x = 1920 + (900 - sports_width) // 2
            sports_x = 1880 + (800 - sports_width) // 2

            draw.text(
                (sports_x, SPORTS_Y),
                sports,
                fill="#191C2A",
                font=font_text
            )


        # ---------- Save (avoid overwriting) ----------
    safe_name = re.sub(r"[^a-zA-Z0-9_]", "", name.replace(" ", "_"))

    base_path = os.path.join(OUTPUT_DIR, institute, safe_name)
    os.makedirs(os.path.join(OUTPUT_DIR, institute), exist_ok=True)
    output_path = f"{base_path}.png"

    counter = 1
    while os.path.exists(output_path):
        output_path = f"{base_path}{counter}.png"
        counter += 1

    img.save(output_path)


    print(f"Generated: {output_path}")

print("✅ All certificates generated successfully!")
