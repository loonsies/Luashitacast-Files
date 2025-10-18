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
    ['TP'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Ginsen',
        Head = 'Mummu Bonnet +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Mummu Kecks +2',
        Feet = 'Mummu Gamash. +2',
    },
    ['WS'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Ginsen',
        Head = 'Mummu Bonnet +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Mache Earring +1',
        Ear2 = 'Brutal Earring',
        Body = 'Meg. Cuirie +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Hetairoi Ring',
        Ring2 = 'Mummu Ring',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Mummu Kecks +2',
        Feet = 'Mummu Gamash. +2',
    },
    ['TH'] = {
        Main = 'Tauret',
        Sub = 'Voluspa Knife',
        Ammo = 'Per. Lucky Egg',
        Head = 'Meghanada Visor +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Meg. Cuirie +2',
        Hands = { Name = 'Herculean Gloves', Augment = { [1] = '"Mag. Atk. Bns."+20', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+1', [4] = 'Mag. Acc.+20', [5] = 'Attack+1', [6] = 'Pet: Haste+1' } },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = 'Chaac Belt',
        Legs = 'Meg. Chausses +2',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = '"Fast Cast"+5', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+12', [4] = 'Attack+12', [5] = '"Mag. Atk. Bns."+3' } },
    },
    ['THDyna'] = {
        Main = { Name = 'Centovente', AugTrial = 3201 },
        Sub = 'Tauret',
        Ammo = 'Per. Lucky Egg',
        Head = 'Mummu Bonnet +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Mummu Jacket +2',
        Hands = { Name = 'Herculean Gloves', Augment = { [1] = '"Mag. Atk. Bns."+20', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+1', [4] = 'Mag. Acc.+20', [5] = 'Attack+1', [6] = 'Pet: Haste+1' } },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = 'Chaac Belt',
        Legs = 'Mummu Kecks +2',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = '"Fast Cast"+5', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+12', [4] = 'Attack+12', [5] = '"Mag. Atk. Bns."+3' } },
    },
    ['WSDyna'] = {
        Main = { Name = 'Centovente', AugTrial = 3201 },
        Sub = 'Tauret',
        Ammo = 'Ginsen',
        Head = 'Mummu Bonnet +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Mummu Kecks +2',
        Feet = 'Mummu Gamash. +2',
    },
}
profile.Sets = sets

local displaySets = {
    'idle',
    'TP',
    'WS',
    'GA',
    'TH',
    'MAEvasion',
    'naked',
    'THDyna',
    'WSDyna',
}

profile.Packer = {
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets)

    ashita.tasks.once(4, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 8')
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

return profile
