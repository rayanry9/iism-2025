import pandas as pd
from PIL import Image, ImageDraw, ImageFont, ImageOps
import os
from datetime import datetime

def make_icon_white(img):
    gray = ImageOps.grayscale(img)
    white_icon = ImageOps.colorize(gray, black="white", white="white")
    if img.mode == "RGBA":
        alpha = img.split()[-1]
        white_icon.putalpha(alpha)
    return white_icon

# ------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------
csv_path = "knockout.csv"
background_path = "../background.png"
table_folder = "Tables"
output_folder = "final_outputs"
os.makedirs(output_folder, exist_ok=True)

# ------------------------------------------------------------
# LOAD CSV
# ------------------------------------------------------------
df = pd.read_csv(csv_path)


def to_time(t):
    try:
        return datetime.strptime(t.strip(), "%I:%M %p")
    except:
        return None

df["Time_obj"] = df["Time"].apply(to_time)

### 🔥 CHANGED — Sorting now uses: Sport, Gender, Date, Time
df = df.sort_values(by=["Sport", "Gender", "Date", "Time_obj"])

### 🔥 CHANGED — Groups now: Sport, Gender, Date 
groups = df.groupby(["Sport", "Gender", "Date"])

# ------------------------------------------------------------
# FONTS
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
# DRAW LOOP
# ------------------------------------------------------------
for (sport, gender, date), group in groups:

    rows = group.to_dict(orient="records")
    n = len(rows)

    # --------------------------------------------------------
    # TABLE TEMPLATE SELECTION
    # --------------------------------------------------------
    table_path = os.path.join(table_folder, f"{n}_rows.png")
    if not os.path.exists(table_path):
        available = [int(f.split("_")[0]) for f in os.listdir(table_folder) if "_rows" in f]
        closest = max([r for r in available if r <= n], default=min(available))
        table_path = os.path.join(table_folder, f"{closest}_rows.png")

    # --------------------------------------------------------
    # BASE IMAGE
    # --------------------------------------------------------
    bg = Image.open(background_path).convert("RGBA")
    table = Image.open(table_path).convert("RGBA")

    combined = Image.new("RGBA", bg.size)
    combined.paste(bg, (0, 0))
    combined.paste(table, (190, 1090), table)

    draw = ImageDraw.Draw(combined)
    w, _ = combined.size

    # --------------------------------------------------------
    # HEADER TEXT
    # --------------------------------------------------------
    left_margin = 190
    y_title = 350
    y_sport = 360
    y_gender = y_title + 190
    y_schedule = y_gender - 70
    y_date = y_schedule + 460

    y_margin = 30 if sport == "VOLLEYBALL" else 100

    # SPORT NAME
    draw.text((left_margin, y_sport + y_margin), sport.upper(), fill="white",
              font=title_font, anchor="ls")

    # GENDER (kept for other sports)
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
    
    # --------------------------------------------------------
    # ADD ICON
    # --------------------------------------------------------
    icon_path = f"../Pictograms/{sport.capitalize()}.png"
    if os.path.exists(icon_path):
        icon = Image.open(icon_path).convert("RGBA")
        icon = make_icon_white(icon)
        icon.thumbnail((600, 600), Image.LANCZOS)
        icon_x = bg.width - icon.width - 250
        icon_y = 220
        combined.paste(icon, (icon_x, icon_y), icon)

    # --------------------------------------------------------
    # DATE CENTERED
    # --------------------------------------------------------
    draw.text((w/2 - 40, y_date), f"[{date}]", fill="white",
              font=date_font, anchor="mm")

    # --------------------------------------------------------
    # TABLE CONTENT — UPDATED FOR KNOCKOUT FORMAT
    # --------------------------------------------------------
    x_pool = 250      # Event No. / Round
    x_match = 400     # Event Name
    x_time = 1710     # Time
    y_start = 1060
    row_height = 125

    for i, row in enumerate(rows):

        y = y_start + i * row_height + 200  # offset to fit into table

        ### 🔥 CHANGED — new columns
        pool = str(row["Pool"]).strip()       # round (PQF1, QF2, FINAL)
        team1 = str(row["Team1"]).strip()
        team2 = str(row["Team2"]).strip()
        match = f"{team1}  VS  {team2}"
     # full event (Winner of...)
        time = str(row["Time"]).strip()

        ### 🔥 CENTER-ALIGN EVENT NAME INSIDE MATCH COLUMN
        match_area_left = x_match
        match_area_right = x_time - 60
        match_area_center = match_area_left + (match_area_right - match_area_left) / 2

        bbox = draw.textbbox((0, 0), match, font=table_font)
        match_w = bbox[2] - bbox[0]
        x_match_centered = match_area_center - match_w / 2

        # DRAW TEXT
        # Width of the POOL column
        pool_col_width = x_match - x_pool

        # Width of the pool text
        text_w = draw.textlength(pool, font=table_font)

        # Center horizontally inside the column
        x_text = x_pool + (pool_col_width - text_w) / 2

        # Vertical position as it already is
        y_center = y 

        # Draw centered text (manual centering—no anchor needed)
        draw.text((x_text, y_center), pool, fill="white", font=table_font)


        draw.text((x_match_centered, y), match, fill="white", font=table_font)
        draw.text((x_time - 25, y), time, fill="white", font=table_font)

    # --------------------------------------------------------
    # SAVE OUTPUT
    # --------------------------------------------------------
    out_name = f"{sport}_{gender}_{date.replace('/', '-')}.png"
    out_path = os.path.join(output_folder, out_name)
    combined.save(out_path)
    print(f"✅ Saved: {out_path}")

print("\n🎉 All knockout images generated successfully!")
