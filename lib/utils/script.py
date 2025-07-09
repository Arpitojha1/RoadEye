import pandas as pd
import json
import os

lane_info = {
    "L1": {"lat": 5, "lon": 6, "roughness": 39, "rutting": 48, "cracking": 55, "ravelling": 64},
    "L2": {"lat": 9, "lon": 10, "roughness": 40, "rutting": 49, "cracking": 56, "ravelling": 65},
    "L3": {"lat": 13, "lon": 14, "roughness": 41, "rutting": 50, "cracking": 57, "ravelling": 66},
    "L4": {"lat": 17, "lon": 18, "roughness": 42, "rutting": 51, "cracking": 58, "ravelling": 67},
    "R1": {"lat": 21, "lon": 22, "roughness": 43, "rutting": 52, "cracking": 59, "ravelling": 68},
    "R2": {"lat": 25, "lon": 26, "roughness": 44, "rutting": 53, "cracking": 60, "ravelling": 69},
    "R3": {"lat": 29, "lon": 30, "roughness": 45, "rutting": 54, "cracking": 61, "ravelling": 70},
    "R4": {"lat": 33, "lon": 34, "roughness": 46, "rutting": 53, "cracking": 62, "ravelling": 71}
}

def is_valid(val):
    return isinstance(val, (int, float)) and pd.notnull(val)

def compute_severity(roughness, rutting, cracking, ravelling):
    return round(0.5 * (roughness / 2400) + 0.2 * (rutting / 5) + 0.15 * cracking + 0.15 * ravelling, 3)

def process_excel(file_path):
    df = pd.read_excel(file_path, skiprows=3, header=None)
    result = []

    for _, row in df.iterrows():
        for lane, info in lane_info.items():
            lat = float(row[info["lat"]]) if is_valid(row[info["lat"]]) else 0.0
            lon = float(row[info["lon"]]) if is_valid(row[info["lon"]]) else 0.0
            roughness = float(row[info["roughness"]]) if info["roughness"] and is_valid(row[info["roughness"]]) else 0.0
            rutting = float(row[info["rutting"]]) if info["rutting"] and is_valid(row[info["rutting"]]) else 0.0
            cracking = float(row[info["cracking"]]) if is_valid(row[info["cracking"]]) else 0.0
            ravelling = float(row[info["ravelling"]]) if is_valid(row[info["ravelling"]]) else 0.0

            # if lat/lon is completely missing (i.e., 0.0, 0.0) — maybe skip?
            if lat == 0.0 and lon == 0.0:
                continue

            severity = compute_severity(roughness, rutting, cracking, ravelling)

            result.append({
                "lane": lane,
                "startLat": lat,
                "startLon": lon,
                "roughness": roughness,
                "rutting": rutting,
                "cracking": cracking,
                "ravelling": ravelling,
                "region": "plains",
                "severity": severity
            })

    return result

def write_json(json_data, json_filename):
    with open(json_filename, 'w') as f:
        json.dump(json_data, f, indent=2)
    print(f"JSON written to {json_filename}")

# === USAGE ===
file_path = input("Enter Excel file path (.xlsx): ").strip()
out_name = input("Enter output JSON filename (without .json): ").strip()

if not os.path.exists(file_path):
    print("File not found.")
    exit(1)

if not file_path.endswith('.xlsx'):
    print("Only .xlsx files are allowed.")
    exit(1)

output_json = out_name + ".json"

data = process_excel(file_path)
write_json(data, output_json)
