import re
import pandas as pd

input_file = "./athletics.txt"
output_file = "./athletics.csv"

with open(input_file, "r") as f:
    lines = [line.strip() for line in f if line.strip()]

data = []
current_date = None

# Regex patterns
date_pattern = re.compile(r"^\d{1,2}/\d{1,2}/\d{4}$")
line_pattern = re.compile(r"^(\d+)\s+(\d{1,2}:\d{2}\s*[AP]M)\s+(.+)$")

for line in lines:
    # Detect date
    if date_pattern.match(line):
        current_date = line
        continue

    # Detect event row
    match = line_pattern.match(line)
    if match:
        event_no = match.group(1)
        time = match.group(2)
        event_raw = match.group(3)

        # Extract gender (Men/Women/Mixed)
        gender = None
        if "Women" in event_raw:
            gender = "Women"
        elif "Men" in event_raw:
            gender = "Men"
        elif "Mixed" in event_raw:
            gender = "Mixed"
        else:
            gender = "Unknown"

        # Remove gender word from event name
        event_clean = (
            event_raw.replace("Women", "")
                     .replace("Men", "")
                     .replace("Mixed", "")
                     .strip()
        )

        # Append to final data
        data.append([gender, current_date, event_no, event_clean, time])

# Create DataFrame
df = pd.DataFrame(data, columns=["Gender", "Date", "Event_No", "Event", "Time"])

# Save CSV
df.to_csv(output_file, index=False, encoding="utf-8-sig")

print("✅ athletics_clean.csv generated successfully!")
