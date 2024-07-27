-- Created by Deluxt - https://github.com/DeluxtDev
-- This script will send a message to the all players when someone dies.

-- If you want to change the prefix just change it in this variable.
local prefix = "|cffff0000[Grim Reaper] "

local function OnEvironmentalDeath(event, player, cause)
    if (cause == 0) then
        cause = "exhaustion"
    elseif (cause == 1) then
        cause = "drowning"
    elseif (cause == 2) then
        cause = "falling"
    elseif (cause == 3) then
        cause = "lava"
    elseif (cause == 4) then
        cause = "slime"
    elseif (cause == 5) then
        cause = "fire"
    elseif (cause == 6) then
        cause = "falling into the void"
    end

    SendWorldMessage(prefix.."|cffffffff"..player:GetName().." |cff60a9e4has died from |cffffffff"..cause.."|cff60a9e4.")
end

local function OnDeathByPlayer(event, killer, killed)
    if (killer:GetGUIDLow() == killed:GetGUIDLow()) then
        return
    end
    SendWorldMessage(prefix.."|cffffffff"..killed:GetName().." |cff60a9e4has been murdered by |cffffffff"..killer:GetName().."|cff60a9e4.")
end

local function OnDeathByCreature(event, killer, killed)
    SendWorldMessage(prefix.."|cffffffff"..killed:GetName().." |cff60a9e4has been killed by |cffffffff"..killer:GetName().."|cff60a9e4.")
end

RegisterPlayerEvent(6, OnDeathByPlayer)
RegisterPlayerEvent(8, OnDeathByCreature)
RegisterPlayerEvent(40, OnEvironmentalDeath)