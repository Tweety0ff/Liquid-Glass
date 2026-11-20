"""Builds dist/LiquidGlass_Flat.lua from src/*.lua and assets/pack.lua
(icons, shadows and sounds as base64). Needs only Python 3.

    python build.py
"""
import os

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(HERE, "src")
OUT = os.path.join(HERE, "dist", "LiquidGlass_Flat.lua")

assets = open(os.path.join(HERE, "assets", "pack.lua"), encoding="utf-8").read()
source = "\n".join(
    open(os.path.join(SRC, n), encoding="utf-8").read()
    for n in sorted(os.listdir(SRC)) if n.endswith(".lua")
)
assert source.count("--@ASSETS@--") == 1, "asset marker missing"
source = source.replace("--@ASSETS@--", assets)
os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w", encoding="utf-8", newline="\n") as f:
    f.write(source)
print("dist/LiquidGlass_Flat.lua", os.path.getsize(OUT) // 1024, "KB")
