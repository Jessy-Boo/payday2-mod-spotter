if RequiredScript ~= "lib/units/beings/player/states/playerstandard" then return end

local marked_units = {}
local timer = 0
local config = { interval = 0.2, range = 40000 }

local function markable(unit)
    if not alive(unit) then return false end
    if unit:character_damage() and unit:character_damage():dead() then return false end
    if unit:brain() and unit:brain():is_hostage() then return false end
    local s = unit:slot()
    if s == 12 or s == 21 or s == 22 then return true end
    if managers.enemy:is_civilian(unit) then return true end
    return false
end

Hooks:PostHook(PlayerStandard, "update", "WFA_ADS_Mark", function(self, t, dt)
    dt = dt or 0
    if not self._state_data or not self._state_data.in_steelsight then
        timer = 0
        return
    end
    timer = timer + dt
    if timer < config.interval then return end
    timer = 0

    local camera = self._camera_unit
    if not camera then return end
    local cam_pos = camera:position()
    local cam_fwd = camera:rotation():y()

    local ray = World:raycast("ray", cam_pos, cam_pos + cam_fwd * config.range, "slot_mask", managers.slot:get_mask("bullet_impact_targets"))
    if not ray or not ray.unit or type(ray.unit) ~= "userdata" then return end

    local unit = ray.unit
    if unit:in_slot(8) and alive(unit:parent()) then
        unit = unit:parent()
    end

    if markable(unit) then
        local k = unit:key()
        if not marked_units[k] then
            marked_units[k] = true
            pcall(managers.game_play_central.auto_highlight_enemy, managers.game_play_central, unit, true)
        end
    end
end)
