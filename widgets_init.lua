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

local widgets_init = {}

-- Event callback for keyboard
function widgets_init.kb_event_cb(e)
    local code = lvgl.event_get_code(e)
    local kb = lvgl.event_get_target(e)

    if code == lvgl.EVENT_READY() or code == lvgl.EVENT_CANCEL() then
        lvgl.obj_add_flag(kb, lvgl.OBJ_FLAG_HIDDEN())
    end
end

-- This is a factory function that returns the event callback for a text area.
-- It captures the 'ui' table so the callback can access the global keyboard.
function widgets_init.get_ta_event_cb(ui)
    return function(e)
        local code = lvgl.event_get_code(e)
        local ta = lvgl.event_get_target(e)
        -- Access the keyboard from the captured 'ui' table.
        -- This assumes 'ui.g_kb_top_layer' is created and assigned elsewhere.
        local kb = ui.g_kb_top_layer

        if not kb then
            print("Warning: Keyboard object 'ui.g_kb_top_layer' is not available in ta_event_cb.")
            return
        end

        if code == lvgl.EVENT_FOCUSED() or code == lvgl.EVENT_CLICKED() then
            if lvgl.keyboard_set_textarea then
                lvgl.keyboard_set_textarea(kb, ta)
            else
                print("Warning: lvgl.keyboard_set_textarea binding not found.")
            end

            -- TODO: Binding for lv_zh_keyboard_set_textarea does not exist.
            -- TODO: Binding for lv_obj_move_foreground does not exist.
            print("Warning: lv_obj_move_foreground binding not found.")

            lvgl.obj_clear_flag(kb, lvgl.OBJ_FLAG_HIDDEN())

        elseif code == lvgl.EVENT_CANCEL() or code == lvgl.EVENT_DEFOCUSED() then
            if lvgl.keyboard_set_textarea then
                lvgl.keyboard_set_textarea(kb, ta)
            end

            -- TODO: Binding for lv_obj_move_background does not exist.
            print("Warning: lv_obj_move_background binding not found.")

            lvgl.obj_add_flag(kb, lvgl.OBJ_FLAG_HIDDEN())
        end
    end
end

-- This function is for a custom analog clock widget.
-- It modifies the time passed in a table.
function widgets_init.clock_count(time)
    if not time or not time.sec or not time.min or not time.hour then
        print("Error: invalid time table passed to clock_count")
        return
    end

    time.sec = time.sec + 1
    if time.sec == 60 then
        time.sec = 0
        time.min = time.min + 1
    end

    if time.min == 60 then
        time.min = 0
        time.hour = (time.hour % 12) + 1
    end
end

return widgets_init
