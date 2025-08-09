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

-- This module depends on events_init.lua
local events = require("APP.main.events_init")

-- Helper function to scan for applications using the new C API
local function get_apps()
    local apps = {}
    -- Use the newly extended sdcard.list_files function
    local files, err = sdcard.list_files("/APP")
    if err or not files then
        print("Error reading /APP directory: " .. tostring(err))
        return apps
    end

    for _, file_info in ipairs(files) do
        -- We are interested in directories
        if file_info and file_info.type == "d" then
            local dir_name = file_info.name
            -- Ignore the main application itself
            if dir_name ~= "main" then
                -- Parse app name and version from folder name (e.g., explorer_1.0)
                local app_name, app_version = dir_name:match("^(.*)_(.*)$")
                if app_name and app_version then
                    table.insert(apps, {
                        name = app_name,
                        version = app_version,
                        path = dir_name
                    })
                else
                    -- Fallback for names without a version suffix
                    table.insert(apps, {
                        name = dir_name,
                        version = "N/A",
                        path = dir_name
                    })
                end
            end
        end
    end
    return apps
end

-- Helper function to create a widget for a single app
local function create_app_widget(parent, app_info)
    local app_container = lvgl.obj_create(parent)
    lvgl.obj_set_size(app_container, lvgl.pct(45), lvgl.pct(90))
    lvgl.obj_add_style(app_container, {
        bg_color = lvgl.color_hex(0xffffff),
        radius = 10,
        shadow_width = 5,
        shadow_opa = lvgl.OPA_20(),
        shadow_ofs_y = 3
    }, 0)
    lvgl.obj_set_flex_flow(app_container, lvgl.FLEX_FLOW_COLUMN())
    lvgl.obj_set_flex_align(app_container, lvgl.FLEX_ALIGN_SPACE_AROUND(), lvgl.FLEX_ALIGN_CENTER(), lvgl.FLEX_ALIGN_CENTER())

    local name_label = lvgl.label_create(app_container)
    lvgl.label_set_text(name_label, app_info.name:sub(1,1):upper()..app_info.name:sub(2)) -- Capitalize first letter
    lvgl.obj_set_style_text_font(name_label, lvgl.font_montserrat_16(), 0)

    local version_label = lvgl.label_create(app_container)
    lvgl.label_set_text(version_label, "v" .. app_info.version)
    lvgl.obj_set_style_text_color(version_label, lvgl.color_hex(0x888888), 0)

    local open_btn = lvgl.btn_create(app_container)
    local btn_label = lvgl.label_create(open_btn)
    lvgl.label_set_text(btn_label, "Open")
    lvgl.obj_add_event_cb(open_btn, function(e)
        local code = lvgl.event_get_code(e)
        if code == lvgl.EVENT_CLICKED() then
            print("Request to open app: " .. app_info.path)
            -- Attempt to load and run the app's main file
            local success, err = pcall(require, "APP." .. app_info.path .. ".main")
            if not success then
                print("Error opening app '" .. app_info.path .. "': " .. tostring(err))
            end
        end
    end, lvgl.EVENT_ALL(), nil)

    return app_container
end


-- Main screen setup function
function setup_scr_main(ui)
    -- Create the main screen object
    ui.main = lvgl.obj_create(nil)
    if not ui.main then
        print("Error: Failed to create main screen")
        return
    end
    lvgl.obj_set_size(ui.main, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.main, lvgl.SCROLLBAR_MODE_OFF())

    -- Style for main screen
    lvgl.obj_set_style_bg_opa(ui.main, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())

    -- Create the tabview using the newly bound function
    ui.main_tabview_1 = lvgl.tabview_create(ui.main, lvgl.DIR_TOP(), 50)
    if not ui.main_tabview_1 then
        print("Error: Failed to create main_tabview_1")
        return
    end
    lvgl.obj_set_pos(ui.main_tabview_1, 1, 0)
    lvgl.obj_set_size(ui.main_tabview_1, 480, 320)
    lvgl.obj_set_scrollbar_mode(ui.main_tabview_1, lvgl.SCROLLBAR_MODE_OFF())

    -- Style for main_tabview_1
    lvgl.obj_set_style_bg_opa(ui.main_tabview_1, 255, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_bg_color(ui.main_tabview_1, lvgl.color_hex(0xeaeff3), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_bg_grad_dir(ui.main_tabview_1, lvgl.GRAD_DIR_NONE(), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_text_color(ui.main_tabview_1, lvgl.color_hex(0x4d4d4d), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    -- TODO: Font lv_font_montserratMedium_12 not available. Using lv_font_montserrat_12.
    lvgl.obj_set_style_text_font(ui.main_tabview_1, lvgl.font_montserrat_12(), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_text_opa(ui.main_tabview_1, 255, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_text_letter_space(ui.main_tabview_1, 2, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_text_line_space(ui.main_tabview_1, 16, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_border_width(ui.main_tabview_1, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_radius(ui.main_tabview_1, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    lvgl.obj_set_style_shadow_width(ui.main_tabview_1, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())

    -- Add tabs using the newly bound function
    ui.main_tabview_1_tab_1 = lvgl.tabview_add_tab(ui.main_tabview_1, "Apps")
    if not ui.main_tabview_1_tab_1 then
        print("Error: Failed to create main_tabview_1_tab_1")
        return
    end

    ui.main_tabview_1_tab_2 = lvgl.tabview_add_tab(ui.main_tabview_1, "Settings")
    if not ui.main_tabview_1_tab_2 then
        print("Error: Failed to create main_tabview_1_tab_2")
        return
    end

    -- Create the container for the app pages
    ui.main_app_page = lvgl.obj_create(ui.main_tabview_1_tab_1)
    if not ui.main_app_page then
        print("Error: Failed to create main_app_page")
        return
    end
    lvgl.obj_set_size(ui.main_app_page, lvgl.pct(100), lvgl.pct(100))
    lvgl.obj_set_layout(ui.main_app_page, lvgl.LAYOUT_FLEX)
    lvgl.obj_set_flex_flow(ui.main_app_page, lvgl.FLEX_FLOW_ROW_WRAP)
    lvgl.obj_set_flex_align(ui.main_app_page, lvgl.FLEX_ALIGN_SPACE_EVENLY, lvgl.FLEX_ALIGN_CENTER, lvgl.FLEX_ALIGN_CENTER)
    lvgl.obj_set_style_pad_all(ui.main_app_page, 10, 0)
    lvgl.obj_set_style_pad_gap(ui.main_app_page, 10, 0)
    lvgl.obj_set_style_bg_opa(ui.main_app_page, 0, 0) -- Make it transparent
    lvgl.obj_center(ui.main_app_page)

    -- Dynamically load and display apps
    local apps = get_apps()
    if #apps == 0 then
        local no_apps_label = lvgl.label_create(ui.main_app_page)
        lvgl.label_set_text(no_apps_label, "No applications found.")
        lvgl.obj_center(no_apps_label)
    else
        for _, app_info in ipairs(apps) do
            create_app_widget(ui.main_app_page, app_info)
        end
    end
    -- The second tab was already created above.
    
    -- List for settings
    ui.main_list_1 = lvgl.list_create(ui.main_tabview_1_tab_2)
    if not ui.main_list_1 then
        print("Error: Failed to create main_list_1")
        return
    end
    -- NOTE: LV_SYMBOL_BLUETOOTH and LV_SYMBOL_SETTINGS are not standard LVGL symbols.
    -- Using LV_SYMBOL_WIFI as a placeholder.
    ui.main_list_1_item0 = lvgl.list_add_btn(ui.main_list_1, lvgl.SYMBOL_WIFI(), "WiFi")
    if not ui.main_list_1_item0 then print("Error: Failed to create main_list_1_item0") return end
    
    ui.main_list_1_item1 = lvgl.list_add_btn(ui.main_list_1, lvgl.SYMBOL_WIFI(), "Bluetooth")
    if not ui.main_list_1_item1 then print("Error: Failed to create main_list_1_item1") return end
    
    ui.main_list_1_item2 = lvgl.list_add_btn(ui.main_list_1, lvgl.SYMBOL_WIFI(), "Hotspot")
    if not ui.main_list_1_item2 then print("Error: Failed to create main_list_1_item2") return end
    lvgl.obj_set_pos(ui.main_list_1, 58, 27)
    lvgl.obj_set_size(ui.main_list_1, 319, 156)
    -- ... styles for list_1

    -- Refactoring style for list buttons
    local list_btn_style_items = {ui.main_list_1_item0, ui.main_list_1_item1, ui.main_list_1_item2}
    for _, item in ipairs(list_btn_style_items) do
        lvgl.obj_set_style_pad_top(item, 5, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_pad_left(item, 5, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_pad_right(item, 5, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_pad_bottom(item, 5, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_border_width(item, 0, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_text_color(item, lvgl.color_hex(0x0D3055), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        -- TODO: Font lv_font_montserratMedium_12 not available.
        lvgl.obj_set_style_text_font(item, lvgl.font_montserrat_12(), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_text_opa(item, 255, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_radius(item, 3, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_bg_opa(item, 255, lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_bg_color(item, lvgl.color_hex(0xffffff), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
        lvgl.obj_set_style_bg_grad_dir(item, lvgl.GRAD_DIR_NONE(), lvgl.PART_MAIN() + lvgl.STATE_DEFAULT())
    end

    -- lv_obj_update_layout is not typically needed as LVGL handles layout updates automatically.
    -- If needed, a binding could be added.

    -- Init events for screen
    events.events_init_main(ui)
end

return setup_scr_main
