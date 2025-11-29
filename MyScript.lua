local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local TeleportCheck = false
local queueTeleport = syn and syn.queue_on_teleport or queue_on_teleport

local function executeScript(url)
    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not ok then
        warn("Script failed:", err)
    end
end

local function getScriptUrl()
    if UserInputService.TouchEnabled then
        return "https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/HyperShotMobiles.lua"
    else
        return "https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/HypershotPc.lua"
    end
end

executeScript(getScriptUrl())

LocalPlayer.OnTeleport:Connect(function()
    if not TeleportCheck and queueTeleport then
        TeleportCheck = true
        queueTeleport("loadstring(game:HttpGet('" .. getScriptUrl() .. "'))()")
    end
end)

TeleportService.TeleportInitFailed:Connect(function(plr)
    if plr == LocalPlayer and queueTeleport then
        queueTeleport("loadstring(game:HttpGet('" .. getScriptUrl() .. "'))()")
        TeleportCheck = false
    end
end)

