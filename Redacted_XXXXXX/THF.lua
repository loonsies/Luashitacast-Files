local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    ['Idle'] = {
        Main = 'Naegling',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Staunch Tathlum +1',
        Head = 'Meghanada Visor +2',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Skulk. Earring +1',
        Body = 'Meg. Cuirie +2',
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Defending Ring',
        Ring2 = 'Chirich Ring +1',
        Back = 'Toutatis\'s Cape',
        Waist = 'Carrier\'s Sash',
        Legs = 'Meg. Chausses +2',
        Feet = 'Meg. Jam. +2',
    },
    ['IdleMovement'] = {
        Ring1 = 'Shneddick Ring',
    },
    ['IdleRegen'] = {
        Neck = 'Bathy Choker +1',
    },
    ['TP'] = {
        Main = 'Naegling',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Staunch Tathlum +1',
        Head = 'Meghanada Visor +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Brutal Earring',
        Ear2 = { Name = 'Skulk. Earring +1', Augment = { [1] = 'Accuracy+12', [2] = '"Store TP"+4', [3] = 'Mag. Acc.+12' } },
        Body = 'Meg. Cuirie +2',
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Toutatis\'s Cape',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Meg. Chausses +2',
        Feet = 'Meg. Jam. +2',
    },
    ['WS'] = {
        Main = 'Naegling',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Staunch Tathlum +1',
        Head = 'Meghanada Visor +2',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Mache Earring+1',
        Body = 'Meg. Cuirie +2',
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Toutatis\'s Cape',
        Waist = 'Sailfi Belt +1',
        Legs = 'Meg. Chausses +2',
        Feet = 'Meg. Jam. +2',
    },
    ['TH'] = {
        Main = 'Sandung',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Neck = 'Asperity Necklace',
        Ear1 = 'Brutal Earring',
        Ear2 = { Name = 'Skulk. Earring +1', Augment = { [1] = 'Accuracy+12', [2] = '"Store TP"+4', [3] = 'Mag. Acc.+12' } },
        Body = 'Meg. Cuirie +2',
        Hands = { Name = 'Plun. Armlets +1', AugTrial = 5257 },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Toutatis\'s Cape',
        Waist = 'Chaac Belt',
        Legs = 'Meg. Chausses +2',
        Feet = 'Skulk. Poulaines',
    },
    ['naked'] = {
    },
    ['MAEvasion'] = {
        Main = 'Naegling',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Patricius Ring',
        Ring2 = 'Shneddick Ring',
        Back = 'Shadow Mantle',
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Meg. Jam. +2',
    }
    ,
    ['THDyna'] = {
        Main = { Name = 'Centovente', AugTrial = 3201 },
        Sub = 'Sandung',
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Neck = 'Asperity Necklace',
        Ear1 = 'Brutal Earring',
        Ear2 = { Name = 'Skulk. Earring +1', Augment = { [1] = 'Accuracy+12', [2] = '"Store TP"+4', [3] = 'Mag. Acc.+12' } },
        Body = 'Mummu Jacket +2',
        Hands = { Name = 'Plun. Armlets +1', AugTrial = 5257 },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Toutatis\'s Cape',
        Waist = 'Chaac Belt',
        Legs = 'Mummu Kecks +2',
        Feet = 'Skulk. Poulaines',
    },
    ['WSDyna'] = {
        Main = { Name = 'Centovente', AugTrial = 3201 },
        Sub = 'Sandung',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Meghanada Visor +2',
        Neck = 'Asperity Necklace',
        Ear1 = 'Brutal Earring',
        Ear2 = { Name = 'Skulk. Earring +1', Augment = { [1] = 'Accuracy+12', [2] = '"Store TP"+4', [3] = 'Mag. Acc.+12' } },
        Body = 'Meg. Cuirie +2',
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Toutatis\'s Cape',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Meg. Chausses +2',
        Feet = 'Meg. Jam. +2',
    }
}
profile.Sets = sets

local displaySets = {
    'Idle',
    'TP',
    'WS',
    'TH',
    'newline',
    'naked',
    'MAEvasion',
    'newline',
    'THDyna',
    'WSDyna',
}


profile.Packer = {
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets, vars)

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
