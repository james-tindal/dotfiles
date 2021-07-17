use AppleScript version "2.4" -- Yosemite (10.10) or later


activate application "Mousecape"
tell application "System Events"
	
	set mousecape to process "Mousecape"
	set wndow to window 1 of mousecape
	set tracer_on to (get value of static text 1 of wndow) is not equal to "Applied Cape: None"
	set capes_menu to menu 1 of menu bar item "Capes" of menu bar 1 of mousecape
	set close_button to button 1 of wndow
	
	if tracer_on then
		perform action "AXPress" of menu item "Restore Defaults" of capes_menu
	else
		perform action "AXPress" of menu item "Apply Cape" of capes_menu
	end if
	click close_button
	return
end tell
--
--tell application "System Events"
--    tell application process "Mousecape"
--        set x to menu bars
--        return x
--    end tell
--end tell
