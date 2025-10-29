local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    ['Idle'] = {
        Main = 'Grioavolr',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = { Name = 'Loricate Torque +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Defending Ring',
        Back = 'Shadow Mantle',
        Waist = { Name = 'Shinjutsu-no-Obi +1', AugPath = 'A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['IdleRefresh'] = {
        Body = 'Jhakri Robe +2',
        Ring1 = 'Stikini Ring +1',
    },
    ['Midcast'] = {
        Main = 'Grioavolr',
        Ammo = 'Ghastly Tathlum +1',
        Head = 'Jhakri Coronal +2',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Metamor. Ring +1',
        Ring2 = 'Strendu Ring',
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Jhakri Slops +2',
        Feet = 'Jhakri Pigaches +2',
    },
    ['Precast'] = {
        Main = 'Grioavolr',
        Ammo = 'Sapience Orb',
        Head = 'Jhakri Coronal +2',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Mendi. Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Prolix Ring',
        Ring2 = 'Kishar Ring',
        Waist = 'Witful Belt',
        Legs = 'Jhakri Slops +2',
        Feet = 'Jhakri Pigaches +2',
    }
    ,
    ['TH'] = {
        Main = 'Grioavolr',
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Neck = { Name = 'Loricate Torque +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Jhakri Robe +2',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Defending Ring',
        Back = 'Shadow Mantle',
        Waist = 'Chaac Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    }
}
profile.Sets = sets

local displaySets = { 'Idle', 'Midcast', 'Spell', 'TH' }

profile.Packer = {
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets, vars)

    ashita.tasks.once(4, function()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 9')
        ashita.tasks.once(1, function()
            AshitaCore:GetChatManager():QueueCommand(1, '/sl blink')
        end)
    end)
end

profile.HandleCommand = function(args)
    looneylib.handleCommands(args)
end

profile.HandleDefault = function()
    gFunc.EquipSet(sets.Idle)

    if gData.GetPlayer().HPP > 70 and gData.GetPlayer().MPP < 95 then
        gFunc.EquipSet(sets.IdleRefresh)
    end

    local player = gData.GetPlayer()
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Idle)
        gFunc.EquipSet(sets.IdleRefresh)
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
