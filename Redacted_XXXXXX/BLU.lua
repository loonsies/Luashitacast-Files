local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    ['Idle'] = {
        Main = 'Naegling',
        Sub = 'Culminus',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Defending Ring',
        Back = 'Shadow Mantle',
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['RefreshCond'] = {
        Main = 'Naegling',
        Sub = 'Culminus',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Rawhide Mask',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Patricius Ring',
        Back = 'Shadow Mantle',
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['Midcast'] = {
        Main = 'Naegling',
        Sub = 'Culminus',
        Ammo = 'Ghastly Tathlum +1',
        Head = 'Jhakri Coronal +2',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Metamor. Ring +1',
        Ring2 = 'Strendu Ring',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Spell interruption rate down-10%', [3] = 'Mag. Acc.+20', [4] = 'INT+30', [5] = 'Magic Damage+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Jhakri Slops +2',
        Feet = 'Jhakri Pigaches +2',
    }
    ,
    ['Spell'] = {
        Main = 'Chocobo Wand',
        Sub = 'Culminus',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Jhakri Coronal +2',
        Neck = 'Eddy Necklace',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Mendi. Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Assim. Bazu. +1',
        Ring1 = 'Kishar Ring',
        Ring2 = 'Prolix Ring',
        Back = { Name = 'Rosmerta\'s Cape', Augment = '"Fast Cast"+10' },
        Waist = 'Witful Belt',
        Legs = 'Aya. Cosciales +2',
        Feet = { Name = 'Carmine Greaves', AugPath = 'C' },
    },
    ['Naked'] = {},
    ['Precast'] = {
        Main = 'Saktapa\'s Sword',
        Sub = 'Culminus',
        Ammo = 'Sapience Orb',
        Head = { Name = 'Carmine Mask', AugPath = 'D' },
        Neck = 'Baetyl Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Mendi. Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Prolix Ring',
        Ring2 = 'Kishar Ring',
        Back = { Name = 'Rosmerta\'s Cape', Augment = '"Fast Cast"+10' },
        Waist = 'Witful Belt',
        Legs = 'Aya. Cosciales +2',
        Feet = { Name = 'Carmine Greaves', AugPath = 'C' },
    },
    ['Phalanx'] = {
        Main = 'Saktapa\'s Sword',
        Hands = { Name = 'Herculean Gloves', Augment = { [1] = 'Accuracy+14', [2] = 'Phalanx +5', [3] = 'Attack+28', [4] = 'Rng.Atk.+30' } },
    }
    ,
    ['TH'] = {
        Main = 'Naegling',
        Sub = 'Culminus',
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Jhakri Robe +2',
        Hands = { Name = 'Herculean Gloves', Augment = { [1] = '"Mag. Atk. Bns."+20', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+1', [4] = 'Mag. Acc.+20', [5] = 'Attack+1', [6] = 'Pet: Haste+1' } },
        Ring1 = { Name = 'Metamor. Ring +1', AugPath = 'A' },
        Ring2 = 'Strendu Ring',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Spell interruption rate down-10%', [3] = 'Mag. Acc.+20', [4] = 'INT+30', [5] = 'Magic Damage+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Jhakri Slops +2',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = '"Fast Cast"+5', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+12', [4] = 'Attack+12', [5] = '"Mag. Atk. Bns."+3' } },
    }
,
    ['abc'] = {
        Main = 'Qutrub Knife',
        Sub = 'Culminus',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Defending Ring',
        Back = 'Shadow Mantle',
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    }}
profile.Sets = sets

local displaySets = { 'Idle', 'Midcast', 'Spell', 'TH' }

profile.Packer = {
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets, vars)

    ashita.tasks.once(4, function()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 10')
        ashita.tasks.once(1, function()
            AshitaCore:GetChatManager():QueueCommand(1, '/sl blink')
        end)
    end)
end

profile.HandleCommand = function(args)
    looneylib.handleCommands(args)
end

profile.HandleDefault = function()
    if gData.GetPlayer().HPP > 60 and gData.GetPlayer().MPP < 75 then
        gFunc.EquipSet(sets.RefreshCond)
    else
        gFunc.EquipSet(sets.Idle)
    end

    local player = gData.GetPlayer()
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Idle)
    end

    looneylib.checkDefault()
end

profile.HandleAbility = function()
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.Precast)
end

profile.HandleMidcast = function()
    gFunc.EquipSet(sets.Midcast)

    local spell = gData.GetAction()

    if spell.Name:contains('Phalanx') then
        gFunc.EquipSet(sets.Phalanx)
    end
end

profile.HandleWeaponskill = function()
    local canWS = looneylib.checkWsBailout()
    if (canWS == false) then
        gFunc.CancelAction()
        return
    else
        local ws = gData.GetAction()

        gFunc.EquipSet(sets.Idle)
    end
end

return profile
