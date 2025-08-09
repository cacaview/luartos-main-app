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

function setup_scr_Hotspot(ui)
    -- Create the main screen object
    ui.Hotspot = lvgl.obj_create(nil)
    if not ui.Hotspot then
        print("Error: Failed to create Hotspot screen")
        return
    end
    lvgl.obj_set_size(ui.Hotspot, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.Hotspot, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_bg_opa(ui.Hotspot, 0, lvgl.PART_MAIN())

    -- Create container
    ui.Hotspot_cont_1 = lvgl.obj_create(ui.Hotspot)
    if not ui.Hotspot_cont_1 then
        print("Error: Failed to create Hotspot_cont_1")
        return
    end
    lvgl.obj_set_pos(ui.Hotspot_cont_1, 0, 0)
    lvgl.obj_set_size(ui.Hotspot_cont_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.Hotspot_cont_1, lvgl.SCROLLBAR_MODE_OFF())
    -- Styles for container
    lvgl.obj_set_style_border_width(ui.Hotspot_cont_1, 2, lvgl.PART_MAIN())
    lvgl.obj_set_style_border_color(ui.Hotspot_cont_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_side(ui.Hotspot_cont_1, lvgl.BORDER_SIDE_FULL(), lvgl.PART_MAIN())
    lvgl.obj_set_style_bg_color(ui.Hotspot_cont_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())

    -- Spangroup "hotspot"
    ui.Hotspot_spangroup_1 = lvgl.spangroup_create(ui.Hotspot_cont_1)
    if not ui.Hotspot_spangroup_1 then
        print("Error: Failed to create Hotspot_spangroup_1")
        return
    end
    lvgl.spangroup_set_align(ui.Hotspot_spangroup_1, lvgl.TEXT_ALIGN_LEFT())
    lvgl.spangroup_set_mode(ui.Hotspot_spangroup_1, lvgl.SPAN_MODE_BREAK())
    ui.Hotspot_spangroup_1_span = lvgl.spangroup_new_span(ui.Hotspot_spangroup_1)
    lvgl.span_set_text(ui.Hotspot_spangroup_1_span, "hotspot")
    -- TODO: Direct span styling not supported
    lvgl.obj_set_pos(ui.Hotspot_spangroup_1, 149, 31)
    lvgl.obj_set_size(ui.Hotspot_spangroup_1, 200, 100)
    lvgl.spangroup_refr_mode(ui.Hotspot_spangroup_1)

    -- Button "back"
    ui.Hotspot_btn_1 = lvgl.btn_create(ui.Hotspot_cont_1)
    if not ui.Hotspot_btn_1 then
        print("Error: Failed to create Hotspot_btn_1")
        return
    end
    ui.Hotspot_btn_1_label = lvgl.label_create(ui.Hotspot_btn_1)
    if not ui.Hotspot_btn_1_label then
        print("Error: Failed to create Hotspot_btn_1_label")
        return
    end
    lvgl.label_set_text(ui.Hotspot_btn_1_label, "back")
    lvgl.obj_align(ui.Hotspot_btn_1_label, lvgl.ALIGN_CENTER(), 0, 0)
    lvgl.obj_set_pos(ui.Hotspot_btn_1, 17, 20)
    lvgl.obj_set_size(ui.Hotspot_btn_1, 65, 40)
    -- Styles for back button
    lvgl.obj_set_style_bg_color(ui.Hotspot_btn_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.Hotspot_btn_1, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.Hotspot_btn_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())
    -- TODO: Font lv_font_montserratMedium_16 not available
    lvgl.obj_set_style_text_font(ui.Hotspot_btn_1, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- Switch
    ui.Hotspot_sw_1 = lvgl.switch_create(ui.Hotspot_cont_1)
    if not ui.Hotspot_sw_1 then
        print("Error: Failed to create Hotspot_sw_1")
        return
    end
    lvgl.obj_set_pos(ui.Hotspot_sw_1, 386, 37)
    lvgl.obj_set_size(ui.Hotspot_sw_1, 44, 20)
    -- Styles for switch
    lvgl.obj_set_style_bg_color(ui.Hotspot_sw_1, lvgl.color_hex(0xe6e2e6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.Hotspot_sw_1, 10, lvgl.PART_MAIN())
    lvgl.obj_set_style_bg_color(ui.Hotspot_sw_1, lvgl.color_hex(0x2195f6), lvgl.PART_INDICATOR() + lvgl.STATE_CHECKED())
    lvgl.obj_set_style_bg_color(ui.Hotspot_sw_1, lvgl.color_hex(0xffffff), lvgl.PART_KNOB())
    lvgl.obj_set_style_radius(ui.Hotspot_sw_1, 10, lvgl.PART_KNOB())

    -- TODO: lv_obj_update_layout is not bound.
    -- lvgl.obj_update_layout(ui.Hotspot)

    -- Init events for screen
    events.events_init_Hotspot(ui)
end

return setup_scr_Hotspot
