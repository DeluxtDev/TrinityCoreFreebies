-- Created by Deluxt - https://github.com/DeluxtDev
-- This script will add a .coords command that saves the player's coordinates to a file.
-- This was not an original idea. Ive seen it before but I couldn't find it so I remade it.
-- If you want to change where the file is save or the name of the file change this.
local path = "lua_scripts/SavedCoords.txt"
local cmd = "coords"
local minimumRank = 1

local function SavePlayerCoordinates(player)
    local playerName = player:GetName()
    local timestamp = os.date("%m-%d-%Y %H:%M:%S")
    local coordinates = string.format("[%s] X: %f Y: %f Z: %f Time: %s\n", playerName, player:GetX(), player:GetY(), player:GetZ(), timestamp)

    file, err = io.open(path, "a")
    if (not file) then
        file, err = io.open(path, "w")
    end

    if (file) then
        file:write(coordinates)
        file:close()
        if err == "a" then
            player:SendBroadcastMessage("Coordinates appended to file: " .. coordinates)
        else
            player:SendBroadcastMessage("Coordinates saved to new file: " .. coordinates)
        end
    else
        player:SendBroadcastMessage("Error: Unable to create/open file for writing: " .. err)
    end
end

local function OnMyCommand(event, player, command)
    if (command == cmd) then 
        rank = player:GetGMRank()
        
        if (rank <= minimumRank) then
            player:SendBroadcastMessage("You do not have permission to use this command.")
            return false
        end

        SavePlayerCoordinates(player)
        return false
    end
end

RegisterPlayerEvent(42, OnMyCommand)