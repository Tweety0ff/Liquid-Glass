-- Example script for LiquidGlass_Flat (dark / light theme)
-- Put the library file into your executor's workspace folder and load it like this:
local LiquidGlass = loadstring(readfile("LiquidGlass_Flat.lua"))()
-- or, if you host it on GitHub:
-- local LiquidGlass = loadstring(game:HttpGet("https://raw.githubusercontent.com/<user>/<repo>/main/LiquidGlass_Flat.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function humanoid()
	local char = LocalPlayer.Character
	return char and char:FindFirstChildOfClass("Humanoid")
end

local Window = LiquidGlass:CreateWindow({
	Title = "My Hub",
	Subtitle = "v1.0",
	Icon = "layers",
	Size = Vector2.new(700, 480),
	Theme = "Dark",                       -- "Dark" or "Light"; can be changed later in Settings
	Accent = "#6070FF",
	ToggleKey = Enum.KeyCode.RightControl, -- hide / show the window
})

---------------------------------------------------------------------------
-- Player
---------------------------------------------------------------------------
local Player = Window:AddTab({ Title = "Player", Icon = "user" })

local Move = Player:AddSection("Movement")

Move:AddSlider({
	Title = "Walk speed", Min = 16, Max = 200, Default = 16, Step = 1, Flag = "walkspeed",
	Callback = function(v)
		local h = humanoid()
		if h then h.WalkSpeed = v end
	end,
})

Move:AddSlider({
	Title = "Jump power", Min = 50, Max = 300, Default = 50, Step = 5, Flag = "jump",
	Callback = function(v)
		local h = humanoid()
		if h then
			h.UseJumpPower = true
			h.JumpPower = v
		end
	end,
})

local infJump = false
Move:AddToggle({
	Title = "Infinite jump", Description = "Jump again while in the air", Flag = "infjump",
	Callback = function(on) infJump = on end,
})
game:GetService("UserInputService").JumpRequest:Connect(function()
	local h = humanoid()
	if infJump and h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Move:AddKeybind({
	Title = "Fly", Default = "F", Flag = "flykey",
	Callback = function(on)
		LiquidGlass:Notify({ Title = on and "Fly ON" or "Fly OFF", Type = on and "Success" or "Info", Duration = 2 })
	end,
})

local Actions = Player:AddSection("Actions")
Actions:AddButtons({
	{ Title = "Reset", Style = "Destructive", Icon = "refresh", Callback = function()
		local h = humanoid()
		if h then h.Health = 0 end
	end },
	{ Title = "Copy name", Icon = "copy", Callback = function()
		if setclipboard then setclipboard(LocalPlayer.Name) end
		LiquidGlass:Notify({ Title = "Copied", Content = LocalPlayer.Name, Type = "Success", Duration = 2 })
	end },
})

---------------------------------------------------------------------------
-- Visuals
---------------------------------------------------------------------------
local Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Esp = Visuals:AddSection("ESP")

Esp:AddToggle({ Title = "Enabled", Flag = "esp", Callback = function(on) print("ESP", on) end })
Esp:AddColorPicker({ Title = "Color", Default = Color3.fromRGB(255, 80, 80), Flag = "espcolor" })
Esp:AddDropdown({
	Title = "Targets", Options = { "Players", "NPCs", "Items" },
	Multi = true, Default = { "Players" }, Flag = "esptargets",
})
Esp:AddSegmented({ Title = "Style", Options = { "Box", "Outline", "Glow" }, Default = "Box", Flag = "espstyle" })

local World = Visuals:AddSection("World")
World:AddSlider({
	Title = "Field of view", Min = 50, Max = 120, Default = 70, Suffix = "°", Flag = "fov",
	Callback = function(v) workspace.CurrentCamera.FieldOfView = v end,
})
World:AddToggle({
	Title = "Fullbright", Flag = "fullbright",
	Callback = function(on)
		local L = game:GetService("Lighting")
		L.Brightness = on and 3 or 1
		L.GlobalShadows = not on
	end,
})

---------------------------------------------------------------------------
-- Misc
---------------------------------------------------------------------------
local Misc = Window:AddTab({ Title = "Misc", Icon = "sliders" })
local Tools = Misc:AddSection("Tools")

local names = {}
for _, p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then table.insert(names, p.Name) end
end
Tools:AddDropdown({ Title = "Teleport to player", Options = names, Searchable = true, Icon = "target" })

Tools:AddInput({
	Title = "Chat message", Placeholder = "Text…", Flag = "msg",
	Callback = function(text) print("input:", text) end,
})

Tools:AddButton({
	Title = "Dialog test", Description = "Opens a confirmation dialog", Icon = "info",
	Callback = function()
		Window:Dialog({
			Title = "Continue?",
			Content = "This is just an example dialog.",
			Icon = "warning",
			Buttons = {
				{ Title = "Cancel", Style = "Cancel" },
				{ Title = "OK", Style = "Primary", Callback = function()
					LiquidGlass:Notify({ Title = "Done", Type = "Success", Duration = 3 })
				end },
			},
		})
	end,
})

---------------------------------------------------------------------------
-- Settings: Dark/Light theme, accent color, scale, configs, unload
---------------------------------------------------------------------------
Window:AddSettingsTab()

LiquidGlass:Notify({
	Title = "Loaded", Content = "Press Right Ctrl to hide or show the window.",
	Type = "Success", Duration = 4,
})
