hs.notify.new({title="Hammerspoon", informativeText="New config successfully loaded!"}):send()
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

duplicating = nil
hs.hotkey.bind({"cmd", "shift"}, "d", function()
    local win = hs.window.focusedWindow()
    local title = win:application():title()

    if title ~= "Xcode" then
        hs.notify.new({title="Hammerspoon", informativeText="Line duplicating not configured in " .. title .. "."}):send()
        return
    end

    if duplicating == nil then
        hs.eventtap.keyStroke({"shift", "cmd"}, "left", 100)
        hs.eventtap.keyStroke({"cmd"}, "c", 100)
        hs.eventtap.keyStroke({}, "right", 100)
    end
    hs.eventtap.keyStroke({}, "padenter", 100)
    hs.eventtap.keyStroke({"cmd"}, "v", 100)

    duplicating = (duplicating or 0) + 1
    local currentDupeCount = duplicating
    hs.timer.doAfter(7, function()
        if currentDupeCount == duplicating then
            duplicating = nil
        end
    end)
end)

hs.hotkey.bind({"alt", "cmd", "shift"}, "d", function()
    local win = hs.window.focusedWindow()
    local title = win:title()
    hs.notify.new({title="Hammerspoon", informativeText=title}):send()
    hs.eventtap.keyStroke({"shift", "cmd"}, "left", 100)
    hs.eventtap.keyStroke({"cmd"}, "c", 100)
    hs.eventtap.keyStroke({}, "right", 100)
    hs.eventtap.keyStroke({}, "padenter", 100)
    hs.eventtap.keyStroke({"cmd"}, "v", 100)
end)

----- Window distributor
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y
    if f.w == max.w and f.x == max.x then
      f.x = max.x + (max.w / 3)
      f.w = max.w / 3
    else
      f.x = max.x
      f.w = max.w
    end
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y
    if f.w == max.w / 2 and f.x == max.x then
      f.w = max.w / 3
    else
      f.w = max.w / 2
    end
    f.x = max.x
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()


    if f.w == max.w / 2 and f.x == max.x + (max.w / 2) then
      f.x = max.x + 2 * (max.w / 3)
      f.w = max.w / 3
    else
      f.x = max.x + (max.w / 2)
      f.w = max.w / 2
    end
    f.y = max.y
    f.h = max.h
    win:setFrame(f)
end)

-- lock mouse
locked = nil
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "L", function ()
    locked = true
end)


----- Emoji search
-- Build the list of emojis to be displayed.
local choices = {}
for _, emoji in ipairs(hs.json.decode(io.open("emojis/emojis.json"):read())) do
    table.insert(choices,
        {text=emoji['name'],
            subText=table.concat(emoji['kwds'], ", "),
            image=hs.image.imageFromPath("emojis/" .. emoji['id'] .. ".png"),
            chars=emoji['chars']
        })
end

-- Focus the last used window.
local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- Create the chooser.
-- On selection, copy the emoji and type it into the focused application.
local emojiChooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    hs.pasteboard.setContents(choice["chars"])
    focusLastFocused()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

emojiChooser:searchSubText(true)
emojiChooser:choices(choices)
emojiChooser:rows(5)
emojiChooser:bgDark(true)

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "E", function() emojiChooser:show() end)

hs.hotkey.bind({"shift", "ctrl", "cmd"}, "0", function()
    hs.notify.new({title="Reminder", informativeText="Fucks to give today: 0"}):send()
end)
