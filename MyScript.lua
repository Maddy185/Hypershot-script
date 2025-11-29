local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local TeleportCheck = false
local queueTeleport = syn and syn.queue_on_teleport or queue_on_teleport

local SCRIPT_URL = "https://raw.githubusercontent.com/Maddy185/Hypershot-script/refs/heads/main/MyScript.lua"

local function executeScript()
    local ok, err = pcall(function()
        loadstring(game:HttpGet(SCRIPT_URL))()
    end)
    if not ok then
        warn("Script failed:", err)
    end
end

executeScript()

LocalPlayer.OnTeleport:Connect(function()
    if not TeleportCheck and queueTeleport then
        TeleportCheck = true
        queueTeleport("loadstring(game:HttpGet('" .. SCRIPT_URL .. "'))()")
    end
end)

TeleportService.TeleportInitFailed:Connect(function(plr)
    if plr == LocalPlayer and queueTeleport then
        queueTeleport("loadstring(game:HttpGet('" .. SCRIPT_URL .. "'))()")
        TeleportCheck = false
    end
end)
