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

local events = require("APP.main.events_init")
local widgets_init = require("APP.main.widgets_init")

function setup_scr_wifi_password(ui)
    -- Create the main screen object
    ui.wifi_password = lvgl.obj_create(nil)
    if not ui.wifi_password then
        print("Error: Failed to create wifi_password screen")
        return
    end
    lvgl.obj_set_size(ui.wifi_password, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.wifi_password, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_bg_opa(ui.wifi_password, 0, lvgl.PART_MAIN())

    -- Create container
    ui.wifi_password_cont_1 = lvgl.obj_create(ui.wifi_password)
    if not ui.wifi_password_cont_1 then
        print("Error: Failed to create wifi_password_cont_1")
        return
    end
    lvgl.obj_set_pos(ui.wifi_password_cont_1, 0, 0)
    lvgl.obj_set_size(ui.wifi_password_cont_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.wifi_password_cont_1, lvgl.SCROLLBAR_MODE_OFF())
    -- Styles for container
    lvgl.obj_set_style_border_width(ui.wifi_password_cont_1, 2, lvgl.PART_MAIN())
    lvgl.obj_set_style_border_color(ui.wifi_password_cont_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_side(ui.wifi_password_cont_1, lvgl.BORDER_SIDE_FULL(), lvgl.PART_MAIN())
    lvgl.obj_set_style_bg_color(ui.wifi_password_cont_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())

    -- Spangroup "password"
    ui.wifi_password_spangroup_1 = lvgl.spangroup_create(ui.wifi_password_cont_1)
    if not ui.wifi_password_spangroup_1 then
        print("Error: Failed to create wifi_password_spangroup_1")
        return
    end
    lvgl.spangroup_set_align(ui.wifi_password_spangroup_1, lvgl.TEXT_ALIGN_LEFT())
    lvgl.spangroup_set_mode(ui.wifi_password_spangroup_1, lvgl.SPAN_MODE_BREAK())
    ui.wifi_password_spangroup_1_span = lvgl.spangroup_new_span(ui.wifi_password_spangroup_1)
    lvgl.span_set_text(ui.wifi_password_spangroup_1_span, "password")
    -- TODO: Direct span styling not supported
    lvgl.obj_set_pos(ui.wifi_password_spangroup_1, 108, 29)
    lvgl.obj_set_size(ui.wifi_password_spangroup_1, 220, 47)
    lvgl.spangroup_refr_mode(ui.wifi_password_spangroup_1)

    -- Textarea for password
    ui.wifi_password_ta_1 = lvgl.textarea_create(ui.wifi_password_cont_1)
    if not ui.wifi_password_ta_1 then
        print("Error: Failed to create wifi_password_ta_1")
        return
    end
    lvgl.textarea_set_text(ui.wifi_password_ta_1, "")
    lvgl.textarea_set_placeholder_text(ui.wifi_password_ta_1, "password")
    lvgl.textarea_set_password_mode(ui.wifi_password_ta_1, true)
    lvgl.textarea_set_one_line(ui.wifi_password_ta_1, true)
    lvgl.textarea_set_max_length(ui.wifi_password_ta_1, 64)
    lvgl.obj_set_pos(ui.wifi_password_ta_1, 92, 116)
    lvgl.obj_set_size(ui.wifi_password_ta_1, 286, 31)
    -- Add event callback using the factory function
    if ui.g_kb_top_layer then
        local ta_cb = widgets_init.get_ta_event_cb(ui)
        lvgl.obj_add_event_cb(ui.wifi_password_ta_1, ta_cb)
    else
        print("Warning: ui.g_kb_top_layer not defined. Cannot add textarea event callback.")
    end
    -- Styles for textarea
    -- TODO: Font lv_font_montserratMedium_12 not available
    lvgl.obj_set_style_text_font(ui.wifi_password_ta_1, lvgl.font_montserrat_12(), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_color(ui.wifi_password_ta_1, lvgl.color_hex(0xe6e6e6), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_width(ui.wifi_password_ta_1, 2, lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.wifi_password_ta_1, 4, lvgl.PART_MAIN())

    -- Button "back"
    ui.wifi_password_btn_2 = lvgl.btn_create(ui.wifi_password_cont_1)
    if not ui.wifi_password_btn_2 then
        print("Error: Failed to create wifi_password_btn_2")
        return
    end
    ui.wifi_password_btn_2_label = lvgl.label_create(ui.wifi_password_btn_2)
    if not ui.wifi_password_btn_2_label then
        print("Error: Failed to create wifi_password_btn_2_label")
        return
    end
    lvgl.label_set_text(ui.wifi_password_btn_2_label, "back")
    lvgl.obj_align(ui.wifi_password_btn_2_label, lvgl.ALIGN_CENTER(), 0, 0)
    lvgl.obj_set_pos(ui.wifi_password_btn_2, 17, 20)
    lvgl.obj_set_size(ui.wifi_password_btn_2, 65, 40)
    -- Styles for back button
    lvgl.obj_set_style_bg_color(ui.wifi_password_btn_2, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.wifi_password_btn_2, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.wifi_password_btn_2, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())
    -- TODO: Font lv_font_montserratMedium_16 not available
    lvgl.obj_set_style_text_font(ui.wifi_password_btn_2, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- Button "OK"
    ui.wifi_password_btn_1 = lvgl.btn_create(ui.wifi_password)
    if not ui.wifi_password_btn_1 then
        print("Error: Failed to create wifi_password_btn_1")
        return
    end
    ui.wifi_password_btn_1_label = lvgl.label_create(ui.wifi_password_btn_1)
    if not ui.wifi_password_btn_1_label then
        print("Error: Failed to create wifi_password_btn_1_label")
        return
    end
    lvgl.label_set_text(ui.wifi_password_btn_1_label, "OK")
    lvgl.obj_align(ui.wifi_password_btn_1_label, lvgl.ALIGN_CENTER(), 0, 0)
    lvgl.obj_set_pos(ui.wifi_password_btn_1, 182, 199)
    lvgl.obj_set_size(ui.wifi_password_btn_1, 100, 50)
    -- Styles for OK button
    lvgl.obj_set_style_bg_color(ui.wifi_password_btn_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.wifi_password_btn_1, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.wifi_password_btn_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())
    -- TODO: Font lv_font_montserratMedium_16 not available
    lvgl.obj_set_style_text_font(ui.wifi_password_btn_1, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- TODO: lv_obj_update_layout is not bound.
    -- lvgl.obj_update_layout(ui.wifi_password)

    -- Init events for screen
    events.events_init_wifi_password(ui)
end

return setup_scr_wifi_password
