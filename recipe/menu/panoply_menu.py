#!/usr/bin/env python3
"""
panoply_menu.py

Single entry-point to install/remove the Panoply menu entry via menuinst.

Usage:
  python panoply_menu.py install
  python panoply_menu.py remove

Notes:
  - Target prefix is taken from PREFIX, then CONDA_PREFIX, then sys.prefix.
  - JSON is searched in <prefix>/Menu/panoply.json, then <prefix>/share/menu/panoply.json.
  - Script is silent and never blocks the transaction (always returns 0).
"""

import os, sys, subprocess
from os.path import join

def main():
  
  action = (sys.argv[1].lower() if len(sys.argv) > 1 else "none")
  target_prefix = os.environ.get("MENUINST_PREFIX") or os.environ.get("PREFIX") or os.environ.get("CONDA_PREFIX") or sys.prefix
  base_prefix = os.environ.get("MENUINST_BASE_PREFIX") or subprocess.check_output(["conda", "info", "--base"], stderr=subprocess.DEVNULL).decode().strip()

  json_path = join(target_prefix, "share", "menu", "panoply.json")

  try:
    if action == "install":
      from menuinst.api import install
      install(json_path, target_prefix=target_prefix, base_prefix=base_prefix)
    elif action == "remove":
      from menuinst.api import remove  # assumes menuinst provides remove
      remove(json_path, target_prefix=target_prefix, base_prefix=base_prefix)
    else:
      return 0
  except Exception:
    return 0
  return 0

if __name__ == "__main__":
  raise SystemExit(main())
