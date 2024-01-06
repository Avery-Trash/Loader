function d(dn) ldit = dn % 10 if ldit == 1 and dn ~= 11 then return 'st' elseif ldit == 2 and dn ~= 12 then return 'nd' elseif ldit == 3 and dn ~= 13 then return 'rd' else return 'th' end; end;
function timef(dtt,dt) dtt = string.gsub(dtt,"%%o",d(dt.day)) return os.date(dtt,os.time(dtdt)) end; u0name = os.date("*t",os.time())
local Rayfield = loadstring(game:HttpGet('https://pastebin.com/raw/q3wPsexy'))()
local Window = Rayfield:CreateWindow({Name = timef("Haeze Hub Normal Edition - %A, %B %d%o, %Y.", u0name)})
local Tab = Window:CreateTab("General", 4483362458)
local Section = Tab:CreateSection("General")

local Toggle = Tab:CreateToggle({Name = "Auto Teleport to Highest Point", CurrentValue = false, Callback = function(Value)
_G.Teleport_to_Highest_Point = Value
    while _G.Teleport_to_Highest_Point do wait(0.1)
        for i,v in pairs(game:GetService("Workspace").tower.finishes:GetChildren()) do
            if i == 1 and v.Name == "Finish" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
            end
        end
    end
end})
local Button = Tab:CreateButton({Name = "Teleport to Highest Point", Callback = function()
    for _,v in pairs(game:GetService("Workspace").tower.finishes:GetChildren()) do
        if _ == 1 and v.Name == "Finish" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
        end
    end
end})
local Button = Tab:CreateButton({Name = "Disable Anticheat", Callback = function()
for _,v in pairs(getgc()) do
    if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript then
        if debug.getinfo(v).name == "kick" then
        hookfunction(v, function(...)
            end)
        end
    end
end
for _,v in pairs(getgc()) do
    if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript2 then
        if debug.getinfo(v).name == "FindFirstChild" then
        hookfunction(v, function(...)
            end)
        end
    end
end
game:GetService("Players").LocalPlayer.PlayerScripts.LocalPartScript:Destroy()
end})
local Toggle = Tab:CreateToggle({Name = "Infinity Jump", CurrentValue = false, Callback = function(Value)
_G.Infinity_Jump = value
    game:GetService("UserInputService").JumpRequest:connect(function()
        if _G.Infinity_Jump == true then
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
end})
local Input = Tab:CreateInput({Name = "Walk Speed", PlaceholderText = "Walk Speed", RemoveTextAfterFocusLost = false, Callback = function(Text)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Text
end})
local Input = Tab:CreateInput({Name = "Jump Power", PlaceholderText = "Jump Power", RemoveTextAfterFocusLost = false, Callback = function(Text)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Text
end})
