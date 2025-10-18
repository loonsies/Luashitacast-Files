local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    Idle = {
    },
    ['melee'] = {
        Main = 'Naegling',
        Sub = 'Adapa Shield',
        Ammo = 'Bubbly Broth',
        Head = 'Meghanada Visor +2',
        Neck = 'Spike Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = { Name = 'Nukumi Earring +1', Augment = { [1] = 'Accuracy+15', [2] = 'Pet: "Dbl. Atk."+7', [3] = 'Mag. Acc.+15' } },
        Body = 'Meg. Cuirie +2',
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Meghanada Ring',
        Ring2 = 'Chirich Ring +1',
        Back = 'Aptitude Mantle +1',
        Waist = 'Isa Belt',
        Legs = 'Meg. Chausses +2',
        Feet = 'Meg. Jam. +2',
    },
}
profile.Sets = sets

local displaySets = { 'melee' }

profile.Packer = {
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets)
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
