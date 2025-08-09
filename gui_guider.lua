--
-- Copyright 2025 NXP
-- NXP Proprietary. This software is owned or controlled by NXP and may only be used strictly in
-- accordance with the applicable license terms. By expressly accepting such terms or by downloading, installing,
-- activating and/or otherwise using the software, you are agreeing that you have read, and that you agree to
-- comply with and are bound by, such license terms.  If you do not agree to be bound by the applicable license
-- terms, then you may not retain, install, activate or otherwise use the software.
--
-- Translated from C to Lua for LuaRTOS
--

local gui_guider = {}

-- Screen setup modules will be required on-demand to save memory and stack.

function gui_guider.ui_init_style(style)
    -- In Lua, styles are tables. Resetting can be done by clearing the table.
    -- This is a conceptual translation. The lvgl bindings might handle this differently.
    if style and next(style) ~= nil then
        for k in pairs(style) do
            style[k] = nil
        end
    end
    -- lv_style_init is implicit when a new table is created.
end

function gui_guider.ui_load_scr_animation(ui, new_scr_ref, new_scr_del, old_scr_del_ref, setup_scr_func_name,
                                   anim_type, time, delay, is_clean, auto_del)
    local act_scr = lvgl.scr_act()

    -- The logic for gg_edata_task_clear is part of FreeMaster and not applicable here.
    -- We will skip it.

    if auto_del and is_clean then
        lvgl.obj_clean(act_scr)
    end

    if new_scr_del then
        -- On-demand require and execute the setup function
        print("On-demand loading: " .. setup_scr_func_name)
        local setup_module = require(setup_scr_func_name)
        if setup_module then
            setup_module(ui)
        else
            print("FATAL: Could not load module " .. setup_scr_func_name)
            return
        end
    end

    -- After setup function, ui[new_scr_ref] should hold the new screen object
    local new_scr = ui[new_scr_ref]
    if new_scr then
        lvgl.scr_load_anim(new_scr, anim_type, time, delay, auto_del)
    else
        print("Error: New screen object is nil after setup function.")
    end

    -- Update the old screen deletion flag reference
    old_scr_del_ref.value = auto_del
end

-- TODO: The entire lv_anim API is not bound in the current Lua bindings.
-- This function cannot be fully implemented without adding bindings for:
-- lv_anim_init, lv_anim_set_var, lv_anim_set_exec_cb, lv_anim_set_values,
-- lv_anim_set_time, lv_anim_set_delay, lv_anim_set_path_cb, etc., and lv_anim_start.
-- This is a placeholder implementation.
function gui_guider.ui_animation(var, duration, delay, start_value, end_value, path_cb,
                          repeat_cnt, repeat_delay, playback_time, playback_delay,
                          exec_cb, start_cb, ready_cb, deleted_cb)
    print("Warning: ui_animation is not implemented due to missing lv_anim bindings.")
    -- Placeholder for animation logic
    -- local anim = {}
    -- anim.var = var
    -- anim.exec_cb = exec_cb
    -- anim.values = { start_value, end_value }
    -- anim.time = duration
    -- anim.delay = delay
    -- ... and so on
    -- lvgl.anim_start(anim) -- This function doesn't exist
end

function gui_guider.init_scr_del_flag(ui)
    ui.main_del = true
    ui.WiFi_del = true
    ui.wifi_password_del = true
    ui.Bluetooth_del = true
    ui.Hotspot_del = true
end

function gui_guider.init_keyboard(ui)
    -- This function is empty in the C code.
end

function gui_guider.setup_ui(ui)
    gui_guider.init_scr_del_flag(ui)
    gui_guider.init_keyboard(ui)

    -- Initially, only set up the main screen.
    -- Other screens will be loaded on demand by events.
    print("Loading initial screen: main")
    local setup_scr_main = require("APP.main.setup_scr_main")
    setup_scr_main(ui)

    -- lv_scr_load is not directly bound. Use lv_scr_load_anim with no animation.
    if ui.main then
        -- Assuming LV_SCR_LOAD_ANIM_NONE is 0 or available in lvgl constants
        local anim_none = lvgl.SCR_LOAD_ANIM_NONE()
        lvgl.scr_load_anim(ui.main, anim_none, 0, 0, false)
    else
        print("Error: ui.main screen not available after setup.")
    end
end

return gui_guider
