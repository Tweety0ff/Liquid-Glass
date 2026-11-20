---------------------------------------------------------------------------
-- Backdrop blur: not used by the flat design. The stub keeps the old API
-- (regions, SetTarget, SetBlur) alive so nothing else has to change.
---------------------------------------------------------------------------
local camera = workspace.CurrentCamera -- shared with the window and tab bar code

local Region = {}
Region.__index = Region

function Region:SetTarget() end
function Region:Remove() end

Blur.regions = {}

function Blur.attach()
	camera = workspace.CurrentCamera or camera
end
Util.track(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(Blur.attach))

function Blur.add()
	return setmetatable({}, Region)
end

function Library:SetBlur(on)
	Library.Settings.Blur = on and true or false
end
