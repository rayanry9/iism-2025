import csv
import re
from datetime import datetime

input_text_file = "./knockout.txt"
output_csv = "./knockout.csv"

# Regex: ignore first number, capture Pool, Team1, Team2, Time
row_pattern = re.compile(
    r"\d+\s+"                      # Match number (ignored)
    r"([A-Za-z0-9]+)\s+"           # Pool/Round name (PQF1, QF1, SF1, FINAL)
    r"(.+?)\s+vs\s+(.+?)\s+"       # Team1 vs Team2
    r"(\d{1,2}:\d{2}\s*[AP]M)",    # Time
    re.IGNORECASE
)

rows = []

with open(input_text_file, "r", encoding="utf-8") as f:
    lines = [line.strip() for line in f if line.strip()]

current_sport = None
current_gender = None
current_date = None

def normalize_time(t):
    """Convert '9:00 AM' -> '09:00 AM'"""
    try:
        dt = datetime.strptime(t.strip().upper(), "%I:%M %p")
        return dt.strftime("%I:%M %p")
    except ValueError:
        return t.strip()
    
for line in lines:

    # SPORT (uppercase)
    if line.isupper() and line not in ["MEN", "WOMEN"]:
        current_sport = line
        continue

    # GENDER
    if line in ["Men", "Women"]:
        current_gender = line
        continue

    # DATE (dd/mm/yyyy)
    if re.match(r"\d{1,2}/\d{1,2}/\d{4}", line):
        current_date = line
        continue

    # Match row
    match = row_pattern.match(line)
    if match:
        pool, team1, team2, time = match.groups()
        time=normalize_time(time)
        rows.append([
            current_sport,
            current_gender,
            current_date,
            pool,
            team1.strip(),
            team2.strip(),
            time.strip()
        ])

# Write CSV
with open(output_csv, "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(
        ["Sport", "Gender", "Date", "Pool", "Team1", "Team2", "Time"]
    )
    writer.writerows(rows)

print("✅ CSV successfully generated:", output_csv)
