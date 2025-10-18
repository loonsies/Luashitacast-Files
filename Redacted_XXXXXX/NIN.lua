local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    ['Idle'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = { Name = 'Loricate Torque +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Infused Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['IdleMovement'] = {
        Ring1 = 'Shneddick Ring',
    },
    ['IdleRegen'] = {
        Neck = 'Bathy Choker +1',
    },
    ['beads'] = {
        Main = 'Voluspa Knife',
        Sub = 'Tauret',
        Ammo = 'Focal Orb',
        Head = 'Mummu Bonnet +2',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Mummu Ring',
        Ring2 = 'Chirich Ring +1',
        Back = 'Aptitude Mantle +1',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Mummu Kecks +2',
        Feet = 'Mummu Gamash. +2',
    },
    ['TP'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Ginsen',
        Head = 'Hiza. Somen +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Hiza. Haramaki +2',
        Hands = 'Hizamaru Kote +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Hiza. Hizayoroi +2',
        Feet = 'Hiza. Sune-Ate +2',
    },
    ['WS'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Focal Orb',
        Head = 'Nyame Helm',
        Neck = 'Asperity Necklace',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'Attack+4', [2] = 'TP Bonus +250' } },
        Ear2 = 'Brutal Earring',
        Body = 'Nyame Mail',
        Hands = 'Hizamaru Kote +2',
        Ring1 = 'Hetairoi Ring',
        Ring2 = 'Mummu Ring',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['skill'] = {
        Main = 'Kunai',
        Sub = 'Bronze Dagger',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Tema. Headband',
        Neck = { Name = 'Loricate Torque +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Infused Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = 'Carrier\'s Sash',
        Legs = 'Temachtiani Pants',
        Feet = 'Temachtiani Boots',
    },
    ['TH'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Per. Lucky Egg',
        Head = 'Hiza. Somen +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Hiza. Haramaki +2',
        Hands = { Name = 'Herculean Gloves', Augment = { [1] = '"Mag. Atk. Bns."+20', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+1', [4] = 'Mag. Acc.+20', [5] = 'Attack+1', [6] = 'Pet: Haste+1' } },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = 'Chaac Belt',
        Legs = 'Hiza. Hizayoroi +2',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = '"Fast Cast"+5', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+12', [4] = 'Attack+12', [5] = '"Mag. Atk. Bns."+3' } },
    },
    ['ProcRed'] = {
        Main = 'Bronze Dagger',
        Sub = 'Bronze Dagger',
        Ammo = 'Ginsen',
        Head = 'Hiza. Somen +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Hiza. Haramaki +2',
        Hands = 'Hizamaru Kote +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Hiza. Hizayoroi +2',
        Feet = 'Hiza. Sune-Ate +2',
    },
    ['Precast'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Sapience Orb',
        Head = 'Mummu Bonnet +2',
        Neck = 'Bathy Choker +1',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Kishar Ring',
        Ring2 = 'Prolix Ring',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Mummu Kecks +2',
        Feet = 'Mummu Gamash. +2',
    },
}
profile.Sets = sets

local vars = {
}

local displaySets = {
    'Idle',
    'TP',
    'WS',
    'TH',
    'newline',
    'beads',
    'ProcRed',
    'Precast',
}

profile.Packer = {
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets, vars)

    ashita.tasks.once(4, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 12')
        ashita.tasks.once(1, function ()
            AshitaCore:GetChatManager():QueueCommand(1, '/sl blink')
        end)
    end)
end

profile.HandleCommand = function (args)
    looneylib.handleCommands(args)
end

profile.HandleDefault = function ()
    gFunc.EquipSet(sets.Idle)

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

-- When you want to use the value, use vars.currentDagger[1]

return profile
