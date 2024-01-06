local players = game:GetService("Players")
local plr = players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local attackremote = ReplicatedStorage.ReplicatedPackage.Remotes.action
local mobs = {
	"Bandit",
	"Lowly Goblin",
	"Mage Apprentice",
	"Ogre",
	"Shadow Hand Goon",
	"Seasoned Mercenary",
	"Alpha Wolf",
	"Vennum",
	"Wind Monk",
	"Wolf",
	"Wolf Hunter",
	"Yetti",
}
local Settings = {
	Autofarm = {
		Toggle = false,
		Position = 10,
		Mob = "",
	},
	Autocollect = {
		Toggle = false,
		Flowers = false,
		Item = "Grass",
	},
	Players = {
		Toggle = false,
		Position = 10,
	},
	Notifier = true,
	Autoquest = {
		Toggle = false,
		Position = 10,
		Quest = "",
	},
	Bossfarm = {
		Toggle = false,
		Position = 10,
		Boss = "",
	},
}
local function mobfarm()
	if not Settings.Autofarm.Toggle then
		return
	end
	for i, v in next, workspace.Entities.Enemies:GetChildren() do
		if checker(v, Settings.Autofarm.Mob, "mob") then
			plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
				* CFrame.new(0, Settings.Autofarm.Position, 0)
				* CFrame.Angles(math.rad(angle(Settings.Autofarm.Position)), 0, 0)
			attackremote:FireServer("M1")
		end
	end
end
function d(dn) ldit = dn % 10 if ldit == 1 and dn ~= 11 then return 'st' elseif ldit == 2 and dn ~= 12 then return 'nd' elseif ldit == 3 and dn ~= 13 then return 'rd' else return 'th' end; end;
function timef(dtt,dt) dtt = string.gsub(dtt,"%%o",d(dt.day)) return os.date(dtt,os.time(dtdt)) end; u0name = os.date("*t",os.time())
local Fluent = loadstring(game:HttpGet("https://pastebin.com/raw/pngpMWrf"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--  - %A, %B %d%o, %Y.
local Window = Fluent:CreateWindow({
    Title = timef("Haeze Hub Normal Scripts", u0name),
    SubTitle = "by Elitad // H4eze",
    TabWidth = 125,
    Size = UDim2.fromOffset(540, 430),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options do
    local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Mob Farm toggle", Default = false });Toggle:OnChanged(function()
        Settings.Autofarm.Toggle = Value
    end);Options.MyToggle:SetValue(false)
    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {Title = "Mobs",Values = {mobs},Multi = false, Default = 1});Dropdown:OnChanged(function(Value)
        Settings.Autofarm.Mob = Value
    end);
    local Slider = Tabs.Main:AddSlider("Slider", {Title = "Position",Default = 10,Min = -15,Max = 15,Rounding = 0,Callback = function(Value)
        Settings.Autofarm.Position = Value
    end});Slider:SetValue(10)
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
