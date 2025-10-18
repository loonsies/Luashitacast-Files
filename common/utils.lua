utils = {}

local ffi = require('ffi')
local d3d8 = require('d3d8')

function utils.createTextureFromFile(path)
    if (path ~= nil) then
        local dx_texture_ptr = ffi.new('IDirect3DTexture8*[1]')
        local d3d8_device = d3d8.get_device()
        if (ffi.C.D3DXCreateTextureFromFileA(d3d8_device, path, dx_texture_ptr) == ffi.C.S_OK) then
            local texture = d3d8.gc_safe_release(ffi.cast('IDirect3DTexture8*', dx_texture_ptr[0]))
            local result, desc = texture:GetLevelDesc(0)
            if result == 0 then
                tx         = {}
                tx.Texture = texture
                tx.Width   = desc.Width
                tx.Height  = desc.Height
                return tx
            end
            return
        end
    end
end

-- Accepts hex string (#RRGGBB or RRGGBB), or 'r, g, b a' (e.g. '255, 255, 255 1')
function utils.parseColor(input, alpha)
    if type(input) == 'table' and #input == 4 then
        -- Accept both 0-1 and 0-255 ranges
        local r, g, b, a = input[1], input[2], input[3], input[4]
        if r > 1 or g > 1 or b > 1 or a > 1 then
            return { r / 255, g / 255, b / 255, a > 1 and a / 255 or a }
        else
            return input
        end
    end
    if type(input) ~= 'string' then return nil end
    local hex = input:gsub('#', '')
    if #hex == 6 then
        local r = tonumber(hex:sub(1, 2), 16) or 0
        local g = tonumber(hex:sub(3, 4), 16) or 0
        local b = tonumber(hex:sub(5, 6), 16) or 0
        return { r / 255, g / 255, b / 255, alpha or 1.0 }
    end
    -- Try to parse 'r, g, b, a' format
    local r, g, b, a = input:match('(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,%s*([%d%.]+)')
    if r and g and b and a then
        r = tonumber(r) or 0
        g = tonumber(g) or 0
        b = tonumber(b) or 0
        a = tonumber(a) or alpha or 1.0
        if a > 1 then a = a / 255 end
        return { r / 255, g / 255, b / 255, a }
    end
    return nil
end

return utils
