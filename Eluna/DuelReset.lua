--[[ 
Created by Deluxt - https://github.com/DeluxtDev
This script will reset player cooldowns and health, mana, and energy after a duel.
Add the power types you want to reset here.
    POWER_MANA        = 0,
    POWER_RAGE        = 1,
    POWER_FOCUS       = 2,
    POWER_ENERGY      = 3,
    POWER_HAPPINESS   = 4,
    POWER_RUNE        = 5,
    POWER_RUNIC_POWER = 6,
    MAX_POWERS        = 7,
    POWER_ALL         = 127
It is important to note trinity has duel reset built into the world config.
But this is easily customizable to suit your needs if that isnt enough.
]]--
local powersToReset = {0, 3}

local function ResetPlayer(player)
    player:ResetAllCooldowns();
    player:SetHealth(player:GetMaxHealth());

    power = player:GetPowerType();
    for i, v in ipairs(powersToReset) do
        if (power == v) then
            player:SetPower(player:GetMaxPower(v), v);
        end
    end
end

local function OnDuelEnd(event, winner, loser, type)
    ResetPlayer(winner);
    ResetPlayer(loser);
end

RegisterPlayerEvent(11, OnDuelEnd)