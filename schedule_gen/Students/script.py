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
csv_path = "matches.csv"
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
df = df.sort_values(by=["Sport", "Gender", "Date", "Pool", "Time_obj"])

# Group data by unique Sport + Gender + Date
groups = df.groupby(["Sport", "Gender", "Date"])

# ------------------------------------------------------------
# FONT CONFIG
# ------------------------------------------------------------
try:
    title_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf", 172)
    date_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayMedium.ttf", 96)
    subtitle_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayRoman.ttf", 90)
    table_font = ImageFont.truetype("../../fonts/neue-haas-grotesk-display-pro/NeueHaasDisplayLight.ttf", 52)
except:
    title_font = ImageFont.load_default()
    subtitle_font = ImageFont.load_default()
    table_font = ImageFont.load_default()

# ------------------------------------------------------------
# DRAWING LOOP
# ------------------------------------------------------------
for (sport, gender, date), group in groups:
    rows = group.to_dict(orient="records")
    n = len(rows)

    # --- Select the correct table image based on number of rows ---
    table_path = os.path.join(table_folder, f"{n}_rows.png")

    # If no exact match, fall back to nearest smaller one
    if not os.path.exists(table_path):
        available = [int(f.split("_")[0]) for f in os.listdir(table_folder) if "_rows" in f]
        if available:
            closest = max([r for r in available if r <= n], default=min(available))
            table_path = os.path.join(table_folder, f"{closest}_rows.png")
        else:
            raise FileNotFoundError("⚠️ No table templates found in folder!")

    # --- Load images ---
    bg = Image.open(background_path).convert("RGBA")
    table = Image.open(table_path).convert("RGBA")

    # Composite the background + table
    combined = Image.new("RGBA", bg.size)
    combined.paste(bg, (0, 0))
    combined.paste(table, (190, 1090), table)  # Adjust this offset as needed

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
    y_schedule = y_gender - 70
    y_date = y_schedule + 460
    y_margin=0

    if sport=="VOLLEYBALL": y_margin=30
    else: y_margin=100

    # SPORT NAME (left aligned)
    draw.text((left_margin, y_sport+y_margin), sport.upper(), fill="white",
            font=title_font, anchor="ls")

    # GENDER (left aligned)
    if sport=="VOLLEYBALL":
        draw.text((left_margin+10, y_gender+y_margin), gender, fill="white",
            font=title_font, anchor="ls")
        y_schedule+=190
    
    x_margin=0
    if sport=="CRICKET": x_margin=13
    if sport=="HOCKEY": x_margin=5
    if sport=="FOOTBALL": x_margin=0
    if sport=="VOLLEYBALL": x_margin=15
    # SCHEDULE (left aligned)
    draw.text((left_margin+x_margin, y_schedule+y_margin), "Schedule", fill="white",
            font=subtitle_font, anchor="ls")

    # ------------------------------------------------------------
    # ADD SPORT ICON (TOP RIGHT)
    # ------------------------------------------------------------
    icon_path = f"../Pictograms/{sport.capitalize()}.png"   # example folder path
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
    # DRAW TABLE CONTENT
    # ------------------------------------------------------------
    # Adjust coordinates based on your table image design
    x_pool = 300
    x_match = 400
    x_time = 1700
    y_start = 1060
    row_height = 125

    def normalize_institute(name):
        name = name.strip()

        # --- IIT DHANBAD ---
        if "Dhanbad" in name:
            return "IIT (ISM) Dhanbad"

        # --- IIT VARANASI ---
        if "Varanasi" in name:
            return "IIT (BHU) Varanasi"

        return name
    
    for i, row in enumerate(rows):
        y = y_start + i * row_height
        pool = str(row["Pool"]).strip()
        match = str(row["Match"]).strip()
        time = str(row["Time"]).strip()

        # Align "VS" in the same vertical column
        if "VS" in match:
            team1, team2 = match.split("VS")
            team1 = normalize_institute(team1.strip())
            team2 = normalize_institute(team2.strip())
            # pad to align VS column roughly
            # match_display = f"{team1:<15}VS  {team2}"
        # else:
            # match_display = match

        # --- Replacement: pixel-perfect VS alignment (recommended) ---
        # Pre-conditions: draw, table_font, x_match, x_time, y are defined

        # text pieces
        vs_text = "VS"
        gap = 24  # pixels between VS and each team; tweak to taste

        # compute match area (left bound, right bound)
        match_area_left = x_match
        match_area_right = x_time - 40   # leave some margin before Time column

        # center of the VS column inside the match area
        x_vs_center = match_area_left + (match_area_right - match_area_left) / 2

        # Build display strings (include IIT prefix here if not already)
        team1_text = f"{team1}"
        team2_text = f"{team2}"

        # Measure widths using textbbox (more accurate than getsize)
        def text_width(s, font):
            bbox = draw.textbbox((0, 0), s, font=table_font)
            return bbox[2] - bbox[0]

        team1_w = text_width(team1_text, table_font)
        team2_w = text_width(team2_text, table_font)
        vs_w = text_width(vs_text, table_font)

        # Calculate x positions:
        # - team1 should end (right-edge) at: x_vs_center - vs_w/2 - gap
        x_team1_right = x_vs_center - vs_w / 2 - gap
        x_team1 = x_team1_right - team1_w  # left coordinate for team1 (right-aligned)

        # - VS centered at x_vs_center
        x_vs = x_vs_center - vs_w / 2

        # - team2 left starts at: x_vs_center + vs_w/2 + gap
        x_team2 = x_vs_center + vs_w / 2 + gap

        # Draw text
        y_offset=200
        draw.text((x_team1, y+y_offset), team1_text, font=table_font, fill="white")
        draw.text((x_vs, y+y_offset), vs_text, font=table_font, fill="white")
        draw.text((x_team2, y+y_offset), team2_text, font=table_font, fill="white")


        # Slightly space out colon for visual alignment
        # time_aligned = time.replace(":", " : ")

        draw.text((x_pool, y+y_offset), pool, fill="white", font=table_font)
        # draw.text((x_match, y), match_display, fill="white", font=table_font)
        draw.text((x_time-25, y+y_offset), time, fill="white", font=table_font)

    # ------------------------------------------------------------
    # SAVE OUTPUT
    # ------------------------------------------------------------
    out_name = f"{sport}_{gender}_{date.replace('/', '-')}.png"
    out_path = os.path.join(output_folder, out_name)
    combined.save(out_path)
    print(f"✅ Saved: {out_path}")

print("\n🎉 All images generated successfully!")
