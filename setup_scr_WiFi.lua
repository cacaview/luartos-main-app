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

function setup_scr_WiFi(ui)
    -- Create the main screen object
    ui.WiFi = lvgl.obj_create(nil)
    if not ui.WiFi then
        print("Error: Failed to create WiFi screen")
        return
    end
    lvgl.obj_set_size(ui.WiFi, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.WiFi, lvgl.SCROLLBAR_MODE_OFF())
    lvgl.obj_set_style_bg_opa(ui.WiFi, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())

    -- Create container
    ui.WiFi_cont_1 = lvgl.obj_create(ui.WiFi)
    if not ui.WiFi_cont_1 then
        print("Error: Failed to create WiFi_cont_1")
        return
    end
    lvgl.obj_set_pos(ui.WiFi_cont_1, 0, 0)
    lvgl.obj_set_size(ui.WiFi_cont_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.WiFi_cont_1, lvgl.SCROLLBAR_MODE_OFF())

    -- Style for container
    lvgl.obj_set_style_border_width(ui.WiFi_cont_1, 2, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_border_opa(ui.WiFi_cont_1, 255, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_border_color(ui.WiFi_cont_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_border_side(ui.WiFi_cont_1, lvgl.BORDER_SIDE_FULL(), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_radius(ui.WiFi_cont_1, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_bg_opa(ui.WiFi_cont_1, 255, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_bg_color(ui.WiFi_cont_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_pad_all(ui.WiFi_cont_1, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_shadow_width(ui.WiFi_cont_1, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())

    -- TODO: The entire lv_menu widget family is not bound in Lua.
    -- The following section cannot be translated without adding new bindings for:
    -- lv_menu_create, lv_menu_page_create, lv_menu_set_sidebar_page,
    -- lv_menu_cont_create, lv_menu_set_load_page_event, lv_menu_get_sidebar_header.
    print("FATAL: lv_menu widget is not supported in current bindings. WiFi screen will be mostly empty.")
    ui.WiFi_menu_1 = lvgl.obj_create(ui.WiFi_cont_1) -- Placeholder
    if not ui.WiFi_menu_1 then
        print("Error: Failed to create WiFi_menu_1 placeholder")
        return
    end
    lvgl.obj_set_pos(ui.WiFi_menu_1, 55, 85)
    lvgl.obj_set_size(ui.WiFi_menu_1, 368, 213)
    lvgl.obj_set_style_bg_color(ui.WiFi_menu_1, lvgl.color_hex(0xcccccc), lvgl.PART_MAIN()) -- Visual placeholder
    local menu_placeholder_label = lvgl.label_create(ui.WiFi_menu_1)
    if not menu_placeholder_label then
        print("Error: Failed to create menu_placeholder_label")
        return
    end
    lvgl.label_set_text(menu_placeholder_label, "Menu Widget Not Supported")
    lvgl.obj_center(menu_placeholder_label)


    -- Spangroup "WiFi"
    ui.WiFi_WiFi_text = lvgl.spangroup_create(ui.WiFi_cont_1)
    if not ui.WiFi_WiFi_text then
        print("Error: Failed to create WiFi_WiFi_text")
        return
    end
    lvgl.spangroup_set_align(ui.WiFi_WiFi_text, lvgl.TEXT_ALIGN_LEFT())
    lvgl.spangroup_set_overflow(ui.WiFi_WiFi_text, lvgl.SPAN_OVERFLOW_CLIP())
    lvgl.spangroup_set_mode(ui.WiFi_WiFi_text, lvgl.SPAN_MODE_BREAK())
    ui.WiFi_WiFi_text_span = lvgl.spangroup_new_span(ui.WiFi_WiFi_text)
    lvgl.span_set_text(ui.WiFi_WiFi_text_span, "WiFi")
    -- TODO: Direct span styling is not supported.
    lvgl.obj_set_pos(ui.WiFi_WiFi_text, 95, 27)
    lvgl.obj_set_size(ui.WiFi_WiFi_text, 201, 29)
    lvgl.spangroup_refr_mode(ui.WiFi_WiFi_text)

    -- Button "back"
    ui.WiFi_btn_1 = lvgl.btn_create(ui.WiFi_cont_1)
    if not ui.WiFi_btn_1 then
        print("Error: Failed to create WiFi_btn_1")
        return
    end
    ui.WiFi_btn_1_label = lvgl.label_create(ui.WiFi_btn_1)
    if not ui.WiFi_btn_1_label then
        print("Error: Failed to create WiFi_btn_1_label")
        return
    end
    lvgl.label_set_text(ui.WiFi_btn_1_label, "back")
    lvgl.obj_align(ui.WiFi_btn_1_label, lvgl.ALIGN_CENTER(), 0, 0)
    lvgl.obj_set_pos(ui.WiFi_btn_1, 17, 20)
    lvgl.obj_set_size(ui.WiFi_btn_1, 65, 40)
    -- Styles for back button
    lvgl.obj_set_style_bg_color(ui.WiFi_btn_1, lvgl.color_hex(0x2195f6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.WiFi_btn_1, 5, lvgl.PART_MAIN())
    lvgl.obj_set_style_text_color(ui.WiFi_btn_1, lvgl.color_hex(0xffffff), lvgl.PART_MAIN())
    -- TODO: Font lv_font_montserratMedium_16 not available.
    lvgl.obj_set_style_text_font(ui.WiFi_btn_1, lvgl.font_montserrat_16(), lvgl.PART_MAIN())

    -- Switch
    ui.WiFi_sw_1 = lvgl.switch_create(ui.WiFi_cont_1)
    if not ui.WiFi_sw_1 then
        print("Error: Failed to create WiFi_sw_1")
        return
    end
    lvgl.obj_set_pos(ui.WiFi_sw_1, 386, 37)
    lvgl.obj_set_size(ui.WiFi_sw_1, 44, 20)
    -- Styles for switch
    lvgl.obj_set_style_bg_color(ui.WiFi_sw_1, lvgl.color_hex(0xe6e2e6), lvgl.PART_MAIN())
    lvgl.obj_set_style_radius(ui.WiFi_sw_1, 10, lvgl.PART_MAIN())
    lvgl.obj_set_style_bg_color(ui.WiFi_sw_1, lvgl.color_hex(0x2195f6), lvgl.PART_INDICATOR() + lvgl.STATE_CHECKED())
    lvgl.obj_set_style_bg_color(ui.WiFi_sw_1, lvgl.color_hex(0xffffff), lvgl.PART_KNOB())
    lvgl.obj_set_style_radius(ui.WiFi_sw_1, 10, lvgl.PART_KNOB())

    -- TODO: lv_obj_update_layout is not bound.
    -- lvgl.obj_update_layout(ui.WiFi)

    -- Init events for screen
    events.events_init_WiFi(ui)
end

return setup_scr_WiFi
