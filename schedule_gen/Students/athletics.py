import pandas as pd
from PIL import Image, ImageDraw, ImageFont, ImageOps
import os
from datetime import datetime

def make_icon_white(img):
    """
    Converts any colored icon PNG to solid white while keeping transparency.
    """
    # Convert to grayscale
    gray = ImageOps.grayscale(img)

    # Convert grayscale to white by mapping all non-transparent pixels to white
    white_icon = ImageOps.colorize(gray, black="white", white="white")

    # Preserve original alpha channel
    if img.mode == "RGBA":
        alpha = img.split()[-1]
        white_icon.putalpha(alpha)

    return white_icon
# ------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------
csv_path = "athletics.csv"
background_path = "../background.png"  # background image
table_folder = "Tables"  # folder containing all "<n>_rows.png" tables
output_folder = "final_outputs"
os.makedirs(output_folder, exist_ok=True)

# ------------------------------------------------------------
# LOAD AND PREPARE DATA
# ------------------------------------------------------------
df = pd.read_csv(csv_path)

def to_time(t):
    """Convert '8:30 AM' to datetime object for sorting"""
    try:
        return datetime.strptime(t.strip(), "%I:%M %p")
    except:
        return None

df["Time_obj"] = df["Time"].apply(to_time)

# Sort data by Pool (A→Z) and then Time (earlier→later)
df = df.sort_values(by=["Gender", "Date", "Time_obj"])

# Group data by unique Sport + Gender + Date
groups = df.groupby(["Gender", "Date"])

# ------------------------------------------------------------
# FONT CONFIG
# ------------------------------------------------------------
try:
    title_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf", 172)
    date_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf", 96)
    table_head_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf", 72)
    subtitle_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayRoman.ttf", 90)
    table_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayLight.ttf", 52)
except:
    title_font = ImageFont.load_default()
    subtitle_font = ImageFont.load_default()
    table_font = ImageFont.load_default()

# ------------------------------------------------------------
# DRAWING LOOP
# ------------------------------------------------------------

sport="ATHLETICS"
for (gender, date), group in groups:
    rows = group.to_dict(orient="records")
    n = len(rows)

    # --- Select the correct table image based on number of rows ---
    table_path = os.path.join(table_folder, f"{n}_rows_empty.png")

    # If no exact match, fall back to nearest smaller one
    if not os.path.exists(table_path):
        available = [int(f.split("_")[0]) for f in os.listdir(table_folder) if "_rows" in f]
        if available:
            closest = max([r for r in available if r <= n], default=min(available))
            table_path = os.path.join(table_folder, f"{closest}_rows_empty.png")
        else:
            raise FileNotFoundError("⚠️ No table templates found in folder!")

    # --- Load images ---
    bg = Image.open(background_path).convert("RGBA")
    table = Image.open(table_path).convert("RGBA")

    # Composite the background + table
    combined = Image.new("RGBA", bg.size)
    combined.paste(bg, (0, 0))
    combined.paste(table, (190, 1140), table)  # Adjust this offset as needed

    draw = ImageDraw.Draw(combined)
    w, _ = combined.size

    # ------------------------------------------------------------
    # DRAW TITLES (LEFT ALIGNED, NO FONT RESIZING)
    # ------------------------------------------------------------
    left_margin = 190

    # baseline Y for the top line
    y_title = 350
    y_sport=360
    y_gender = y_title + 190
    y_schedule = y_gender + 120
    y_date = y_schedule + 340
    y_margin=30

    # SPORT NAME (left aligned)
    draw.text((left_margin, y_sport+y_margin), sport.upper(), fill="white",
            font=title_font, anchor="ls")

    # GENDER (left aligned)
    draw.text((left_margin+10, y_gender+y_margin), gender, fill="white",
            font=title_font, anchor="ls")
    
    x_margin=15
    if gender=="Women": x_margin=20
    # SCHEDULE (left aligned)
    draw.text((left_margin+x_margin, y_schedule+y_margin), "Schedule", fill="white",
            font=subtitle_font, anchor="ls")

    # ------------------------------------------------------------
    # ADD SPORT ICON (TOP RIGHT)
    # ------------------------------------------------------------
    icon_path = "../Pictograms/Running.png"   # example folder path
    if os.path.exists(icon_path):
        icon = Image.open(icon_path).convert("RGBA")

        icon = make_icon_white(icon)
        # Resize proportional to fit the header area
        icon_size = 600   # adjust if needed
        icon.thumbnail((icon_size, icon_size), Image.LANCZOS)

        # Position (top-right area), adjust offsets to match your layout
        icon_x = bg.width - icon.width - 250
        icon_y = 220

        combined.paste(icon, (icon_x, icon_y), icon)
    else:
        print(f"⚠️ No icon found for sport: {sport}")

    # DATE (center aligned)
    draw.text((w/2-40, y_date), f"[{str(date)}]", fill="white",
          font=date_font, anchor="mm")
    
    # ------------------------------------------------------------
    # DRAW TABLE HEADERS
    # ------------------------------------------------------------
    header_y = 1090 + 80  # adjust if needed depending on table paste Y

    # Column X positions (same as used for row data)
    x_event_no = 265
    x_event    = 900
    x_time     = 1700

    draw.text((x_event_no, header_y), "NO.", font=table_head_font, fill="white")
    draw.text((x_event,    header_y), "EVENT", font=table_head_font, fill="white")
    # TIME column already exists on the template image, so no need to redraw

    # ------------------------------------------------------------
    # DRAW TABLE CONTENT
    # ------------------------------------------------------------
    # Adjust coordinates based on your table image design
   
    y_start = 1310
    row_height = 125
    x_event_no = 275
    x_event     = 350
    x_time      = 1700
    
    for i, row in enumerate(rows):
        y = y_start + i * row_height
        event_no = str(row["Event_No"]).strip()
        event = str(row["Event"]).strip()
        time = str(row["Time"]).strip()

        
        # --- CENTER ALIGN EVENT TEXT ---

        event_text = str(row["Event"]).strip()

        # Column bounds
        event_area_left = x_event
        event_area_right = x_time - 40
        event_center = (event_area_left + event_area_right) / 2

        # Measure width
        bbox = draw.textbbox((0, 0), event_text, font=table_font)
        event_width = bbox[2] - bbox[0]

        # Compute centered X
        x_event_centered = event_center - (event_width / 2)

        # Draw centered
        draw.text((x_event_centered, y), event_text,
                fill="white", font=table_font)

        draw.text((x_event_no, y), event_no, font=table_font, fill="white")
        # draw.text((x_event,    y), event,    font=table_font, fill="white")
        draw.text((x_time,     y), time,     font=table_font, fill="white")


    # ------------------------------------------------------------
    # SAVE OUTPUT
    # ------------------------------------------------------------
    out_name = f"Athletics_{gender}_{date.replace('/', '-')}.png"
    out_path = os.path.join(output_folder, out_name)
    combined.save(out_path)
    print(f"✅ Saved: {out_path}")

print("\n🎉 All images generated successfully!")
