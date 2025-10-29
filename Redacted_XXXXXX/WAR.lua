local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    ['TP'] = {
        Main = 'Naegling',
        Sub = 'Blurred Shield +1',
        Ammo = { Name = 'Coiste Bodhar', AugPath='A' },
        Head = 'Boii Mask +2',
        Neck = 'War. Beads +1',
        Ear1 = 'Brutal Earring',
        Ear2 = { Name = 'Boii Earring', Augment = { [1] = 'Accuracy+6', [2] = 'Mag. Acc.+6' } },
        Body = { Name = 'Sakpata\'s Plate', AugPath='A' },
        Hands = { Name = 'Sakpata\'s Gauntlets', AugPath='A' },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Cichol\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Pumm. Cuisses +3',
        Feet = 'Pumm. Calligae +3',
    },
    ['WS'] = {
        Main = 'Naegling',
        Sub = 'Blurred Shield +1',
        Ammo = 'Focal Orb',
        Head = 'Agoge Mask +3',
        Neck = 'War. Beads +1',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'Attack+4', [2] = 'TP Bonus +250' } },
        Ear2 = 'Thrud Earring',
        Body = 'Pumm. Lorica +4',
        Hands = 'Boii Mufflers +2',
        Ring1 = 'Nguruve Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Cichol\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Boii Cuisses +2',
        Feet = 'Sulev. Leggings +2',
    },
    ['Idle'] = {
        Main = 'Naegling',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Sakpata\'s Helm',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Infused Earring',
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Cichol\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = 'Carrier\'s Sash',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Sakpata\'s Leggings',
    },
    ['IdleShield'] = {
        Sub = 'Adapa Shield',
    },
    ['IdleMovement'] = {
        Ring1 = 'Shneddick Ring',
    },
    ['IdleRegen'] = {
        Neck = 'Bathy Choker +1',
    },
    ['Warcry'] = {
        Head = 'Agoge Mask +3'
    },
    ['Aggressor'] = {
        Head = 'Pummeler\'s Mask'
    },
    ['Berserk'] = {
        Body = 'Pummeler\'s Lorica',
        Legs = 'Agoge Calligae'
    },
    ['MightyStrikes'] = {
        Hands = 'Agoge Mufflers'
    },
    ['Retaliation'] = {
        Hands = 'Pumm. Mufflers',
        Legs = 'Boii Calligae +2'
    },
    ['WarriorsCharge'] = {
        Legs = 'Agoge Cuisses'
    },
    ['BloodRage'] = {
        Body = 'Boii Lorica +2',
    },
    ['Restraint'] = {
        Hands = 'Boii Mufflers +2',
    }
    ,
    ['GA'] = {
        Main = 'Kaja Chopper',
        Ammo = 'Ginsen',
        Head = 'Boii Mask +2',
        Neck = 'War. Beads +1',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Mache Earring +1',
        Body = 'Flamma Korazin +2',
        Hands = 'Flam. Manopolas +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Cichol\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Pumm. Cuisses +3',
        Feet = 'Flam. Gambieras +2',
    }
    ,
    ['TH'] = {
        Main = 'Naegling',
        Sub = 'Blurred Shield +1',
        Ammo = 'Per. Lucky Egg',
        Head = { Name = 'Valorous Mask', Augment = { [1] = '"Mag. Atk. Bns."+12', [2] = 'Mag. Acc.+12', [3] = '"Treasure Hunter"+2', [4] = 'Crit.hit rate+1', [5] = 'Accuracy+1', [6] = 'Attack+1', [7] = 'Rng.Atk.+5' } },
        Neck = 'War. Beads +1',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Mache Earring +1',
        Body = 'Sakpata\'s Plate',
        Hands = { Name = 'Valorous Mitts', Augment = { [1] = 'Damage taken-2%', [2] = 'Accuracy+2', [3] = '"Treasure Hunter"+1' } },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Cichol\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = 'Chaac Belt',
        Legs = 'Pumm. Cuisses +3',
        Feet = 'Pumm. Calligae +3',
    }
}
profile.Sets = sets

local displaySets = { ['Idle'] = sets.Idle, ['TP'] = sets.TP, ['WS'] = sets.WS, ['GA'] = sets.GA, ['TH'] = sets.TH }

local displaySets = { 'Idle', 'TP', 'WS', 'GA', 'TH' }

profile.Packer = {
    -- {Name = 'Chonofuda', Quantity = 'all'},
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets, vars)

    ashita.tasks.once(4, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 19')
        ashita.tasks.once(1, function ()
            AshitaCore:GetChatManager():QueueCommand(1, '/sl blink')
        end)
    end)

    -- AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5')
    -- AshitaCore:GetChatManager():QueueCommand(1, '/macro set 10')
end

profile.HandleCommand = function (args)
    looneylib.handleCommands(args)
end

profile.HandleDefault = function ()
    gFunc.EquipSet(sets.Idle)

    if gData.GetPlayer().TP <= 100 then
        gFunc.EquipSet(sets.IdleShield)
    end

    if gData.GetPlayer().IsMoving then
        gFunc.EquipSet(sets.IdleMovement)
    end

    if gData.GetPlayer().HPP < 100 then
        gFunc.EquipSet(sets.IdleRegen)
    end

    local player = gData.GetPlayer()
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.TP)
    end

    looneylib.checkDefault()
end

profile.HandleAbility = function ()
    local ability = gData.GetAction()

    if ability.Name:contains('Warcry') then
        gFunc.EquipSet(sets.Warcry)
    elseif ability.Name:contains('Aggressor') then
        gFunc.EquipSet(sets.Aggressor)
    elseif ability.Name:contains('Berserk') then
        gFunc.EquipSet(sets.Berserk)
    elseif ability.Name:contains('MightyStrikes') then
        gFunc.EquipSet(sets.MightyStrikes)
    elseif ability.Name:contains('Retaliation') then
        gFunc.EquipSet(sets.Retaliation)
    elseif ability.Name:contains('Warriors Charge') then
        gFunc.EquipSet(sets.WarriorsCharge)
    elseif ability.Name:contains('BloodRage') then
        gFunc.EquipSet(sets.BloodRage)
    elseif ability.Name:contains('Restraint') then
        gFunc.EquipSet(sets.Restraint)
    end
end

profile.HandlePrecast = function ()
end

profile.HandleMidcast = function ()
end

profile.HandleWeaponskill = function ()
    local canWS = looneylib.checkWsBailout()
    if (canWS == false) then
        gFunc.CancelAction()
        return
    else
        local ws = gData.GetAction()

        gFunc.EquipSet(sets.WS)
    end
end

return profile
