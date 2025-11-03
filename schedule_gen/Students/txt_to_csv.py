import re
import pandas as pd
from datetime import datetime

input_file = "./data.txt"
output_file = "./matches.csv"

# Read the text file
with open(input_file, "r", encoding="utf-8") as f:
    text = f.read()

# Split the text into lines
lines = [line.strip() for line in text.split("\n") if line.strip()]

data = []
current_sport = None
current_gender = None
current_date = None

# Regex for extracting match info
# pattern = re.compile(r"\d+\s+([A-Z0-9]+)\s+([A-Za-z() ]+)\s+v[ sS]+\s+([A-Za-z() ]+)\s+(\d{1,2}:\d{2}\s*[AP]M)")
pattern = re.compile(
    r"\d+\s+([A-Z0-9]+)\s+([A-Za-z() ]+)\s+VS?\s+([A-Za-z() ]+)\s+(\d{1,2}:\d{2}\s*[AP]M)",
    flags=re.IGNORECASE
)

def normalize_time(t):
    """Convert '9:00 AM' -> '09:00 AM'"""
    try:
        dt = datetime.strptime(t.strip().upper(), "%I:%M %p")
        return dt.strftime("%I:%M %p")
    except ValueError:
        return t.strip()
    
for line in lines:
    # Detect headers
    if re.match(r"^[A-Z]+$", line):  # Sport name (e.g., CRICKET)
        current_sport = line
    elif line.lower() in ["men", "women"]:
        current_gender = line.capitalize()
    elif re.match(r"\d{1,2}/\d{1,2}/\d{4}", line):  # Date
        current_date = line
    else:
        # Match game lines
        match = pattern.search(line)
        if match:
            pool, team1, team2, time = match.groups()
            time=normalize_time(time)
            match_str = f"IIT {team1.strip()} VS IIT {team2.strip()}"
            data.append([current_sport, current_gender, current_date, pool, match_str, time])

# Create DataFrame
df = pd.DataFrame(data, columns=["Sport", "Gender", "Date", "Pool", "Match", "Time"])

# Save to CSV
df.to_csv(output_file, index=False, encoding="utf-8-sig")

print(f"✅ Data successfully extracted and saved to {output_file}")
# print(df.head(10))
