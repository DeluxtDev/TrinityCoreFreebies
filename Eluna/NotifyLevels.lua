-- Created by Deluxt - https://github.com/DeluxtDev
-- This script will send a message to the all players when someone levels up.

-- If you want to announce this every level set it to false.
local maxLevelOnly = true
-- If your max level isnt 80 change this.
local maxLevel = 80

local function AnnounceMaxLevel(player)
    if (player:GetLevel() == maxLevel) then
        SendWorldMessage("|cff60a9e4Congratulations to |cffffffff"..player:GetName().."|cff60a9e4 for reaching level |cffffffff"..maxLevel.."|cff60a9e4!")
    end
end

local function OnLevelUp(event, player, oldLevel)
    if (maxLevelOnly) then
        AnnounceMaxLevel(player)
    else
        level = oldLevel + 1
        SendWorldMessage("|cff60a9e4Congratulations to |cffffffff"..player:GetName().."|cff60a9e4 for reaching level |cffffffff"..level.."|cff60a9e4!")
    end
end

RegisterPlayerEvent(13, OnLevelUp)
