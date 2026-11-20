# LiquidGlass Flat

A flat version of LiquidGlass: a plain dark and light UI with no glass, blur or intro.
The API is the same as the original (`CreateWindow`, `AddTab`, `AddSection`, `AddToggle` …,
Rayfield/Fluent calls, flags, configs). See `DOCUMENTATION.md` for the full reference.

## Quick start

```lua
local LiquidGlass = loadstring(readfile("LiquidGlass_Flat.lua"))()
local Window = LiquidGlass:CreateWindow({ Title = "My Hub", Theme = "Dark" })
local Tab = Window:AddTab({ Title = "Main", Icon = "home" })
Tab:AddSection("Player"):AddToggle({ Title = "Fly", Callback = print })
Window:AddSettingsTab() -- includes the Dark / Light switch
```

Put `dist/LiquidGlass_Flat.lua` into your executor's workspace folder. A complete example is in `example.lua`.

## Themes

- `LiquidGlass:SetTheme("Dark" | "Light")` switches live. The same switch is in Settings → Appearance.
- `LiquidGlass:SetAccent("#6070FF")` sets the accent color (switches, sliders, buttons).
- Custom themes: `LiquidGlass:AddTheme("Midnight", "Dark", { Glass = Color3.fromRGB(8, 8, 14) })`.
  The colors live in `src/01_core.lua`, in the `THEMES` block: `Glass` is the window, `Card` the sections,
  `Control` fields and buttons, `Pill` the selected segment, and `Border` / `CardBorder` / `ControlBorder` the outlines.

## What changed compared to LiquidGlass

- Surfaces are solid: fill + 1px border + a soft shadow on the window and popovers (`src/03_glass.lua`).
- Blur, the "lens" effect on switches, sliders and segments, the pointer highlight and the 3D intro are gone
  (`src/02_blur.lua` is now a stub, `06b_intro.lua` was removed).
- Smaller corner radii: window 16, cards 12, buttons and fields are rounded rectangles.
- Switches and sliders use the accent color, and the settings tab has no blur toggle.

## Building

```
python build.py   # src/ + assets/pack.lua -> dist/LiquidGlass_Flat.lua
```

Version: 1.0.0-flat. The global name is still `LiquidGlass`; loading the script again replaces the previous copy.

## Original

`dist/LiquidGlass_Glass.lua` is the original glass version, unchanged.
Both versions use the `LiquidGlass` global, so load only one of them in a script.
