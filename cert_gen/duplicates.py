import pandas as pd

# File names
input_file = "data.csv"
output_file = "repeated_names.csv"

# Read CSV
df = pd.read_csv(input_file)

# Identify all rows where name is duplicated
duplicate_mask = df['name'].duplicated(keep=False)

# Filter only duplicate-name rows
duplicates_df = df[duplicate_mask]

# Sort so that same names come together
duplicates_df = duplicates_df.sort_values(by='name')

# Write to output CSV
duplicates_df.to_csv(output_file, index=False)

print(f"Output written to '{output_file}' with duplicate names grouped together.")
