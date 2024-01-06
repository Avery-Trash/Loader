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
	if not Set.Autofarm.Toggle then
		return
	end
	for i, v in next, workspace.Entities.Enemies:GetChildren() do
		if checker(v, Set.Autofarm.Mob, "mob") then
			plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
				* CFrame.new(0, Set.Autofarm.Position, 0)
				* CFrame.Angles(math.rad(angle(Set.Autofarm.Position)), 0, 0)
			attackremote:FireServer("M1")
		end
	end
end

local function godmode()
	ReplicatedStorage.ReplicatedPackage.Remotes.Distance:FireServer(0 / 0, 0 / 0, "High")
end

local function autocollect()
	if not Set.Autocollect.Toggle then
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
	if not Set.Autocollect.Flowers then
		return
	end
	for i, v in next, workspace.Entities.Interactions.Collectibles.Flowers:GetDescendants() do
		if v:FindFirstChildOfClass("ProximityPrompt") and checker(v, Set.Autocollect.Item, "flower") then
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
	if not Set.Players.Toggle then
		return
	end
	for i, v in next, players:GetChildren() do
		if v ~= plr and v.Character and v.Character.Humanoid.Health > 0 then
			plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
				* CFrame.new(0, Set.Players.Position, 0)
				* CFrame.Angles(math.rad(angle(Set.Players.Position)), 0, 0)
			attackremote:FireServer("M1")
		end
	end
end

local function bossnotifier()
	if not Set.Notifier then
		return
	end
	for i, v in pairs(workspace.Entities.Enemies:GetChildren()) do
		if bossTable[v.Name] then
			game.StarterGui:SetCore("SendNotification", {
				Title = string.format("Boss Spawned: %s", v.Name), -- the title (ofc)
				Text = "", -- what the text says (ofc)
				Icon = "", -- the image if u want.
				Duration = 25, -- how long the notification should in secounds
			})
		end
	end
end

local function autoquest()
	if not Set.Autoquest.Toggle then
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
	if not Set.Bossfarm.Toggle then
		return
	end
	for i, v in pairs(workspace.Entities.Enemies:GetChildren()) do
		if checker(v, Set.Bossfarm.Boss, "boss") then
			if v.Humanoid.Health > 0 then
				plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
					* CFrame.new(0, Set.Autofarm.Position, 0)
					* CFrame.Angles(math.rad(angle(Set.Autofarm.Position)), 0, 0)
				attackremote:FireServer("M1")
			else
				chestfinder(v)
			end
		end
	end
end

local function autospin()
	if not  Set.Autoquest.Toggle then return end;
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
    General = Window:AddTab({ Title = "General", Icon = "" }),
	Miscellaneous = Window:AddTab({ Title = "Miscellaneous", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options do
    local Toggle = Tabs.General:AddToggle("MyToggle", {Title = "Mob Farm toggle", Default = false });Toggle:OnChanged(function(Value)
		Set.Autofarm.Toggle = Value
    end);Options.MyToggle:SetValue(false)
	local Dropdown = Tabs.General:AddDropdown("Dropdown", {Title = "Mobs",Values = {mobs},Multi = true,Default = 1,});Dropdown:OnChanged(function(Value)
		Set.Autofarm.Mob = Value
    end);
	local Slider = Tabs.General:AddSlider("Slider", {Title = "Position",Description = "",Default = 10,Min = -15,Max = 15,Rounding = 0,Callback = function(Value)
        Set.Autofarm.Position = Value
    end});Slider:SetValue(10)
	local Toggle = Tabs.General:AddToggle("MyToggle", {Title = "Boss Farm toggle", Default = false });Toggle:OnChanged(function(Value)
		Set.Bossfarm.Toggle = Value
    end);Options.MyToggle:SetValue(false)
	local Dropdown = Tabs.General:AddDropdown("Dropdown", {Title = "Mobs",Values = {bossTable},Multi = true,Default = 1,});Dropdown:OnChanged(function(Value)
		Set.Bossfarm.Boss = Value
    end);
	local Slider = Tabs.General:AddSlider("Slider", {Title = "Position",Description = "",Default = 10,Min = -15,Max = 15,Rounding = 0,Callback = function(Value)
        Set.Bossfarm.Position = Value
    end});Slider:SetValue(10)
	local Toggle = Tabs.General:AddToggle("MyToggle", {Title = "Ore Farm toggle", Default = false });Toggle:OnChanged(function(Value)
		Set.Autocollect.Toggle = Value
    end);Options.MyToggle:SetValue(false)
	local Toggle = Tabs.General:AddToggle("MyToggle", {Title = "Flower Farm toggle", Default = false });Toggle:OnChanged(function(Value)
		Set.Autocollect.Flowers = Value
    end);Options.MyToggle:SetValue(false)
	local Dropdown = Tabs.General:AddDropdown("Dropdown", {Title = "Flowers",Values = {flowersTable},Multi = true,Default = 1,});Dropdown:OnChanged(function(Value)
		Set.Autocollect.Item = Value
    end);
	local Toggle = Tabs.General:AddToggle("MyToggle", {Title = "Player Farm toggle", Default = false });Toggle:OnChanged(function(Value)
		Set.Players.Toggle = Value
    end);Options.MyToggle:SetValue(false)
	local Slider = Tabs.General:AddSlider("Slider", {Title = "Position",Description = "",Default = 10,Min = -15,Max = 15,Rounding = 0,Callback = function(Value)
        Set.Players.Position = Value
    end});Slider:SetValue(10)
-- ////////////////////////////////////////////////////////// --
	local Dropdown = Tabs.Miscellaneous:AddDropdown("Dropdown", {Title = "Filler Npcs TP",Values = {FillerNpcs},Multi = false,Default = 1,});Dropdown:OnChanged(function(Value)
		plr.Character:PivotTo(workspace.Entities.Interactions.FillerNpcs[Value]:GetPivot())
    end);
	local Dropdown = Tabs.Miscellaneous:AddDropdown("Dropdown", {Title = "Quests TP",Values = {Quests},Multi = false,Default = 1,});Dropdown:OnChanged(function(Value)
		plr.Character:PivotTo(workspace.Entities.Interactions.Quests[Value]:GetPivot())
    end);
	local Dropdown = Tabs.Miscellaneous:AddDropdown("Dropdown", {Title = "Special interractions TP",Values = {interactions},Multi = false,Default = 1,});Dropdown:OnChanged(function(Value)
		plr.Character:PivotTo(workspace.Entities.Interactions["Special Interactions"][Value]:GetPivot())
    end);
	local Dropdown = Tabs.Miscellaneous:AddDropdown("Dropdown", {Title = "Special Events TP",Values = {events},Multi = false,Default = 1,});Dropdown:OnChanged(function(Value)
		lr.Character:PivotTo(workspace.Entities.Interactions.SpecialEvents[Value]:GetPivot())
    end);
	Tabs.Miscellaneous:AddButton({Title = "Godmode",Description = "",Callback = function()
		godmode()
    end})
	local Toggle = Tabs.Miscellaneous:AddToggle("MyToggle", {Title = "Boss notifier", Default = false });Toggle:OnChanged(function(Value)
		Set.Notifier = Value
    end);Options.MyToggle:SetValue(false)
end

game:GetService("RunService").Heartbeat:connect(function()
	task.spawn(function()
		autocollect()
		flowers()
		mobfarm()
		farmplayers()
		bossnotifier()
	end)
end)

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
