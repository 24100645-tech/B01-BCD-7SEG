
import json
import sys
from pathlib import Path

def main():
    if len(sys.argv) != 2:
        print("Cach dung: python3 doc_metrics.py metrics.json")
        sys.exit(1)

    file_path = Path(sys.argv[1])

    if not file_path.is_file():
        print(f"Khong tim thay file: {file_path}")
        sys.exit(1)

    with file_path.open("r", encoding="utf-8") as f:
        metrics = json.load(f)

    print("===== CAC CHI SO RTL-to-GDSII =====")

    for key, value in metrics.items():
        if isinstance(value, (str, int, float, bool)):
            print(f"{key}: {value}")

if __name__ == "__main__":
    main()