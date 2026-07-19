#!/usr/bin/env python3
"""
Quick WakaTime API request tool.

Usage:
    python run.py /api/v1/users/current/all_time_since_today ./out
    python run.py /api/v1/users/current/summaries ./out --api-key waka_xxxx

The output directory must already exist. Output is printed to the
terminal AND written to <output_dir>/output.json, overwriting it on
every run.

API key resolution order:
    1. --api-key flag
    2. WAKATIME_API_KEY environment variable
    3. api.txt file in the current directory (key must start with "waka_")
"""

import argparse
import base64
import json
import os
import sys
import urllib.error
import urllib.request

BASE_URL = "https://api.wakatime.com"
API_KEY_FILE = "api.txt"


def read_api_key_file():
    if not os.path.isfile(API_KEY_FILE):
        print(f"Error: {API_KEY_FILE} not found.", file=sys.stderr)
        print(
            f"Create {API_KEY_FILE} in the current directory containing your "
            "WakaTime API key, or pass --api-key / set WAKATIME_API_KEY.",
            file=sys.stderr,
        )
        sys.exit(1)

    with open(API_KEY_FILE, "r") as f:
        key = f.read().strip()

    if not key.startswith("waka_"):
        print(
            f"Error: key in {API_KEY_FILE} doesn't look like a valid WakaTime API key.",
            file=sys.stderr,
        )
        print("Expected it to start with 'waka_'.", file=sys.stderr)
        sys.exit(1)

    return key


def main():
    parser = argparse.ArgumentParser(description="Make a request to the WakaTime API")
    parser.add_argument(
        "path", help="API path, e.g. /api/v1/users/current/all_time_since_today"
    )
    parser.add_argument(
        "output_dir", help="Existing directory to write output.json into"
    )
    parser.add_argument(
        "--api-key", help="WakaTime API key (overrides WAKATIME_API_KEY env var)"
    )
    args = parser.parse_args()

    if not os.path.isdir(args.output_dir):
        print(
            f"Error: output directory does not exist: {args.output_dir}",
            file=sys.stderr,
        )
        sys.exit(1)

    output_path = os.path.join(args.output_dir, "output.json")

    api_key = args.api_key or os.environ.get("WAKATIME_API_KEY")

    if api_key and not api_key.startswith("waka_"):
        print(
            "Error: provided API key doesn't look like a valid WakaTime API key.",
            file=sys.stderr,
        )
        print("Expected it to start with 'waka_'.", file=sys.stderr)
        sys.exit(1)

    if not api_key:
        api_key = read_api_key_file()

    path = args.path if args.path.startswith("/") else f"/{args.path}"
    url = f"{BASE_URL}{path}"

    encoded_key = base64.b64encode(api_key.encode("utf-8")).decode("utf-8")

    request = urllib.request.Request(
        url,
        headers={
            "Authorization": f"Basic {encoded_key}",
            "Content-Type": "application/json",
        },
    )

    print(f"GET {url}\n", file=sys.stderr)

    try:
        with urllib.request.urlopen(request, timeout=15) as response:
            status = response.status
            body = response.read().decode("utf-8")
    except urllib.error.HTTPError as e:
        status = e.code
        body = e.read().decode("utf-8")
    except urllib.error.URLError as e:
        print(f"Request failed: {e.reason}", file=sys.stderr)
        sys.exit(1)

    print(f"Status: {status}", file=sys.stderr)

    try:
        parsed = json.loads(body)
        pretty = json.dumps(parsed, indent=2)
        print(pretty)
    except json.JSONDecodeError:
        pretty = body
        print(pretty)

    with open(output_path, "w") as f:
        f.write(pretty)

    print(f"\nWritten to {output_path}", file=sys.stderr)


if __name__ == "__main__":
    main()
