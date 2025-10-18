local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local sets = {
    Idle = {
        Main = 'Naegling',
        Sub = 'Tauret',
        Head = 'Aya. Zucchetto +2',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Mache earring +1',
        Ear2 = 'Merman\'s earring',
        Body = 'Ayanmo Corazza +2',
        Hands = 'Aya. Manopolas +2',
        Ring1 = 'Chirich ring +1',
        Ring2 = 'Chirich ring +1',
        Waist = 'Carrier\'s Sash',
        Legs = 'Aya. Cosciales +2',
        Feet = 'Aya. Gambieras +2'
    },
}
profile.Sets = sets

profile.Packer = {
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(sets)

    ashita.tasks.once(4, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 13')
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
