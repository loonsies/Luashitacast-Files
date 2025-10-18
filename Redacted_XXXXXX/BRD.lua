local profile = {}
looneylib = gFunc.LoadFile('../common/looneylib.lua')

local hasDW = false

local sets = {
    ['Idle'] = {
        Main = 'Naegling',
        Sub = 'Genmei Shield',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = { Name = 'Loricate Torque +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Infused Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = 'Flume Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['IdleMovement'] = {
        Ring1 = 'Shneddick Ring',
    },
    ['IdleRegen'] = {
        Neck = 'Bathy Choker +1',
    },
    ['IdleRefresh'] = {
        Ear2 = 'Ethereal Earring',
        Ring1 = 'Stikini Ring +1',
    },
    ['Precast'] = {
        Main = { Name = 'Kali', AugPath = 'C' },
        Sub = 'Genmei Shield',
        Range = { Name = 'Linos', Augment = '"Fast Cast"+4' },
        Head = 'Fili Calot +2',
        Neck = { Name = 'Loricate Torque +1', AugPath = 'A' },
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Etiolation Earring',
        Body = 'Inyanga Jubbah +2',
        Hands = { Name = 'Gende. Gages +1', Augment = { [1] = 'Magic dmg. taken -2%', [2] = 'Phys. dmg. taken -4%', [3] = 'Song spellcasting time -5%' } },
        Ring1 = 'Defending Ring',
        Ring2 = 'Kishar Ring',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = 'Flume Belt',
        Legs = { Name = 'Kaykaus Tights +1', AugPath = 'A' },
        Feet = 'Fili Cothurnes +1',
    },
    ['PrecastCure'] = {
        Main = 'Naegling',
        Sub = 'Genmei Shield',
        Ammo = 'Sapience Orb',
        Head = 'Nahtirah Hat',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Mendi. Earring',
        Body = 'Inyanga Jubbah +2',
        Hands = { Name = 'Gende. Gages +1', Augment = { [1] = 'Magic dmg. taken -2%', [2] = 'Phys. dmg. taken -4%', [3] = 'Song spellcasting time -5%' } },
        Ring1 = 'Defending Ring',
        Ring2 = 'Kishar Ring',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = { Name = 'Shinjutsu-no-Obi +1', AugPath = 'A' },
        Legs = { Name = 'Kaykaus Tights +1', AugPath = 'A' },
        Feet = { Name = 'Vanya Clogs', AugPath = 'D' },
    },
    ['PrecastOther'] = {
        Main = 'Naegling',
        Sub = 'Genmei Shield',
        Range = { Name = 'Linos', Augment = '"Fast Cast"+4' },
        Head = 'Nahtirah Hat',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Etiolation Earring',
        Body = 'Inyanga Jubbah +2',
        Hands = { Name = 'Gende. Gages +1', Augment = { [1] = 'Magic dmg. taken -2%', [2] = 'Phys. dmg. taken -4%', [3] = 'Song spellcasting time -5%' } },
        Ring1 = 'Defending Ring',
        Ring2 = 'Kishar Ring',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = 'Flume Belt',
        Legs = { Name = 'Kaykaus Tights +1', AugPath = 'A' },
        Feet = 'Fili Cothurnes +1',
    },
    ['Midcast'] = {
        Main = { Name = 'Kali', AugPath = 'C' },
        Head = 'Fili Calot +2',
        Neck = 'Mnbw. Whistle +1',
        Ear1 = 'Loquac. Earring',
        Ear2 = 'Etiolation Earring',
        Body = 'Fili Hongreline +2',
        Hands = 'Fili Manchettes +2',
        Ring1 = 'Defending Ring',
        Ring2 = 'Kishar Ring',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = 'Flume Belt',
        Legs = 'Inyanga Shalwar +2',
        Feet = 'Brioso Slippers +3',
    },
    ['MidcastCure'] = {
        Main = { Name = 'Grioavolr', Augment = { [1] = 'Magic Damage +6', [2] = '"Conserve MP"+9', [3] = 'MND+3', [4] = '"Mag. Atk. Bns."+18' } },
        Sub = 'Giuoco Grip',
        Ammo = 'Pemphredo Tathlum',
        Head = { Name = 'Vanya Hood', AugPath = 'C' },
        Neck = 'Reti Pendant',
        Ear1 = 'Calamitous Earring',
        Ear2 = 'Mendi. Earring',
        Body = { Name = 'Kaykaus Bliaut', AugPath = 'D' },
        Hands = { Name = 'Vanya Cuffs', AugPath = 'A' },
        Ring1 = 'Stikini Ring +1',
        Ring2 = { Name = 'Mephitas\'s Ring +1', AugPath = 'A' },
        Back = { Name = 'Aurist\'s Cape +1', AugPath = 'A' },
        Waist = { Name = 'Shinjutsu-no-Obi +1', AugPath = 'A' },
        Legs = { Name = 'Kaykaus Tights +1', AugPath = 'A' },
        Feet = { Name = 'Vanya Clogs', AugPath = 'D' },
    },
    ['MidcastFoe'] = {
        Main = { Name = 'Kali', AugPath = 'C' },
        Sub = 'Genmei Shield',
        Range = { Name = 'Gjallarhorn', AugTrial = 3591 },
        Head = 'Brioso Roundlet +2',
        Neck = 'Mnbw. Whistle +1',
        Ear1 = 'Crep. Earring',
        Ear2 = 'Gwati Earring',
        Body = 'Brioso Justau. +3',
        Hands = 'Brioso Cuffs +3',
        Ring1 = 'Stikini Ring +1',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath = 'A' },
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = { Name = 'Acuity Belt +1', AugPath = 'A' },
        Legs = 'Inyanga Shalwar +2',
        Feet = 'Brioso Slippers +3',
    },
    ['MidcastHorde'] = {
        Main = { Name = 'Kali', AugPath = 'D' },
        Sub = 'Genmei Shield',
        Range = { Name = 'Daurdabla', AugTrial = 3590 },
        Head = 'Brioso Roundlet +2',
        Neck = 'Mnbw. Whistle +1',
        Ear1 = 'Crep. Earring',
        Ear2 = 'Gersemi Earring',
        Body = 'Brioso Justau. +3',
        Hands = 'Inyan. Dastanas +2',
        Ring1 = 'Stikini Ring +1',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath = 'A' },
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = { Name = 'Acuity Belt +1', AugPath = 'A' },
        Legs = 'Inyanga Shalwar +2',
        Feet = { Name = 'Bihu Slippers +3', AugTrial = 5547 },
    },
    ['MidcastDebuff'] = {
        Main = { Name = 'Kali', AugPath = 'C' },
        Sub = 'Genmei Shield',
        Ammo = 'Pemphredo Tathlum',
        Head = 'Brioso Roundlet +2',
        Neck = 'Mnbw. Whistle +1',
        Ear1 = 'Crep. Earring',
        Ear2 = 'Gwati Earring',
        Body = 'Brioso Justau. +3',
        Hands = 'Brioso Cuffs +3',
        Ring1 = { Name = 'Metamor. Ring +1', AugPath = 'A' },
        Ring2 = 'Stikini Ring +1',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Magic Damage+20', [2] = 'CHR+20', [3] = '"Fast Cast"+10', [4] = 'Mag. Acc.+30' } },
        Waist = { Name = 'Acuity Belt +1', AugPath = 'A' },
        Legs = 'Brioso Cannions +2',
        Feet = 'Brioso Slippers +3',
    },
    ['TP'] = {
        Range = { Name = 'Linos', Augment = { [1] = 'Accuracy+13', [2] = '"Store TP"+4', [3] = 'Attack+13', [4] = 'Quadruple Attack +3' } },
        Head = 'Bunzi\'s Hat',
        Neck = { Name = 'Bard\'s Charm +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['WS'] = {
        Range = { Name = 'Linos', Augment = { [1] = 'Accuracy+9', [2] = 'STR+8', [3] = 'Attack+9', [4] = 'Weapon skill damage +3%' } },
        Head = 'Nyame Helm',
        Neck = { Name = 'Bard\'s Charm +1', AugPath = 'A' },
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'Attack+4', [2] = 'TP Bonus +250' } },
        Ear2 = 'Brutal Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    ['Capacity'] = {
        Main = 'Naegling',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Staunch Tathlum +1',
        Head = 'Aya. Zucchetto +2',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Ayanmo Corazza +2',
        Hands = 'Aya. Manopolas +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Aptitude Mantle +1',
        Waist = 'Embla Sash',
        Legs = 'Aya. Cosciales +2',
        Feet = 'Aya. Gambieras +2',
    }
    ,
    ['TH'] = {
        Main = 'Naegling',
        Sub = { Name = 'Centovente', AugTrial = 3201 },
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Neck = { Name = 'Bard\'s Charm +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Ayanmo Corazza +2',
        Hands = 'Aya. Manopolas +2',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = 'Chaac Belt',
        Legs = 'Aya. Cosciales +2',
        Feet = 'Aya. Gambieras +2',
    },
    ['Daurdabla'] = {
        Range = { Name = 'Daurdabla', AugTrial = 3590 },
    },
    ['Gjallarhorn'] = {
        Range = 'Gjallarhorn'
    },
    ['Naegling'] = {
        Main = 'Naegling',
    },
    ['Tauret'] = {
        Main = 'Tauret',
    },
    ['Centovente'] = {
        Sub = { Name = 'Centovente', AugTrial = 3201 },
    },
    ['Legato'] = {
        Sub = 'Legato Dagger',
    },
    ['lvl1'] = {
        Main = 'Qutrub Knife',
        Sub = 'Bronze Dagger',
        Range = { Name = 'Linos', Augment = { [1] = 'Accuracy+13', [2] = '"Store TP"+4', [3] = 'Attack+13', [4] = 'Quadruple Attack +3' } },
        Head = 'Bunzi\'s Hat',
        Neck = { Name = 'Bard\'s Charm +1', AugPath = 'A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Intarabus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath = 'A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    }
}

profile.Sets = sets

local weapons = {
    naegling = 1,
    tauret = 2
}

local instruments = {
    daurdabla = 1,
    gjallarhorn = 2
}

local vars = {
    currentInstrument = { instruments.daurdabla },
    currentWeapon = { weapons.naegling }
}

local displaySets = {
    'Idle',
    'TP',
    'WS',
    'newline',
    'Precast',
    'Midcast',
    {
        varName = 'instrument',
        variable = vars.currentInstrument,
        {
            name = 'Daurdabla',
            value = instruments.daurdabla,
            color = { 252, 186, 3, 128 }
        },
        {
            name = 'Gjhorn',
            value = instruments.gjallarhorn,
            color = { 252, 65, 3, 128 }
        }
    },
    'newline',
    'TH',
    'Capacity',
    'lvl1',
    {
        varName = 'weapon',
        variable = vars.currentWeapon,
        {
            name = 'Naegling',
            value = weapons.naegling,
            color = { 120, 240, 138, 128 },
            callback = function ()
                AshitaCore:GetChatManager():QueueCommand(1, '/tb palette change BRDnaegling')
            end
        },
        {
            name = 'Tauret',
            value = weapons.tauret,
            color = { 186, 65, 95, 128 },
            callback = function ()
                AshitaCore:GetChatManager():QueueCommand(1, '/tb palette change BRDtauret')
            end
        }
    },
}

profile.Packer = {
    -- {Name = 'Chonofuda', Quantity = 'all'},
}

profile.OnLoad = function ()
    gSettings.AllowAddSet = true
    looneylib.initialize(displaySets)

    local dw = AshitaCore:GetResourceManager():GetAbilityByName('Dual Wield', 0);
    hasDW = AshitaCore:GetMemoryManager():GetPlayer():HasAbility(dw.Id);

    ashita.tasks.once(4, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 15')
        ashita.tasks.once(1, function ()
            AshitaCore:GetChatManager():QueueCommand(1, '/sl blink')
        end)

        AshitaCore:GetChatManager():QueueCommand(1, '/tb palette change BRDnaegling')
    end)
end

profile.HandleCommand = function (args)
    looneylib.handleCommands(args)
end

profile.HandleDefault = function ()
    local dw = AshitaCore:GetResourceManager():GetAbilityByName('Dual Wield', 0);
    hasDW = AshitaCore:GetMemoryManager():GetPlayer():HasAbility(dw.Id);

    local player = gData.GetPlayer()
    if (player.Status ~= 'Engaged') then
        gFunc.EquipSet(sets.Idle)

        if vars.currentWeapon[1] == weapons.naegling then
            gFunc.EquipSet(sets.Naegling)
        elseif vars.currentWeapon[1] == weapons.tauret then
            gFunc.EquipSet(sets.Tauret)
        end

        if hasDW then
            gFunc.EquipSet(sets.Centovente)
        end

        if gData.GetPlayer().IsMoving then
            gFunc.EquipSet(sets.IdleMovement)
        end

        if gData.GetPlayer().HPP > 90 and gData.GetPlayer().HPP < 100 then
            gFunc.EquipSet(sets.IdleRegen)
        end

        if gData.GetPlayer().HPP > 95 and gData.GetPlayer().MPP < 100 then
            gFunc.EquipSet(sets.IdleRefresh)
        end
    else
        gFunc.EquipSet(sets.TP)

        if vars.currentWeapon[1] == weapons.naegling then
            gFunc.EquipSet(sets.Naegling)
        elseif vars.currentWeapon[1] == weapons.tauret then
            gFunc.EquipSet(sets.Tauret)
        end

        if hasDW then
            gFunc.EquipSet(sets.Centovente)
        end
    end

    looneylib.checkDefault()
end

profile.HandleAbility = function ()
    local ability = gData.GetAction()
end

profile.HandlePrecast = function ()
    local spell = gData.GetAction()

    if (spell.Skill == 'Singing') then
        gFunc.EquipSet(sets.Precast)

        if hasDW then
            gFunc.EquipSet(sets.Legato)
        end

        if vars.currentInstrument[1] == instruments.daurdabla then
            gFunc.EquipSet(sets.Daurdabla)
        elseif vars.currentInstrument[1] == instruments.gjallarhorn then
            gFunc.EquipSet(sets.Gjallarhorn)
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.PrecastCure)
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.PrecastEnhancing)
    else
        gFunc.EquipSet(sets.PrecastOther)
    end
end

profile.HandleMidcast = function ()
    local weather = gData.GetEnvironment()
    local spell = gData.GetAction()
    local target = gData.GetActionTarget()
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)

    if (spell.Skill == 'Singing') then
        if (string.contains(spell.Name, 'Horde Lullaby')) then
            gFunc.EquipSet(sets.MidcastHorde);
        elseif (string.contains(spell.Name, 'Foe Lullaby')) then
            gFunc.EquipSet(sets.MidcastFoe);
        else
            gFunc.EquipSet(sets.Midcast)

            if hasDW then
                gFunc.EquipSet(sets.Legato)
            end

            if vars.currentInstrument[1] == instruments.daurdabla then
                gFunc.EquipSet(sets.Daurdabla)
            elseif vars.currentInstrument[1] == instruments.gjallarhorn then
                gFunc.EquipSet(sets.Gjallarhorn)
            end
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.MidcastCure)
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.MidcastDebuff)
    elseif (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.MidcastDebuff)
    end
end

profile.HandleWeaponskill = function ()
    local canWS = looneylib.checkWsBailout()
    if (canWS == false) then
        gFunc.CancelAction()
        return
    else
        local ws = gData.GetAction()

        gFunc.EquipSet(sets.WS)

        if hasDW then
            gFunc.EquipSet(sets.Centovente)
        end
    end
end

return profile
