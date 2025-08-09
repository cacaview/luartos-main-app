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

function setup_scr_Bluetooth(ui)
    -- Create the main screen object
    ui.Bluetooth = lvgl.obj_create(nil)
    if not ui.Bluetooth then
        print("Error: Failed to create Bluetooth screen")
        return
    end
    lvgl.obj_set_size(ui.Bluetooth, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.Bluetooth, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_bg_opa(ui.Bluetooth, 0, lvgl.PART_MAIN())

    -- Create container
    ui.Bluetooth_cont_1 = lvgl.obj_create(ui.Bluetooth)
    if not ui.Bluetooth_cont_1 then
        print("Error: Failed to create Bluetooth_cont_1")
        return
    end
    lvgl.obj_set_pos(ui.Bluetooth_cont_1, 0, 0)
    lvgl.obj_set_size(ui.Bluetooth_cont_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.Bluetooth_cont_1, lvgl.SCROLLBAR_MODE_OFF())
    -- Styles for container
    lvgl.obj_set_style_border_width(ui.Bluetooth_cont_1, 2, lvgl.PART_MAIN())
    lvgl.obj_set_style_border_color(ui.Bluetooth_cont_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_border_side(ui.Bluetooth_cont_1, lvgl.BORDER_SIDE_FULL(), lvgl.PART_MAIN())
    lvgl.obj_set_style_bg_color(ui.Bluetooth_cont_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())

    -- Spangroup "bluetooth"
    ui.Bluetooth_spangroup_1 = lvgl.spangroup_create(ui.Bluetooth_cont_1)
    if not ui.Bluetooth_spangroup_1 then
        print("Error: Failed to create Bluetooth_spangroup_1")
        return
    end
    lvgl.spangroup_set_align(ui.Bluetooth_spangroup_1, lvgl.TEXT_ALIGN_LEFT())
    lvgl.spangroup_set_mode(ui.Bluetooth_spangroup_1, lvgl.SPAN_MODE_BREAK())
    ui.Bluetooth_spangroup_1_span = lvgl.spangroup_new_span(ui.Bluetooth_spangroup_1)
    lvgl.span_set_text(ui.Bluetooth_spangroup_1_span, "bluetooth")
    -- TODO: Direct span styling not supported
    lvgl.obj_set_pos(ui.Bluetooth_spangroup_1, 130, 30)
    lvgl.obj_set_size(ui.Bluetooth_spangroup_1, 200, 100)
    lvgl.spangroup_refr_mode(ui.Bluetooth_spangroup_1)

    -- Button "back"
    ui.Bluetooth_btn_1 = lvgl.btn_create(ui.Bluetooth_cont_1)
    if not ui.Bluetooth_btn_1 then
        print("Error: Failed to create Bluetooth_btn_1")
        return
    end
    ui.Bluetooth_btn_1_label = lvgl.label_create(ui.Bluetooth_btn_1)
    if not ui.Bluetooth_btn_1_label then
        print("Error: Failed to create Bluetooth_btn_1_label")
        return
    end
    lvgl.label_set_text(ui.Bluetooth_btn_1_label, "back")
    lvgl.obj_align(ui.Bluetooth_btn_1_label, lvgl.ALIGN_CENTER(), 0, 0)
    lvgl.obj_set_pos(ui.Bluetooth_btn_1, 17, 20)
    lvgl.obj_set_size(ui.Bluetooth_btn_1, 65, 40)
    -- Styles for back button
    lvgl.obj_set_style_bg_color(ui.Bluetooth_btn_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.Bluetooth_btn_1, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.Bluetooth_btn_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())
    -- TODO: Font lv_font_montserratMedium_16 not available
    lvgl.obj_set_style_text_font(ui.Bluetooth_btn_1, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- Switch
    ui.Bluetooth_sw_1 = lvgl.switch_create(ui.Bluetooth_cont_1)
    if not ui.Bluetooth_sw_1 then
        print("Error: Failed to create Bluetooth_sw_1")
        return
    end
    lvgl.obj_set_pos(ui.Bluetooth_sw_1, 386, 37)
    lvgl.obj_set_size(ui.Bluetooth_sw_1, 44, 20)
    -- Styles for switch
    lvgl.obj_set_style_bg_color(ui.Bluetooth_sw_1, lvgl.color_hex(0xe6e2e6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.Bluetooth_sw_1, 10, lvgl.PART_MAIN())
    lvgl.obj_set_style_bg_color(ui.Bluetooth_sw_1, lvgl.color_hex(0x2195f6), lvgl.PART_INDICATOR() + lvgl.STATE_CHECKED())
    lvgl.obj_set_style_bg_color(ui.Bluetooth_sw_1, lvgl.color_hex(0xffffff), lvgl.PART_KNOB())
    lvgl.obj_set_style_radius(ui.Bluetooth_sw_1, 10, lvgl.PART_KNOB())

    -- TODO: The entire lv_menu widget family is not bound in Lua.
    print("FATAL: lv_menu widget is not supported in current bindings. Bluetooth screen will be mostly empty.")
    ui.Bluetooth_menu_1 = lvgl.obj_create(ui.Bluetooth_cont_1) -- Placeholder
    if not ui.Bluetooth_menu_1 then
        print("Error: Failed to create Bluetooth_menu_1 placeholder")
        return
    end
    lvgl.obj_set_pos(ui.Bluetooth_menu_1, 55, 85)
    lvgl.obj_set_size(ui.Bluetooth_menu_1, 368, 213)
    lvgl.obj_set_style_bg_color(ui.Bluetooth_menu_1, lvgl.color_hex(0xcccccc), lvgl.PART_MAIN()) -- Visual placeholder
    local menu_placeholder_label = lvgl.label_create(ui.Bluetooth_menu_1)
    if not menu_placeholder_label then
        print("Error: Failed to create menu_placeholder_label")
        return
    end
    lvgl.label_set_text(menu_placeholder_label, "Menu Widget Not Supported")
    lvgl.obj_center(menu_placeholder_label)

    -- TODO: lv_obj_update_layout is not bound.
    -- lvgl.obj_update_layout(ui.Bluetooth)

    -- Init events for screen
    events.events_init_Bluetooth(ui)
end

return setup_scr_Bluetooth
