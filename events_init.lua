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

-- This module depends on gui_guider.lua.
-- Screen setup files will be loaded on-demand by the animation function.
local gui_guider = require("APP.main.gui_guider")

local events = {}

function events.events_init_main(ui)
    local function main_list_1_item0_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            -- Create a wrapper table to simulate pass-by-reference for the boolean flag
            local old_scr_del_ref = { value = ui.main_del }
            gui_guider.ui_load_scr_animation(ui, "WiFi", ui.WiFi_del, old_scr_del_ref, "APP.main.setup_scr_WiFi", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, true, true)
            ui.main_del = old_scr_del_ref.value -- Update the value from the reference table
        end
    end

    local function main_list_1_item1_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            local old_scr_del_ref = { value = ui.main_del }
            gui_guider.ui_load_scr_animation(ui, "Bluetooth", ui.Bluetooth_del, old_scr_del_ref, "APP.main.setup_scr_Bluetooth", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, false, true)
            ui.main_del = old_scr_del_ref.value
        end
    end

    local function main_list_1_item2_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            local old_scr_del_ref = { value = ui.main_del }
            gui_guider.ui_load_scr_animation(ui, "Hotspot", ui.Hotspot_del, old_scr_del_ref, "APP.main.setup_scr_Hotspot", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, false, true)
            ui.main_del = old_scr_del_ref.value
        end
    end

    lvgl.obj_add_event_cb(ui.main_list_1_item0, main_list_1_item0_event_handler)
    lvgl.obj_add_event_cb(ui.main_list_1_item1, main_list_1_item1_event_handler)
    lvgl.obj_add_event_cb(ui.main_list_1_item2, main_list_1_item2_event_handler)
end

function events.events_init_WiFi(ui)
    local function WiFi_btn_1_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            local old_scr_del_ref = { value = ui.WiFi_del }
            -- The main screen is already loaded, so we don't need to re-run its setup.
            -- However, to keep the animation logic consistent, we pass a dummy function name
            -- and handle it inside the animation function if needed. Or, more simply,
            -- just load the screen directly if it already exists.
            -- For now, we assume re-creating it is fine.
            gui_guider.ui_load_scr_animation(ui, "main", ui.main_del, old_scr_del_ref, "APP.main.setup_scr_main", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, true, true)
            ui.WiFi_del = old_scr_del_ref.value
        end
    end

    lvgl.obj_add_event_cb(ui.WiFi_btn_1, WiFi_btn_1_event_handler)
end

function events.events_init_wifi_password(ui)
    local function wifi_password_btn_2_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            local old_scr_del_ref = { value = ui.wifi_password_del }
            gui_guider.ui_load_scr_animation(ui, "WiFi", ui.WiFi_del, old_scr_del_ref, "APP.main.setup_scr_WiFi", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, true, true)
            ui.wifi_password_del = old_scr_del_ref.value
        end
    end

    lvgl.obj_add_event_cb(ui.wifi_password_btn_2, wifi_password_btn_2_event_handler)
end

function events.events_init_Bluetooth(ui)
    local function Bluetooth_btn_1_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            local old_scr_del_ref = { value = ui.Bluetooth_del }
            gui_guider.ui_load_scr_animation(ui, "main", ui.main_del, old_scr_del_ref, "APP.main.setup_scr_main", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, true, true)
            ui.Bluetooth_del = old_scr_del_ref.value
        end
    end

    lvgl.obj_add_event_cb(ui.Bluetooth_btn_1, Bluetooth_btn_1_event_handler)
end

function events.events_init_Hotspot(ui)
    local function Hotspot_btn_1_event_handler(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED then
            local old_scr_del_ref = { value = ui.Hotspot_del }
            gui_guider.ui_load_scr_animation(ui, "main", ui.main_del, old_scr_del_ref, "APP.main.setup_scr_main", lvgl.SCR_LOAD_ANIM_NONE, 200, 200, true, true)
            ui.Hotspot_del = old_scr_del_ref.value
        end
    end

    lvgl.obj_add_event_cb(ui.Hotspot_btn_1, Hotspot_btn_1_event_handler)
end

-- This function is empty in the C code.
function events.events_init(ui)
end

return events
