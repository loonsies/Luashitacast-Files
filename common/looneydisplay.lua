local imgui = require('imgui')
local settings = require('settings')
local config = gFunc.LoadFile('common\\config.lua')
local utils = gFunc.LoadFile('common\\utils.lua')
local ffi = require('ffi')

local looneydisplay = {}

looneydisplay.visible = true
looneydisplay.configVisible = false
looneydisplay.buttons = {}
looneydisplay.config = {}
looneydisplay.lockTexture = nil
looneydisplay.unlockTexture = nil
looneydisplay.switchTexture = nil
looneydisplay.variables = {}

local zoning = false

local pGameMenu = ashita.memory.find('FFXiMain.dll', 0, '8B480C85C974??8B510885D274??3B05', 16, 0)
local pEventSystem = ashita.memory.find('FFXiMain.dll', 0, 'A0????????84C0741AA1????????85C0741166A1????????663B05????????0F94C0C3', 0, 0)
local pInterfaceHidden = ashita.memory.find('FFXiMain.dll', 0, '8B4424046A016A0050B9????????E8????????F6D81BC040C3', 0, 0)
local pChatExpanded = ashita.memory.find('FFXiMain.dll', 0, '83EC??B9????????E8????????0FBF4C24??84C0', 0x04, 0)


local function GetMenuName()
    local subPointer = ashita.memory.read_uint32(pGameMenu);
    local subValue = ashita.memory.read_uint32(subPointer);
    if (subValue == 0) then
        return '';
    end
    local menuHeader = ashita.memory.read_uint32(subValue + 4);
    local menuName = ashita.memory.read_string(menuHeader + 0x46, 16);
    return string.gsub(menuName, '\x00', '');
end

local function GetEventSystemActive()
    if (pEventSystem == 0) then
        return false
    end
    local ptr = ashita.memory.read_uint32(pEventSystem + 1)
    if (ptr == 0) then
        return false
    end

    return (ashita.memory.read_uint8(ptr) == 1)
end

local function GetInterfaceHidden()
    if (pEventSystem == 0) then
        return false
    end
    local ptr = ashita.memory.read_uint32(pInterfaceHidden + 10)
    if (ptr == 0) then
        return false
    end

    return (ashita.memory.read_uint8(ptr + 0xB4) == 1)
end

local function GetChatExpanded()
    local ptr = ashita.memory.read_uint32(pChatExpanded)
    if ptr == 0 then
        return false
    end

    return ashita.memory.read_uint8(ptr + 0xF1) ~= 0
end

local function ShouldHide()
    if (looneydisplay.config.hideWhileZoning and looneydisplay.config.hideWhileZoning[1]) then
        if (gData.LoggedIn == false) then
            return true
        end
    end

    if (looneydisplay.config.hideWhileCutscene and looneydisplay.config.hideWhileCutscene[1]) then
        if (GetEventSystemActive()) then
            return true
        end
    end

    if (looneydisplay.config.hideWhileMap and looneydisplay.config.hideWhileMap[1]) then
        if (string.match(GetMenuName(), 'map')) then
            return true
        end
    end

    if (looneydisplay.config.hideWhileChat and looneydisplay.config.hideWhileChat[1]) then
        if (GetChatExpanded()) then
            return true
        end
    end

    if (GetInterfaceHidden()) then
        return true
    end

    return false
end

local function coloredButton(name)
    local active = string.lower(looneylib.activeSet) == string.lower(name)

    if active then
        local activeColor = looneydisplay.config.activeButtonColor or { 0.5, 0.0, 0.5, 1.0 }
        imgui.PushStyleColor(ImGuiCol_Button, activeColor)
        imgui.PushStyleColor(ImGuiCol_ButtonHovered, activeColor)
        imgui.PushStyleColor(ImGuiCol_ButtonActive, activeColor)
    else
        local defaultColor = looneydisplay.config.defaultButtonColor or { 0.26, 0.59, 0.98, 1.0 }
        imgui.PushStyleColor(ImGuiCol_Button, defaultColor)
        imgui.PushStyleColor(ImGuiCol_ButtonHovered, defaultColor)
        imgui.PushStyleColor(ImGuiCol_ButtonActive, defaultColor)
    end

    if string.lower(name) == 'naked' then
        if imgui.Button(string.format('%s##looneydisplaybtn', name)) then
            looneylib.getNaked(name)
        end
    else
        if imgui.Button(string.format('%s##looneydisplaybtn', name)) then
            looneylib.switchSet(name)
        end
    end

    if active then
        imgui.PopStyleColor(3)
    else
        imgui.PopStyleColor(3)
    end
end

local function variableButton(buttonData)
    -- Find current option based on variable value
    local currentOption = nil
    for _, option in ipairs(buttonData) do
        if option.value == buttonData.variable[1] then
            currentOption = option
            break
        end
    end

    -- Fallback to first option if current value not found
    if not currentOption then
        currentOption = buttonData[1]
    end

    local defaultColor = looneydisplay.config.defaultButtonColor or { 0.26, 0.59, 0.98, 1.0 }
    local buttonColor = defaultColor
    if currentOption.color then
        local parsed = utils.parseColor(currentOption.color)
        if parsed then buttonColor = parsed end
    end
    imgui.PushStyleColor(ImGuiCol_Button, buttonColor)
    imgui.PushStyleColor(ImGuiCol_ButtonHovered, buttonColor)
    imgui.PushStyleColor(ImGuiCol_ButtonActive, buttonColor)


    -- Calculate max width for all possible button labels (with icon/gap)
    local textGap = '  '
    local maxLabelWidth = 0
    for _, option in ipairs(buttonData) do
        local label = string.format('%s%s', textGap, option.name)
        local textWidth = imgui.CalcTextSize(label)
        if textWidth > maxLabelWidth then
            maxLabelWidth = textWidth
        end
    end
    local iconSize = 12
    local iconPadding = 4
    local totalWidth = maxLabelWidth + (iconPadding * 2) + 2 -- add a little extra for frame

    local buttonText = string.format('%s%s##variablebtn_%s', textGap, currentOption.name, tostring(buttonData.variable))
    if imgui.Button(buttonText, { totalWidth, 0 }) then
        -- Find current index and rotate to next value
        local currentIndex = 1
        for i, option in ipairs(buttonData) do
            if option.value == buttonData.variable[1] then
                currentIndex = i
                break
            end
        end
        -- Rotate to next option (wrap around to 1 if at end)
        local nextIndex = (currentIndex % #buttonData) + 1
        buttonData.variable[1] = buttonData[nextIndex].value

        if buttonData[nextIndex].callback then
            buttonData[nextIndex].callback()
        end
    end

    -- Draw switch icon inside the button, just to the left of the text, with extra gap
    if looneydisplay.switchTexture then
        local buttonMinX, buttonMinY = imgui.GetItemRectMin()
        local iconSize = 12
        local iconPadding = 4
        local gapPadding = 4 -- extra gap between icon and text
        -- Place icon inside the button, a few pixels from the left edge
        local iconX = buttonMinX + iconPadding
        local iconY = buttonMinY + iconPadding

        local drawList = imgui.GetWindowDrawList()
        local iconColor = imgui.GetColorU32({ 1.0, 1.0, 1.0, 0.8 })

        drawList:AddImage(
            looneydisplay.switchTexture.Pointer,
            { iconX, iconY },
            { iconX + iconSize, iconY + iconSize },
            { 0, 0 },
            { 1, 1 },
            iconColor
        )
    end

    imgui.PopStyleColor(3)
end

function drawUI()
    if looneydisplay.config.hidden[1] or not looneydisplay.visible or zoning or ShouldHide() then
        return
    end

    imgui.PushStyleVar(ImGuiStyleVar_WindowPadding, { 2, 2 })
    imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, { 4, 0 })
    imgui.PushStyleVar(ImGuiStyleVar_FramePadding, { 2, 2 })
    imgui.PushStyleVar(ImGuiStyleVar_WindowBorderSize, 0)
    imgui.PushStyleVar(ImGuiStyleVar_WindowMinSize, { 0, 0 })

    -- Set window background color from config
    local bgColor = looneydisplay.config.windowBgColor or { 0.1, 0.1, 0.1, 0.85 }
    imgui.PushStyleColor(ImGuiCol_WindowBg, bgColor)

    local windowFlags = bit.bor(ImGuiWindowFlags_NoTitleBar, ImGuiWindowFlags_AlwaysAutoResize)
    if looneydisplay.config.locked[1] then
        windowFlags = bit.bor(windowFlags, ImGuiWindowFlags_NoMove, ImGuiWindowFlags_NoResize)
    end

    if not imgui.Begin('looneydisplay', looneydisplay.visible, windowFlags) then
        -- If window is collapsed or not visible, we still need to pop styles and end
        imgui.End()
        imgui.PopStyleColor(1)
        imgui.PopStyleVar(5)
        return
    end
    imgui.SetWindowFontScale(looneydisplay.config.scale[1])

    if looneydisplay.config.centered[1] then
        local displaySize = imgui.GetIO().DisplaySize
        local windowSizeX, windowSizeY = imgui.GetWindowSize()
        local centerX = (displaySize.x - windowSizeX) * 0.5
        local windowPosX, windowPosY = imgui.GetWindowPos()
        imgui.SetWindowPos({ centerX, windowPosY })
    end

    local firstButton = true
    local buttonGroups = {}
    local currentGroup = {}

    -- Group buttons by lines (separated by newlines)
    for id, name in pairs(looneydisplay.buttons) do
        if type(name) == 'string' and string.lower(name) == 'newline' then
            if #currentGroup > 0 then
                table.insert(buttonGroups, currentGroup)
                currentGroup = {}
            end
        else
            table.insert(currentGroup, name)
        end
    end
    -- Add the last group if it has items
    if #currentGroup > 0 then
        table.insert(buttonGroups, currentGroup)
    end

    -- Render each group
    for groupIndex, group in ipairs(buttonGroups) do
        if looneydisplay.config.centerButtons and looneydisplay.config.centerButtons[1] then
            -- Calculate actual width of this line
            local totalWidth = 0
            -- Use the actual values we set in PushStyleVar
            local spacingX = 4 -- from ImGuiStyleVar_ItemSpacing, { 4, 0 }
            local paddingX = 2 -- from ImGuiStyleVar_FramePadding, { 2, 2 }

            for i, name in ipairs(group) do
                if type(name) == 'string' and string.lower(name) == 'separator' then
                    local textWidth, textHeight = imgui.CalcTextSize('|')
                    totalWidth = totalWidth + textWidth
                elseif type(name) == 'table' and name.variable then
                    -- Calculate max width for all possible variable button labels (with icon/gap)
                    local textGap = '  '
                    local maxLabelWidth = 0
                    for _, option in ipairs(name) do
                        local label = string.format('%s%s', textGap, option.name)
                        local textWidth = imgui.CalcTextSize(label)
                        if textWidth > maxLabelWidth then
                            maxLabelWidth = textWidth
                        end
                    end
                    local iconPadding = 4
                    local totalVarWidth = maxLabelWidth + (iconPadding * 2) + (paddingX * 2) + 2
                    totalWidth = totalWidth + totalVarWidth
                else
                    -- Calculate button size (text + frame padding * 2)
                    local textWidth, textHeight = imgui.CalcTextSize(name)
                    totalWidth = totalWidth + textWidth + (paddingX * 2)
                end

                -- Add spacing between items (except for last item)
                if i < #group then
                    totalWidth = totalWidth + spacingX
                end
            end

            -- Center this line
            local windowWidth = imgui.GetContentRegionAvail()
            local padding = math.max(0, (windowWidth - totalWidth) * 0.5)
            imgui.SetCursorPosX(imgui.GetCursorPosX() + padding)
        end

        -- Render items in this group
        for i, name in ipairs(group) do
            if type(name) == 'string' and string.lower(name) == 'separator' then
                imgui.Text('|')
            elseif type(name) == 'table' and name.variable then
                -- This is a variable button
                variableButton(name)
            else
                coloredButton(name)
            end

            -- Add SameLine except for last item
            if i < #group then
                imgui.SameLine()
            end
        end

        -- Add vertical spacing between groups (same as horizontal spacing)
        if groupIndex < #buttonGroups then
            imgui.Dummy({ 0, 4 }) -- 4 pixels vertical spacing, same as horizontal
        end
    end

    -- Render padlock icon as overlay outside the main window
    if looneydisplay.lockTexture and looneydisplay.unlockTexture then
        -- Get main window position and size
        local windowPosX, windowPosY = imgui.GetWindowPos()
        local windowSizeX, windowSizeY = imgui.GetWindowSize()
        local iconSize = 20 -- Make it bigger so it's easier to see
        local padding = 0   -- Small gap from window edge

        -- Position outside the main window (top-right corner)
        local iconX = windowPosX + windowSizeX + padding -- Just outside right edge
        local iconY = windowPosY

        -- Choose texture based on state
        local textureData = looneylib.allSlots and looneydisplay.unlockTexture or looneydisplay.lockTexture
        local texturePointer = textureData.Pointer

        -- Get the draw list to draw directly on the screen
        local drawList = imgui.GetForegroundDrawList()

        -- Create proper color values for tinting the IMAGE itself using config colors
        local lockColor = looneydisplay.config.unlockedColor or { 0.2, 0.8, 0.2, 1.0 }
        local unlockColor = looneydisplay.config.lockedColor or { 0.8, 0.2, 0.2, 1.0 }

        local colorTint = looneylib.allSlots and
            imgui.GetColorU32(lockColor) or -- Use config enable color for locked (allSlots true)
            imgui.GetColorU32(unlockColor)  -- Use config disable color for unlocked (allSlots false)

        drawList:AddImage(texturePointer, { iconX, iconY }, { iconX + iconSize, iconY + iconSize }, { 0, 0 }, { 1, 1 }, colorTint)

        -- Check if mouse is over the padlock area for click detection
        local mouseX, mouseY = imgui.GetMousePos()

        if mouseX >= iconX and mouseX <= iconX + iconSize and
            mouseY >= iconY and mouseY <= iconY + iconSize then
            -- Capture mouse input to prevent it from going to other parts of the app
            local io = imgui.GetIO()
            io.WantCaptureMouse = true

            -- Show tooltip
            imgui.SetTooltip(looneylib.allSlots and 'Unlocked (Click to Lock)' or 'Locked (Click to Unlock)')

            -- Check for click
            if imgui.IsMouseClicked(0) then -- Left mouse button
                -- Toggle state when clicked
                looneylib.allSlots = not looneylib.allSlots
                AshitaCore:GetChatManager():QueueCommand(1, string.format('/lac %s', looneylib.allSlots and 'enable' or 'disable'))

                if looneylib.allSlots then
                    looneylib.activeSet = ''
                end
            end
        end
    end
    imgui.End()
    imgui.PopStyleColor(1)
    imgui.PopStyleVar(5)
end

function drawConfigUI()
    if not looneydisplay.configVisible or zoning then
        return
    end

    if imgui.Begin('looneydisplay config', looneydisplay.configVisible, ImGuiWindowFlags_AlwaysAutoResize) then
        imgui.Text('Display Settings')
        imgui.Separator()

        imgui.Text('Scale:')
        imgui.SameLine()
        local scale = looneydisplay.config.scale[1] * 100
        local scaleInt = { scale + 0.5 - (scale + 0.5) % 1 }
        if imgui.InputInt('##scale', scaleInt, 5, 10) then
            local newScale = scaleInt[1] / 100.0
            if newScale < 0.1 then newScale = 0.1 end
            if newScale > 5.0 then newScale = 5.0 end
            looneydisplay.config.scale[1] = newScale
            settings.save()
        end
        imgui.SameLine()
        imgui.Text('%')

        if imgui.Checkbox('Lock Position', looneydisplay.config.locked) then
            settings.save()
        end

        if imgui.Checkbox('Center Horizontally', looneydisplay.config.centered) then
            settings.save()
        end

        if imgui.Checkbox('Center Buttons', looneydisplay.config.centerButtons) then
            settings.save()
        end

        if imgui.Checkbox('Hide Main UI', looneydisplay.config.hidden) then
            settings.save()
        end

        imgui.Separator()
        imgui.Text('Auto-Hide Settings')

        if imgui.Checkbox('Hide While Zoning', looneydisplay.config.hideWhileZoning) then
            settings.save()
        end

        if imgui.Checkbox('Hide While Cutscene', looneydisplay.config.hideWhileCutscene) then
            settings.save()
        end

        if imgui.Checkbox('Hide While Map Open', looneydisplay.config.hideWhileMap) then
            settings.save()
        end

        if imgui.Checkbox('Hide While Chat Expanded', looneydisplay.config.hideWhileChat) then
            settings.save()
        end

        imgui.Separator()

        -- Window Background Color
        imgui.Text('Button Window Background:')
        local windowBgColor = looneydisplay.config.windowBgColor or { 0.1, 0.1, 0.1, 0.85 }
        if imgui.ColorEdit4('##windowbgcolor', windowBgColor) then
            looneydisplay.config.windowBgColor = windowBgColor
            settings.save()
        end

        -- Default Button Color
        imgui.Text('Default Button Color:')
        local defaultColor = looneydisplay.config.defaultButtonColor or { 0.26, 0.59, 0.98, 1.0 }
        if imgui.ColorEdit4('##defaultcolor', defaultColor) then
            looneydisplay.config.defaultButtonColor = defaultColor
            settings.save()
        end

        -- Active Button Color
        imgui.Text('Active Button Color:')
        local activeColor = looneydisplay.config.activeButtonColor or { 0.5, 0.0, 0.5, 1.0 }
        if imgui.ColorEdit4('##activecolor', activeColor) then
            looneydisplay.config.activeButtonColor = activeColor
            settings.save()
        end

        -- Unlocked Color
        imgui.Text('Unlocked Color:')
        local enableColor = looneydisplay.config.unlockedColor or { 0.2, 0.8, 0.2, 1.0 }
        if imgui.ColorEdit4('##enablecolor', enableColor) then
            looneydisplay.config.unlockedColor = enableColor
            settings.save()
        end

        -- Locked Color
        imgui.Text('Locked Color:')
        local disableColor = looneydisplay.config.lockedColor or { 0.8, 0.2, 0.2, 1.0 }
        if imgui.ColorEdit4('##disablecolor', disableColor) then
            looneydisplay.config.lockedColor = disableColor
            settings.save()
        end

        imgui.Separator()

        if imgui.Button('Reset to defaults') then
            looneydisplay.config.scale = { 1.0 }
            looneydisplay.config.locked = { false }
            looneydisplay.config.hidden = { false }
            looneydisplay.config.centered = { false }
            looneydisplay.config.centerButtons = { false }
            looneydisplay.config.hideWhileZoning = { false }
            looneydisplay.config.hideWhileCutscene = { false }
            looneydisplay.config.hideWhileMap = { false }
            looneydisplay.config.hideWhileChat = { false }
            looneydisplay.config.defaultButtonColor = { 0.26, 0.59, 0.98, 1.0 }
            looneydisplay.config.activeButtonColor = { 0.5, 0.0, 0.5, 1.0 }
            looneydisplay.config.unlockedColor = { 0.2, 0.8, 0.2, 1.0 }
            looneydisplay.config.lockedColor = { 0.8, 0.2, 0.2, 1.0 }
            looneydisplay.config.windowBgColor = { 0.1, 0.1, 0.1, 0.85 }
            settings.save()
        end
    end
    imgui.End()
end

function looneydisplay.createButton(name)
    local n = #looneydisplay.buttons
    looneydisplay.buttons[n + 1] = name
end

function looneydisplay.initialize(sets)
    looneydisplay.config = config.load()

    -- Set default values for hide settings if they don't exist
    if looneydisplay.config.hideWhileZoning == nil then
        looneydisplay.config.hideWhileZoning = { false }
    end
    if looneydisplay.config.hideWhileCutscene == nil then
        looneydisplay.config.hideWhileCutscene = { false }
    end
    if looneydisplay.config.hideWhileMap == nil then
        looneydisplay.config.hideWhileMap = { false }
    end
    if looneydisplay.config.hideWhileChat == nil then
        looneydisplay.config.hideWhileChat = { false }
    end
    if looneydisplay.config.centerButtons == nil then
        looneydisplay.config.centerButtons = { false }
    end

    looneydisplay.visible = true
    looneydisplay.configVisible = false
    looneydisplay.buttons = {}
    looneylib.activeSet = ''
    looneylib.allSlots = true
    looneylib.variables = {}

    -- Use ipairs to maintain order for array-style tables
    for i, name in ipairs(sets) do
        looneydisplay.createButton(name)

        -- If this is a variable button, register it with looneylib
        if type(name) == 'table' and name.variable then
            -- Check if the button has an explicit varName field
            local varName = name.varName

            -- If no explicit name, try to generate one from the options
            if not varName and name[1] and name[1].name then
                if #name >= 2 then
                    -- Use a combination of the first two option names
                    varName = string.lower(name[1].name .. '_' .. name[2].name)
                else
                    varName = string.lower(name[1].name)
                end
            end

            -- Register with looneylib if we have a name
            if varName then
                looneylib.registerVariable(varName, name.variable, name)
            end
        end
    end

    -- Load padlock textures
    if looneydisplay.lockTexture == nil then
        local lockPath = string.format('%s/config/addons/luashitacast/common/assets/lock.png', AshitaCore:GetInstallPath())
        looneydisplay.lockTexture = utils.createTextureFromFile(lockPath)
        if looneydisplay.lockTexture ~= nil then
            looneydisplay.lockTexture.Pointer = tonumber(ffi.cast('uint32_t', looneydisplay.lockTexture.Texture))
        end
    end

    if looneydisplay.unlockTexture == nil then
        local unlockPath = string.format('%s/config/addons/luashitacast/common/assets/unlock.png', AshitaCore:GetInstallPath())
        looneydisplay.unlockTexture = utils.createTextureFromFile(unlockPath)
        if looneydisplay.unlockTexture ~= nil then
            looneydisplay.unlockTexture.Pointer = tonumber(ffi.cast('uint32_t', looneydisplay.unlockTexture.Texture))
        end
    end

    -- Load switch texture
    if looneydisplay.switchTexture == nil then
        local switchPath = string.format('%s/config/addons/luashitacast/common/assets/switch.png', AshitaCore:GetInstallPath())
        looneydisplay.switchTexture = utils.createTextureFromFile(switchPath)
        if looneydisplay.switchTexture ~= nil then
            looneydisplay.switchTexture.Pointer = tonumber(ffi.cast('uint32_t', looneydisplay.switchTexture.Texture))
        end
    end
    ashita.events.register('d3d_present', 'looneydisplay_d3d_present_cb', function ()
        drawUI()
        drawConfigUI()
    end)

    ashita.events.register('packet_in', 'looneydisplay_packet_in_cb', function (e)
        if e.id == 0x000A then
            zoning = false
        elseif e.id == 0x000B then
            zoning = true
        end
    end)
end

function looneydisplay.unload()
    ashita.events.unregister('d3d_present', 'looneydisplay_d3d_present_cb')
    ashita.events.unregister('packet_in', 'looneydisplay_packet_in_cb')

    -- Clean up textures
    if looneydisplay.lockTexture then
        looneydisplay.lockTexture = nil
    end
    if looneydisplay.unlockTexture then
        looneydisplay.unlockTexture = nil
    end
end

return looneydisplay
