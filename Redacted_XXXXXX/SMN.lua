local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    ['Idle'] = {
        Main = 'Marquetry Staff',
        Ammo = { Name = 'Ghastly Tathlum +1', AugPath='A' },
        Head = { Name = 'Nyame Helm', AugPath='B' },
        Neck = 'Adad Amulet',
        Ear1 = 'Lugalbanda Earring',
        Ear2 = 'Etiolation Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = { Name = 'Merlinic Dastanas', Augment = { [1] = 'Pet: INT+7', [2] = 'Pet: Attack+3', [3] = 'Pet: Rng.Atk.+3', [4] = 'Pet: Mag. Acc.+12', [5] = 'Blood Pact Dmg.+9' } },
        Ring1 = 'Defending Ring',
        Ring2 = 'Stikini Ring +1',
        Back = 'Scintillating Cape',
        Waist = 'Regal Belt',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
}
profile.Sets = sets

profile.Packer = {
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(sets)
end

profile.HandleCommand = function (args)
    looneylib.handleCommands(args)
end

profile.HandleDefault = function ()
    gFunc.EquipSet(sets.Idle)

    local player = gData.GetPlayer()
    if (player.Status == 'Engaged') then
        --gFunc.EquipSet(sets.Melee)
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

        --gFunc.EquipSet(sets.Melee)
    end
end

return profile
