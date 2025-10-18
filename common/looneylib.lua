local looneylib        = T {}
local looneydisplay    = gFunc.LoadFile('common\\looneydisplay.lua')

-- cooldown tracker
looneylib.lastUsed     = {
    warpRing = -math.huge,
    meaRing = -math.huge,
    echadRing = -math.huge,
    empressBand = -math.huge,
    trizekRing = -math.huge,
    endorsementRing = -math.huge,
    capacityRing = -math.huge,
    facilityRing = -math.huge,
    caliberRing = -math.huge,
}

looneylib.aliasList    = T {
    'ridemount', 'warpring', 'echadring', 'empressband', 'trizekring', 'endorsementring',
    'capacityring', 'facilityring', 'mearing', 'caliberring',
    'looneydisplay', 'ld', 'lset', 'lvariable', 'lenable', 'ldisable'
}
looneylib.lockingRings = T {
    'Echad Ring', 'Trizek Ring', 'Endorsement Ring', 'Capacity Ring', 'Warp Ring',
    'Facility Ring', 'Dim. Ring (Dem)', 'Dim. Ring (Mea)', 'Dim. Ring (Holla)', 'Empress band'
}
looneylib.distanceWS   = T {
    'Flaming Arrow', 'Piercing Arrow', 'Dulling Arrow', 'Sidewinder', 'Blast Arrow',
    'Arching Arrow', 'Empyreal Arrow', 'Refulgent Arrow', 'Apex Arrow', 'Namas Arrow',
    'Jishnu\'s Randiance', 'Hot Shot', 'Split Shot', 'Sniper Shot', 'Slug Shot', 'Blast Shot',
    'Heavy Shot', 'Detonator', 'Numbing Shot', 'Last Stand', 'Coronach', 'Wildfire',
    'Trueflight', 'Leaden Salute', 'Myrkr', 'Dagan', 'Moonlight', 'Starlight'
}
looneylib.settings     = T {
    WScheck = true,
    WSdistance = 8.0
}

looneylib.activeSet    = ''
looneylib.allSlots     = true
looneylib.variables    = {}

local vanaOffset       = 0x3C307D70
local timePointer      = ashita.memory.find('FFXiMain.dll', 0, '8B0D????????8B410C8B49108D04808D04808D04808D04C1C3', 2, 0)

local function GetTimeUTC()
    local ptr = ashita.memory.read_uint32(timePointer)
    ptr = ashita.memory.read_uint32(ptr)
    return ashita.memory.read_uint32(ptr + 0x0C)
end

function looneylib.setAlias()
    for _, v in ipairs(looneylib.aliasList) do
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /' .. v .. ' /lac fwd ' .. v)
    end
end

function looneylib.clearAlias()
    for _, v in ipairs(looneylib.aliasList) do
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /' .. v)
    end
end

function looneylib.switchSet(name)
    if not name or name == '' then
        return
    end

    AshitaCore:GetChatManager():QueueCommand(1, '/lac enable')
    AshitaCore:GetChatManager():QueueCommand(1, string.format('/lac set %s 10', name))
    ashita.tasks.once(1, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lac disable')
    end)
    looneylib.activeSet = name
    looneylib.allSlots = false
end

function looneylib.getNaked(name)
    if not name or name == '' then
        return
    end

    AshitaCore:GetChatManager():QueueCommand(1, '/lac naked')
    ashita.tasks.once(1, function ()
        AshitaCore:GetChatManager():QueueCommand(1, '/lac disable')
    end)
    looneylib.activeSet = name
    looneylib.allSlots = false
end

function looneylib.resetSet()
    looneylib.activeSet = ''
    looneylib.allSlots = true
end

function looneylib.registerVariable(name, variableRef, buttonData)
    looneylib.variables[string.lower(name)] = {
        variable = variableRef,
        buttonData = buttonData
    }
end

function looneylib.setVariable(name, value)
    local varName = string.lower(name)
    local varEntry = looneylib.variables[varName]

    if not varEntry then
        print(chat.header('looneylib'):append(chat.error(
            string.format('Variable "%s" not found', name)
        )))
        return false
    end

    -- Convert value to number if it's a string number
    local numValue = tonumber(value)
    if not numValue then
        print(chat.header('looneylib'):append(chat.error(
            string.format('Invalid value "%s" - must be a number', value)
        )))
        return false
    end

    -- Check if this value exists in the button options
    local foundOption = nil
    for i, option in ipairs(varEntry.buttonData) do
        if option.value == numValue then
            foundOption = option
            break
        end
    end

    if not foundOption then
        print(chat.header('looneylib'):append(chat.error(
            string.format('Value %d not found for variable "%s"', numValue, name)
        )))
        return false
    end

    -- Set the variable value
    varEntry.variable[1] = numValue

    -- Execute callback if it exists
    if foundOption.callback then
        foundOption.callback()
    end

    print(chat.header('looneylib'):append(chat.message(
        string.format('Variable "%s" set to %s (%d)', name, foundOption.name, numValue)
    )))

    return true
end

function looneylib.handleCommands(args)
    if (args[1] == 'lset') then
        looneylib.switchSet(args[2])
    elseif (args[1] == 'lenable') then
        looneylib.allSlots = true
        looneylib.activeSet = ''
        AshitaCore:GetChatManager():QueueCommand(1, '/lac enable')
    elseif (args[1] == 'ldisable') then
        looneylib.allSlots = false
        AshitaCore:GetChatManager():QueueCommand(1, '/lac disable')
    elseif (args[1] == 'lvariable') then
        if not args[2] then
            print(chat.header('looneylib'):append(chat.error('Usage: /lvariable <variableName> <value>')))
            print(chat.header('looneylib'):append(chat.message('Available variables:')))
            for varName, _ in pairs(looneylib.variables) do
                print(chat.header('looneylib'):append(chat.message('  - ' .. varName)))
            end
        elseif not args[3] then
            print(chat.header('looneylib'):append(chat.error('Usage: /lvariable <variableName> <value>')))
        else
            looneylib.setVariable(args[2], args[3])
        end
    elseif (args[1] == 'ridemount') then
        looneylib.doRideMount()
    elseif (args[1] == 'warpring') then
        looneylib.doWarpRing()
    elseif (args[1] == 'mearing') then
        looneylib.doMeaRing()
    elseif (args[1] == 'echadring') then
        looneylib.doEchadRing()
    elseif (args[1] == 'empressband') then
        looneylib.doEmpressBand()
    elseif (args[1] == 'trizekring') then
        looneylib.doTrizekRing()
    elseif (args[1] == 'endorsementring') then
        looneylib.doEndorsementRing()
    elseif (args[1] == 'capacityring') then
        looneylib.doCapacityRing()
    elseif (args[1] == 'facilityring') then
        looneylib.doFacilityRing()
    elseif (args[1] == 'caliberring') then
        looneylib.doCaliberRing()
    elseif (args[1] == 'looneydisplay' or args[1] == 'ld') then
        looneydisplay.configVisible = not looneydisplay.configVisible
    end
end

function looneylib.checkRingCooldowns()
    local currentTime = GetTimeUTC()
    -- Map of lastUsed keys to item names in inventory
    local keyToName = {
        warpRing = 'Warp Ring',
        meaRing = 'Dim. Ring (Mea)',
        echadRing = 'Echad Ring',
        empressBand = 'Empress Band',
        trizekRing = 'Trizek Ring',
        endorsementRing = 'Endorsement Ring',
        capacityRing = 'Capacity Ring',
        facilityRing = 'Facility Ring',
        caliberRing = 'Caliber Ring',
    }

    local keyToDuration = {
        warpRing = 600,
        meaRing = 600,
        echadRing = 7200,
        empressBand = 900,
        trizekRing = 7200,
        endorsementRing = 7200,
        capacityRing = 900,
        facilityRing = 900,
        caliberRing = 900,
    }

    for key, name in pairs(keyToName) do
        if not keyToDuration[key] then
            print(chat.header('looneylib'):append(chat.error(string.format('[looneylib] No duration set for %s', name))))
            return
        end

        for slot = 1, 80 do
            local inventoryItem = AshitaCore:GetMemoryManager():GetInventory():GetContainerItem(0, slot)
            if inventoryItem and inventoryItem.Id > 0 then
                local item = AshitaCore:GetResourceManager():GetItemById(inventoryItem.Id)

                if item.Name[1] == name then
                    local useTime = struct.unpack('L', inventoryItem.Extra, 5)
                    local useTimeRemaining = (useTime + vanaOffset) - currentTime
                    if useTimeRemaining > 0 then
                        looneylib.lastUsed[key] = currentTime - (keyToDuration[key] - useTimeRemaining)
                        print(chat.header('looneylib'):append(chat.warning(string.format(
                            '[looneylib] %s in slot %d: Use CD: %d', item.Name[1], slot, useTimeRemaining))))
                    end
                    break
                end
            end
        end
    end
end

local function forceIdleSet()
    AshitaCore:GetChatManager():QueueCommand(1, '/lac set Idle')
end

local function isOnMount()
    local index = AshitaCore:GetMemoryManager():GetParty():GetMemberTargetIndex(0)
    return AshitaCore:GetMemoryManager():GetEntity():GetStatus(index) == 85
end

function looneylib.checklockingRings()
    local rings = gData.GetEquipment()
    if (rings.Ring1 ~= nil) and (looneylib.lockingRings:contains(rings.Ring1.Name)) then
        gFunc.Equip('Ring1', rings.Ring1.Name)
    end
    if (rings.Ring2 ~= nil) and (looneylib.lockingRings:contains(rings.Ring2.Name)) then
        gFunc.Equip('Ring2', rings.Ring2.Name)
    end
end

function looneylib.checkWsBailout()
    local player = gData.GetPlayer()
    local ws = gData.GetAction()
    local target = gData.GetActionTarget()
    local sleep = gData.GetBuffCount('Sleep')
    local petrify = gData.GetBuffCount('Petrification')
    local stun = gData.GetBuffCount('Stun')
    local terror = gData.GetBuffCount('Terror')
    local amnesia = gData.GetBuffCount('Amnesia')
    local charm = gData.GetBuffCount('Charm')

    if looneylib.settings.WScheck and not looneylib.distanceWS:contains(ws.Name) and
        (tonumber(target.Distance) > looneylib.settings.WSdistance) then
        print(chat.header('looneylib'):append(chat.error(
            'Distance to mob is too far! Move closer or increase WS distance')))
        return false
    elseif (player.TP <= 999) or (sleep + petrify + stun + terror + amnesia + charm >= 1) then
        return false
    end

    return true
end

function looneylib.doRideMount()
    if not isOnMount() then
        AshitaCore:GetChatManager():QueueCommand(1, '/jump motion')
    end
    AshitaCore:GetChatManager():QueueCommand(1, '/mount random')

    ashita.tasks.once(2, function ()
        if isOnMount() then
            AshitaCore:GetChatManager():QueueCommand(1, '/em jumps and enables megafast crabbing mode :3')
        end
    end)
end

-- helper with remaining cooldown display
local function isOnCooldown(name, timer, key)
    local now = GetTimeUTC()
    local elapsed = now - (looneylib.lastUsed[key] or 0)
    if elapsed < timer then
        local remain = math.ceil(timer - elapsed)
        print(chat.header('looneylib'):append(chat.error(
            string.format('%s is on cooldown (%ds remaining)', name, remain)
        )))
        return true
    end
    return false
end

function looneylib.doTimedTPRing(name, timer, key, message)
    if isOnCooldown(name, timer, key) then return end

    if not looneylib.allSlots then
        looneylib.allSlots = true
        looneylib.activeSet = ''
        AshitaCore:GetChatManager():QueueCommand(1, '/lac enable')
    end

    AshitaCore:GetChatManager():QueueCommand(1, string.format('/lac equip ring2 "%s"', name))

    local function useRing()
        local currentZoneID = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)
        AshitaCore:GetChatManager():QueueCommand(1, string.format('/item "%s" <me>', name))

        if message then
            ashita.tasks.once(10, function ()
                AshitaCore:GetChatManager():QueueCommand(1, string.format('/em %s', message))
            end)
        end

        ashita.tasks.once(20, function ()
            local currentZoneID2 = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)
            if currentZoneID ~= currentZoneID2 then
                looneylib.lastUsed[key] = GetTimeUTC()
                AshitaCore:GetChatManager():QueueCommand(1, string.format('/tt custom "%s" %ss', name, timer))
            end
        end)
        forceIdleSet:once(8)
    end

    useRing:once(11)
end

function looneylib.doTimedRing(name, timer, key)
    if isOnCooldown(name, timer, key) then return end

    AshitaCore:GetChatManager():QueueCommand(1, string.format('/lac equip ring2 "%s"', name))

    local function useRing()
        AshitaCore:GetChatManager():QueueCommand(1, string.format('/item "%s" <me>', name))
        AshitaCore:GetChatManager():QueueCommand(1, string.format('/tt custom "%s" %ss', name, timer))
        looneylib.lastUsed[key] = GetTimeUTC()
        forceIdleSet:once(8)
    end

    useRing:once(11)
end

-- individual rings
function looneylib.doWarpRing()
    looneylib.doTimedTPRing('Warp Ring', 600, 'warpRing', 'vanishes into thin air')
end

function looneylib.doMeaRing()
    looneylib.doTimedTPRing('Dim. Ring (Mea)', 600, 'meaRing', 'disappeared suddenly ?')
end

function looneylib.doEndorsementRing()
    looneylib.doTimedRing('Endorsement Ring', 7200, 'endorsementRing')
end

function looneylib.doTrizekRing()
    looneylib.doTimedRing('Trizek Ring', 7200, 'trizekRing')
end

function looneylib.doFacilityRing()
    looneylib.doTimedRing('Facility Ring', 900, 'facilityRing')
end

function looneylib.doCapacityRing()
    looneylib.doTimedRing('Capacity Ring', 900, 'capacityRing')
end

function looneylib.doEchadRing()
    looneylib.doTimedRing('Echad Ring', 7200, 'echadRing')
end

function looneylib.doEmpressBand()
    looneylib.doTimedRing('Empress Band', 900, 'empressBand')
end

function looneylib.doCaliberRing()
    looneylib.doTimedRing('Caliber Ring', 900, 'caliberRing')
end

function looneylib.unload()
    looneylib.clearAlias()
    looneydisplay.unload()
end

function looneylib.checkDefault()
    looneylib.checklockingRings()
end

function looneylib.initialize(sets)
    looneylib.checkRingCooldowns()

    looneylib.setAlias:once(2)
    looneydisplay.initialize(sets)
end

return looneylib
