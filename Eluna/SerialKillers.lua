-- Created by Deluxt - https://github.com/DeluxtDev
-- This script will display the top 10 players with the most kills in the gossip menu of a creature.
-- The creatureId is the entry of the creature that will display the gossip menu.
local creatureId = 100003
-- This is our that will hold all of our data.
local killData = {}
-- This is the last time the cache was updated.
local lastCached = 0
-- This is the timer for how long the cache will last before it's considered stale in milliseconds. (5 minutes by default)
local cacheExpiration = 300000

-- Upates the kill data.
local function UpdateKillData()
    -- Check to see if the cached data is stale.
    if (GetCurrTime() - lastCached <= cacheExpiration) then return end

    -- Clear the old data.
    killData = {}

    -- If data is stale we fetch fresh data.
    local results = CharDBQuery("SELECT `name`, `totalKills` FROM `characters` ORDER BY `totalKills` DESC LIMIT 10;")
    if (results) then
        repeat
            table.insert(killData, {
                name = results:GetString(0),
                kills = results:GetUInt32(1)
            })
        until not results:NextRow()
        -- Update the last cached time.
        lastCached = GetCurrTime()
    else
        -- If we can't fetch data from the database we print an error.
        PrintError("[Top10SerialKillers] Error fetching data from database.")
    end
end

local function OnGossipHello(event, player, object)
    -- We update the table data if it's stale.
    UpdateKillData()
    -- We clear the menu.
    player:GossipClearMenu()
    -- We loop through the data and add it to the gossip menu.
    for i, data in ipairs(killData) do
        player:GossipMenuAddItem(0, i .. ". " .. data.name .. " - " .. data.kills .. " kills", 0, 0)
    end
    -- We send the menu to the player.
    player:GossipSendMenu(1, object)
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    -- We don't really want any functionality here so we will close the menu if anything is selected.
    player:GossipComplete()
end

RegisterCreatureGossipEvent(creatureId, 1, OnGossipHello)
RegisterCreatureGossipEvent(creatureId, 2, OnGossipSelect)