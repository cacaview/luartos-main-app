--
-- main.lua - Main entry point for the GUI Guider application
--
print("Starting GUI Guider Lua application...")

-- The custom C searcher now handles SD card paths.
-- No need to modify package.path here anymore.

-- Require the main gui_guider module
local gui_guider = require("APP.main.gui_guider")
if not gui_guider then
    print("FATAL: Could not load gui_guider.lua")
    return
end

-- Create the main UI table which will hold all widget references
local ui = {}

-- Setup the entire UI by calling the main setup function
-- This will create all screens and widgets as defined in the setup_scr_* files
print("Setting up UI...")
gui_guider.setup_ui(ui)
print("UI setup complete.")

-- The setup_ui function already loads the initial screen.
-- The application is now running and will be driven by LVGL's event loop.

print("GUI Guider Lua application started successfully.")

-- The system's main loop will now handle LVGL tasks.
-- No further code is needed here for basic operation.
