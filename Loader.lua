function d(dn) ldit = dn % 10 if ldit == 1 and dn ~= 11 then return 'st' elseif ldit == 2 and dn ~= 12 then return 'nd' elseif ldit == 3 and dn ~= 13 then return 'rd' else return 'th' end; end;
function timef(dtt,dt) dtt = string.gsub(dtt,"%%o",d(dt.day)) return os.date(dtt,os.time(dtdt)) end; u0name = os.date("*t",os.time())
local Fluent = loadstring(game:HttpGet("https://pastebin.com/raw/pngpMWrf"))()
local SaveManager = loadstring(game:HttpGet("https://pastebin.com/raw/gSKcEu81"))()
local InterfaceManager = loadstring(game:HttpGet("https://pastebin.com/raw/pS2Nvew8"))()
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
    Main = Window:AddTab({ Title = "General", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local Options = Fluent.Options do
    local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Auto Teleport to Upstairs", Default = false });Toggle:OnChanged(function(Value)
    _G.Teleport_to_HighestPoint = Value
        while _G.Teleport_to_HighestPoint do wait(0.1)
            for i,v in pairs(game:GetService("Workspace").tower.finishes:GetChildren()) do
                if i == 1 and v.Name == "Finish" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                end;
            end;
        end;
    end);Options.MyToggle:SetValue(false)
    Tabs.Main:AddButton({Title = "Teleport to Upstairs", Callback = function()
        for _,v in pairs(game:GetService("Workspace").tower.finishes:GetChildren()) do
            if _ == 1 and v.Name == "Finish" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
            end;
        end;
    end});
    Tabs.Main:AddButton({Title = "Disable Anticheat", Callback = function()
        for _,v in pairs(getgc()) do
            if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript then
                if debug.getinfo(v).name == "kick" then
                    hookfunction(v, function(...)
                    end);
                end;
            end;
        end;
        for _,v in pairs(getgc()) do
            if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript2 then
                if debug.getinfo(v).name == "FindFirstChild" then
                    hookfunction(v, function(...)
                    end);
                end;
            end;
        end;game:GetService("Players").LocalPlayer.PlayerScripts.LocalPartScript:Destroy()
    end});
    local Input = Tabs.Main:AddInput("Input", {Title = "Walk Speed", Default = "", Numeric = false, Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Text
    end})
    local Input = Tabs.Main:AddInput("Input", {Title = "Power Jump", Default = "", Numeric = false, Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Text
    end})
end;

SaveManager:SetLibrary(Fluent) InterfaceManager:SetLibrary(Fluent) SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({}) InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game") InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings) Window:SelectTab(1) SaveManager:LoadAutoloadConfig()
