#!/usr/bin/env python3
import requests
import hashlib
import re
from pathlib import Path

def get_latest_release_info():
    """
    Fetch latest release info from GitHub API
    Returns (version, tarball_url) or raises exception
    """
    api_url = "https://api.github.com/repos/nicolaygerold/shell-sage/releases/latest"
    response = requests.get(api_url)
    response.raise_for_status()

    data = response.json()
    version = data['tag_name'].lstrip('v')
    tarball_url = f"https://github.com/nicolaygerold/shell-sage/archive/refs/tags/v{version}.tar.gz"

    return version, tarball_url

def calculate_sha256(url):
    """
    Download tarball and calculate SHA256
    Returns hash string or raises exception
    """
    response = requests.get(url, stream=True)
    response.raise_for_status()

    sha256_hash = hashlib.sha256()
    for chunk in response.iter_content(chunk_size=8192):
        sha256_hash.update(chunk)

    return sha256_hash.hexdigest()

def update_formula(formula_path, version, tarball_url, sha256):
    """
    Update the formula file with new version and SHA256
    Only updates the top-level shell-sage URL and its SHA256
    """
    content = Path(formula_path).read_text()

    # Split pattern into two parts to avoid backreference issues
    url_pattern = r'^\s+url "https://github\.com/nicolaygerold/shell-sage/archive/refs/tags/v[^"]+\.tar\.gz"'
    sha_pattern = r'^\s+sha256 "[a-f0-9]{64}"'

    # First replace the URL
    new_content = re.sub(
        url_pattern,
        f'    url "https://github.com/nicolaygerold/shell-sage/archive/refs/tags/v{version}.tar.gz"',
        content,
        count=1,
        flags=re.MULTILINE
    )

    # Then replace the SHA256
    new_content = re.sub(
        sha_pattern,
        f'    sha256 "{sha256}"',
        new_content,
        count=1,
        flags=re.MULTILINE
    )

    if new_content == content:
        raise ValueError("No changes made to formula file")

    Path(formula_path).write_text(new_content)

def main():
    try:
        formula_path = "shell_sage.rb"

        # Get latest release info
        version, tarball_url = get_latest_release_info()
        print(f"Found latest version: {version}")

        # Calculate SHA256
        sha256 = calculate_sha256(tarball_url)
        print(f"Calculated SHA256: {sha256}")

        # Update formula
        update_formula(formula_path, version, tarball_url, sha256)
        print(f"Updated {formula_path} successfully!")

    except requests.exceptions.RequestException as e:
        print(f"Error fetching data: {e}")
        return 1
    except IOError as e:
        print(f"Error reading/writing file: {e}")
        return 1
    except Exception as e:
        print(f"Unexpected error: {e}")
        return 1

    return 0

if __name__ == "__main__":
    exit(main())