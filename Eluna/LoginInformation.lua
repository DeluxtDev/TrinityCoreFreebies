-- Created by Deluxt - https://github.com/DeluxtDev
-- This script will send a message to the player when they login with information about their account and character.

-- If you want a custom message just set this to true and change the customMessage variable.
local useCustomMessage = false
local customMessage = "Placeholder Text"

local function GetAccountInfo(player)
    local accountId = player:GetAccountId()
    local latency = player:GetLatency()
    return "|cff60a9e4Account Id: |cffffffff"..accountId.." |cff60a9e4Latency: |cffffffff"..latency.."ms"
end

local function GetRace(player)
    local races = {
        [1] = "Human",
        [2] = "Orc",
        [3] = "Dwarf",
        [4] = "Night Elf",
        [5] = "Undead",
        [6] = "Tauren",
        [7] = "Gnome",
        [8] = "Troll",
        [10] = "Blood Elf",
        [11] = "Draenei"
    }

    return races[player:GetRace()]
end

local function GetClass(player)
    local classes = {
        [1] = "Warrior",
        [2] = "Paladin",
        [3] = "Hunter",
        [4] = "Rogue",
        [5] = "Priest",
        [6] = "Death Knight",
        [7] = "Shaman",
        [8] = "Mage",
        [9] = "Warlock",
        [11] = "Druid"
    }

    return classes[player:GetClass()]
end

local function GetCharacterInfo(player)
    local name = player:GetName()
    local guid = player:GetGUIDLow()
    local level = player:GetLevel()
    local race = GetRace(player)
    local class = GetClass(player)
    return "|cff60a9e4Character: |cffffffff"..name.." |cff60a9e4Guid: |cffffffff"..guid.." |cff60a9e4Level: |cffffffff"..level.." |cff60a9e4Race: |cffffffff"..race.." |cff60a9e4Class: |cffffffff"..class
end

local function GetOtherInfo(player)
    local coinage = player:GetCoinage()
    local copper = coinage % 100
    local silver = math.floor(coinage / 100) % 100
    local gold = math.floor(coinage / 10000)
    local mail = player:GetMailCount()
    return "|cff60a9e4Money: |cffffffff"..gold.."g "..silver.."s "..copper.."c |cff60a9e4Mail: |cffffffff"..mail
end

local function OnLogin(event, player)
    if (useCustomMessage) then
        player:SendBroadcastMessage("|cff60a9e4"..customMessage)
    end
    player:SendBroadcastMessage("|cff60a9e4--------------------------------------------------------------------------------")
    player:SendBroadcastMessage(GetAccountInfo(player))
    player:SendBroadcastMessage(GetCharacterInfo(player))
    player:SendBroadcastMessage(GetOtherInfo(player))
    player:SendBroadcastMessage("|cff60a9e4--------------------------------------------------------------------------------")
end

RegisterPlayerEvent(3, OnLogin)