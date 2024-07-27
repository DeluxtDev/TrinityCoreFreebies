-- Created by Deluxt - https://github.com/DeluxtDev
-- This script will teach the player all of their class spells, dual spec, riding, and max weapon skills.
-- This is suited primarily for custom servers with instant 80.
-- It does not check for rather or not a spell is allowed at a specific level.
-- This is the main config if you dont know what your doing I reccomend not changing anything other than these.
local config = {
    creatureId = 100002,
    prefix = "|cffffffff [Class Trainer]: |cff00ccff",
    minLevel = 80,
    enableDualSpec = true,
    enableRiding = true,
    enableMaxWeaponSkills = true,
}

-- This is our table for all of our spells.
local spells = {
    -- Alliance only spells.
    ['alianceOnly'] = {
        -- Paladin
        [2] = { 31801, 13819, 23214 },
        -- Shaman
        [7] = { 2825 },
        -- Mage
        [8] = { 32271, 49359, 3565, 33690, 3562, 3561, 11419, 32266, 11416, 33691, 11059, 49360 },
    },
    -- Horde only spells.
    ['hordeOnly'] = {
        -- Paladin
        [2] = { 53736, 34769, 34767 },
        -- Shaman
        [7] = { 32182 },
        -- Mage
        [8] = { 3567, 35715, 3566, 49358, 32272, 3563, 11417, 35717, 32267, 49361, 11420, 11418 },
    },
    -- Neutral spells do not need to be faction specific.
    ['neutral'] = {
        -- Warrior
        [1] = { 47436, 47450, 11578, 47465, 47502, 34428, 1715, 3127, 7384, 2687, 71, 7386, 355, 72, 47437, 57823, 694, 2565, 676, 47520, 20230, 12678, 47471, 1161, 871, 2458, 20252, 47475, 18499, 1680, 6552, 47488, 1719, 23920, 47440, 3411, 64382, 55694, 57755, 674, 750, 5246 },
        -- Paladin
        [2] = { 19752, 3127, 19746, 750, 48942, 48782, 48932, 20271, 498, 10308, 1152, 10278, 48788, 53408, 48950, 48936, 31789, 62124, 54043, 25780, 1044, 20217, 48819, 48801, 48785, 5502, 20164, 10326, 1038, 53407, 48943, 20165, 48945, 642, 48947, 20166, 4987, 48806, 6940, 48817, 48934, 48938, 25898, 25899, 32223, 31884, 54428, 61411, 53601, 33388, 33391 },
        -- Hunter
        [3] = { 3127, 674, 3043, 3045, 8737, 1494, 13163, 48996, 49001, 49045, 53338, 5116, 27044, 883, 2641, 6991, 982, 1515, 19883, 20736, 48990, 2974, 6197, 1002, 14327, 5118, 49056, 53339, 49048, 19884, 34074, 781, 14311, 1462, 19885, 19880, 13809, 13161, 5384, 1543, 19878, 49067, 3034, 13159, 19882, 58434, 49071, 49052, 19879, 19263, 19801, 34026, 34600, 34477, 61006, 61847, 53271, 60192, 62757 },
        -- Rogue
        [4] = { 3127, 674, 48668, 48638, 1784, 48657, 921, 1776, 26669, 51724, 6774, 11305, 1766, 48676, 48659, 1804, 8647, 48691, 51722, 48672, 1725, 26889, 2836, 1833, 1842, 8643, 2094, 1860, 57993, 48674, 31224, 5938, 57934, 51723 },
        -- Priest
        [5] = { 528, 2053, 48161, 48123, 48125, 48066, 586, 48068, 48127, 48171, 48168, 10890, 6064, 988, 48300, 6346, 48071, 48135, 48078, 453, 10955, 10909, 8129, 48073, 605, 48072, 48169, 552, 1706, 48063, 48162, 48170, 48074, 48158, 48120, 34433, 48113, 32375, 64843, 64901, 53023 },
        -- Death Knight
        [6] = { 50842, 49941, 49930, 47476, 45529, 3714, 56222, 48743, 48263, 49909, 66188, 47528, 45524, 48792, 57623, 56815, 47568, 49895, 50977, 49576, 49921, 46584, 49938, 48707, 48265, 61999, 42650, 53428, 53331, 54447, 53342, 54446, 53323, 53344, 70164, 62158, 33391, 48778, 51425, 49924, 49924 },
        -- Shaman
        [7] = { 2062, 8737, 49273, 49238, 10399, 49231, 58753, 2484, 49281, 58582, 49233, 58790, 58704, 58643, 49277, 61657, 8012, 526, 2645, 57994, 8143, 49236, 58796, 58757, 49276, 57960, 131, 58745, 6196, 58734, 58774, 58739, 58656, 546, 556, 66842, 51994, 8177, 58749, 20608, 36936, 58804, 49271, 8512, 6495, 8170, 66843, 55459, 66844, 3738, 2894, 60043, 51514 },
        -- Mage
        [8] = { 7301, 42995, 42833, 27090, 42842, 33717, 42873, 42846, 12826, 28271, 61780, 61721, 28272, 61305, 42917, 43015, 130, 42921, 42926, 43017, 475, 1953, 42940, 12051, 43010, 43020, 43012, 42859, 2139, 42931, 42985, 43008, 45438, 43024, 43002, 43046, 42897, 42914, 66, 58659, 30449, 42956, 47610, 61316, 61024, 55342 },
        -- Warlock
        [9] = { 1710, 696, 47811, 47809, 688, 47813, 50511, 57946, 47864, 6215, 47878, 47855, 697, 47856, 47857, 5697, 47884, 47815, 47889, 47820, 698, 712, 126, 5138, 5500, 11719, 132, 60220, 18647, 61191, 47823, 691, 47865, 47891, 47888, 17928, 47860, 47825, 1122, 47867, 18540, 47893, 47838, 29858, 58887, 47836, 61290, 48018, 48020, 33388, 33391, 23161 },
        -- Druid
        [11] = { 48378, 48469, 48461, 48463, 48441, 53307, 53308, 5487, 48560, 6795, 48480, 53312, 18960, 5229, 48443, 50763, 8983, 8946, 1066, 48562, 783, 770, 16857, 18658, 768, 1082, 16979, 49376, 5215, 48477, 49800, 48465, 48572, 26995, 48574, 2782, 50213, 2893, 33357, 5209, 48575, 48447, 48577, 48579, 5225, 22842, 49803, 9634, 20719, 48467, 29166, 62600, 22812, 48470, 48564, 48566, 33891, 33943, 49802, 48451, 48568, 33786, 40120, 62078, 52610, 50464, 48570 },
    },
    ['dualSpec'] = { 
        63680, 63624
    },
    ['riding'] = {
        33388, 33391, 34090, 34091, 54197
    }
}

-- Handles learing all the spells.
local function  LearnSpells(player)
    local class = player:GetClass()
    -- Neutral spells.
    for _, spellId in ipairs(spells.neutral[class]) do
        if ( not player:HasSpell(spellId)) then
            player:LearnSpell(spellId)
        end
    end

    -- Faction specific spells
    if (player:GetTeam() == 0) then
        for _, spellId in ipairs(spells.alianceOnly[class]) do
            if (not player:HasSpell(spellId)) then
                player:LearnSpell(spellId)
            end
        end
    else
        for _, spellId in ipairs(spells.hordeOnly[class]) do
            if (not player:HasSpell(spellId)) then
                player:LearnSpell(spellId)
            end
        end
    end

    -- Dual spec spells
    if (enableDualSpec) then
        for _, spellId in ipairs(spells.dualSpec) do
            if (not player:HasSpell(spellId)) then
                player:LearnSpell(spellId)
            end
        end
    end

    -- Riding spells
    if (enableRiding) then
        for _, spellId in ipairs(spells.riding) do
            if (not player:HasSpell(spellId)) then
                player:LearnSpell(spellId)
            end
        end
    end

    -- Max weapon skills
    if (enableMaxWeaponSkills) then
        player:AdvanceSkillsToMax()
    end

    player:SendBroadcastMessage(config.prefix .. "I have taught you all that I can.")
end

local function OnGossipHello(event, player, object)
    if (player:GetLevel() < config.minLevel) then
        player:SendBroadcastMessage(config.prefix .. "Go kill some boars util your level " .. config.minLevel .. ".");
        player:GossipComplete()
        return
    end

    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Learn Class Spells", 0, 1)
    player:GossipMenuAddItem(0, "Reset Talents", 0, 2)
    player:GossipMenuAddItem(0, "Nevermind", 0, 3)
    player:GossipSendMenu(1, object)
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    if (intid == 1) then
        LearnSpells(player)
    elseif (intid == 2) then
        player:ResetTalents()
        player:SendBroadcastMessage(config.prefix .. "Your talents have been reset.")
    end

    player:GossipComplete()
end

RegisterCreatureGossipEvent(config.creatureId, 1, OnGossipHello)
RegisterCreatureGossipEvent(config.creatureId, 2, OnGossipSelect)