local players = game:GetService("Players")
local plr = players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local mag
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
local bossTable = {
	"Grasslands Warlord",
	"Aetherstone Golem",
	"Bandit Leader",
	"Riddlebones",
	"Wolf Hunter Craftsman",
}
local questTable = {}
local flowersTable = {
	"Fire Lily",
	"Grass",
	"Blue Lily",
	"Mana Flower",
	"Frozen Lily",
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
local function angle(number)
	if number >= 0 then
		return -90
	else
		return 90
	end
end
local FillerNpcs = {}
local Quests = {}
local interactions = {}
local events = {}
task.spawn(function()
	if game.PlaceId == 14839995292 then
		for i, v in next, workspace.Entities.Interactions.FillerNpcs:GetChildren() do
			table.insert(FillerNpcs, v.Name)
		end

		for i, v in next, workspace.Entities.Interactions.Quests:GetChildren() do
			table.insert(Quests, v.Name)
		end

		for i, v in next, workspace.Entities.Interactions["Special Interactions"]:GetChildren() do
			table.insert(interactions, v.Name)
		end

		for i, v in next, workspace.Entities.Interactions.SpecialEvents:GetChildren() do
			table.insert(events, v.Name)
		end
	else
		return
	end
end)
local function checker(object, location, type)
	if type == "mob" then
		if location[object.Name] == true and object.Humanoid.Health > 0 then
			return true
		else
			return false
		end
	elseif type =="flower" then
		if location[object:FindFirstChildOfClass("Model").Name] == true then
			return true
		else
			return false
		end
	elseif type == "boss" then
		if location[object.Name] == true then
			return true
		else
			return false
		end
	end
end
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
local function godmode()
	ReplicatedStorage.ReplicatedPackage.Remotes.Distance:FireServer(0 / 0, 0 / 0, "High")
end
local function autocollect()
	if not Settings.Autocollect.Toggle then
		return
	end
	for i, v in next, workspace.Entities.Interactions.Collectibles.OreSpawn:GetDescendants() do
		if v.Name == "OreSpawn" and v:FindFirstChildOfClass("ProximityPrompt") then
			plr.Character:PivotTo(v:GetPivot())
			mag = (v.Position - plr.Character.HumanoidRootPart.Position).magnitude
			if mag < 15 then
				plr.Character:PivotTo(v:GetPivot())
				v.ProximityPrompt.HoldDuration = 0
				fireproximityprompt(v.ProximityPrompt)
			end
			break
		end
	end
end
local function flowers()
	if not Settings.Autocollect.Flowers then
		return
	end
	for i, v in next, workspace.Entities.Interactions.Collectibles.Flowers:GetDescendants() do
		if v:FindFirstChildOfClass("ProximityPrompt") and checker(v, Settings.Autocollect.Item, "flower") then
			plr.Character:PivotTo(v:GetPivot())
			mag = (v.Position - plr.Character.HumanoidRootPart.Position).magnitude
			if mag < 15 then
				plr.Character:PivotTo(v:GetPivot())
				v.ProximityPrompt.HoldDuration = 0
				fireproximityprompt(v.ProximityPrompt)
			end
			break
		end
	end
end
local function farmplayers()
	if not Settings.Players.Toggle then
		return
	end
	for i, v in next, players:GetChildren() do
		if v ~= plr and v.Character and v.Character.Humanoid.Health > 0 then
			plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
				* CFrame.new(0, Settings.Players.Position, 0)
				* CFrame.Angles(math.rad(angle(Settings.Players.Position)), 0, 0)
			attackremote:FireServer("M1")
		end
	end
end
local function bossnotifier()
	if not Settings.Notifier then
		return
	end
	for i, v in pairs(workspace.Entities.Enemies:GetChildren()) do
		if bossTable[v.Name] then
			game.StarterGui:SetCore("SendNotification", {
				Title = string.format("Boss Spawned: %s", v.Name),
				Text = "",
				Icon = "",
				Duration = 25,
			})
		end
	end
end
local function autoquest()
	if not Settings.Autoquest.Toggle then
		return
	end
end
local function chestfinder(boss)
	for i,v in pairs(workspace.Entities.Events[boss.Name].Chests:GetDescendants()) do
		if v:IsA("Model") and v.Name == "Chest"  and v:FindFirstChildOfClass("ProximityPrompt") then
			plr.Character:PivotTo(v:GetPivot())
			v.ProximityPrompt.HoldDuration = 0
			fireproximityprompt(v.ProximityPrompt)
		end
	end
end
local function bossfarm()
	if not Settings.Bossfarm.Toggle then
		return
	end
	for i, v in pairs(workspace.Entities.Enemies:GetChildren()) do
		if checker(v, Settings.Bossfarm.Boss, "boss") then
			if v.Humanoid.Health > 0 then
				plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
					* CFrame.new(0, Settings.Autofarm.Position, 0)
					* CFrame.Angles(math.rad(angle(Settings.Autofarm.Position)), 0, 0)
				attackremote:FireServer("M1")
			else
				chestfinder(v)
			end
		end
	end
end
local function autospin()
	if not Settings.Autoquest.Toggle then return end;
end
function d(dn)
    ldit = dn % 10
    if ldit == 1 and dn ~= 11
        then return 'st'
    elseif ldit == 2 and dn ~= 12
        then return 'nd'
    elseif ldit == 3 and dn ~= 13
        then return 'rd'
    else
        return 'th'
    end
end
function timef(dtt,dt)
    dtt = string.gsub(dtt,"%%o",d(dt.day))
    return os.date(dtt,os.time(dtdt))
end
u0name = os.date("*t",os.time())
local repo = "https://raw.githubusercontent.com/HTDBarsi/LinoriaLib/main/"
local Library = (loadstring(game:HttpGet(repo .. "Library.lua")))()
local ThemeManager = (loadstring(game:HttpGet("https://raw.githubusercontent.com/SoftworkLHC/Linoria-Library/main/LinoriaLib-main/addons/ThemeManager.lua")))()
local SaveManager = (loadstring(game:HttpGet(repo .. "addons/SaveManager.lua")))()
local Window = Library:CreateWindow({Title = timef("Haeze Hub Classic Scripts - %A, %B %d%o, %Y.", u0name),Center = true,AutoShow = true,TabPadding = 8,MenuFadeTime = 0,})
local Tabs = {Main = Window:AddTab("General"),["Configuration"] = Window:AddTab("Configuration"),}

local TabBox = Tabs.Main:AddLeftTabbox();
local General = TabBox:AddTab('\\\\ General //');
General:AddToggle("Autofarm", {
	Text = "Auto Farm Mob's",
	Default = false,
	Tooltip = "",
	Callback = function(Value)
		Settings.Autofarm.Toggle = Value
	end,
})
General:AddDropdown("MyDropdown", {
	Values = mobs,
	Default = 1,
	Multi = true,
	Text = "Mob's Selected",
	Tooltip = "",
	Callback = function(Value)
		Settings.Autofarm.Mob = Value
	end,
})
General:AddSlider("MySlider", {
	Text = "- Position Farm I",
	Default = 10,
	Min = -15,
	Max = 15,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		Settings.Autofarm.Position = Value
	end,
})
General:AddToggle("Autofarm", {
	Text = "Auto Farm Bosse's",
	Default = false,
	Tooltip = "",
	Callback = function(Value)
		Settings.Bossfarm.Toggle = Value
	end,
})
General:AddDropdown("MyDropdown", {
	Values = bossTable,
	Default = 1,
	Multi = true,
	Text = "Bosse's Selected",
	Tooltip = "",
	Callback = function(Value)
		Settings.Bossfarm.Boss = Value
	end,
})
General:AddSlider("MySlider", {
	Text = "- Position Farm II",
	Default = 10,
	Min = -15,
	Max = 15,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		Settings.Bossfarm.Position = Value
	end,
})
General:AddToggle("Autofarm", {
	Text = "Auto Farm Ore's",
	Default = false,
	Tooltip = "",
	Callback = function(Value)
		Settings.Autocollect.Toggle = Value
	end,
})
General:AddToggle("Autofarm", {
	Text = "Auto Farm Flower's",
	Default = false,
	Tooltip = "",
	Callback = function(Value)
		Settings.Autocollect.Flowers = Value
	end,
})
General:AddDropdown("MyDropdown", {
	Values = flowersTable,
	Default = 1,
	Multi = true,
	Text = "Flower's Selected",
	Tooltip = "",
	Callback = function(Value)
		Settings.Autocollect.Item = Value
	end,
})
General:AddToggle("Autofarm", {
	Text = "Auto Farm Player's",
	Default = false,
	Tooltip = "",
	Callback = function(Value)
		Settings.Players.Toggle = Value
	end,
})
General:AddSlider("MySlider", {
	Text = "- Position Farm III",
	Default = 10,
	Min = -15,
	Max = 15,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		Settings.Players.Position = Value
	end,
})

local TabBox = Tabs.Main:AddLeftTabbox();
local Miscellaneous = TabBox:AddTab('\\\\ Miscellaneous //');
Miscellaneous:AddDropdown("MyDropdown", {
	Values = FillerNpcs,
	Default = 1,
	Multi = false,
	Text = "Filler Npc's Teleport",
	Tooltip = "",
	Callback = function(Value)
		plr.Character:PivotTo(workspace.Entities.Interactions.FillerNpcs[Value]:GetPivot())
	end,
})
Miscellaneous:AddDropdown("MyDropdown", {
	Values = Quests,
	Default = 1,
	Multi = false,
	Text = "Quest's Teleport",
	Tooltip = "",
	Callback = function(Value)
		plr.Character:PivotTo(workspace.Entities.Interactions.Quests[Value]:GetPivot())
	end,
})
Miscellaneous:AddDropdown("MyDropdown", {
	Values = interactions,
	Default = 1,
	Multi = false,
	Text = "Special interraction's Teleport",
	Tooltip = "",
	Callback = function(Value)
		plr.Character:PivotTo(workspace.Entities.Interactions["Special Interactions"][Value]:GetPivot())
	end,
})
Miscellaneous:AddDropdown("MyDropdown", {
	Values = events,
	Default = 1,
	Multi = false,
	Text = "Special Event's Teleport",
	Tooltip = "",
	Callback = function(Value)
		lr.Character:PivotTo(workspace.Entities.Interactions.SpecialEvents[Value]:GetPivot())
	end,
})
local MyButton = Miscellaneous:AddButton({
	Text = "Immortal Mode [Risk]",
	Func = function()
		godmode()
	end,
	DoubleClick = false,
	Tooltip = "",
})
Miscellaneous:AddToggle("Autofarm", {
	Text = "Bosse's Spawned Notifier",
	Default = false,
	Tooltip = "",
	Callback = function(Value)
		Settings.Notifier = Value
	end,
})

local MenuGroup = Tabs['Configuration']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['Configuration'])
ThemeManager:ApplyToTab(Tabs['Configuration'])
SaveManager:LoadAutoloadConfig()
game:GetService("RunService").Heartbeat:connect(function()
	task.spawn(function()
		autocollect()
		flowers()
		mobfarm()
		farmplayers()
		bossnotifier()
	end)
end)
