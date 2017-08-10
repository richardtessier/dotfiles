local alert = require "hs.alert"
local application = require "hs.application"
local eventtap = require "hs.eventtap.event"
local hotkey = require "hs.hotkey"
local wf=hs.window.filter

--[[local devKeys = {
    ["us"] = {
        {{{}, "ç"}, {{"alt"}, "0"}},
        {{{}, "^"}, {{"alt"}, "9"}}, 
        {{{}, "è"}, {{"alt"}, ","}}, 
        {{{}, "à"}, {{"alt"}, "."}}} 
        --{{{"shift"}, "ç"}, {{"alt"}, "ç"}}}
}

some_fn = function()
    hotkey.bind({}, "p", "", function() 
        eventtap.newKeyEvent({}, "a", true):post()
    end)
    --alert("Focus: " .. application.frontmostApplication():title())
    [>for i, v in ipairs(devKeys["us"]) do 
        --hotkey.bind({}, v[1][2], "", function() 
        hotkey.bind({}, "p", "", function() 
            --eventtap.newKeyEvent(v[2][1], v[2][2], true):post()
            eventtap.newKeyEvent({}, "a", true):post()
        end)
    end<]
end

some_fn2 = function()
    hotkey.disableAll({}, "p")
    --alert("Unfocus: " .. application.frontmostApplication():title())
    --for i, v in ipairs(devKeys["us"]) do 
        --hotkey.disableAll(v[1][1], v[1][2])
    --end
end
wf_terminal = wf.new{'MacVim','iTerm2'} -- all visible terminal windows
wf_terminal:subscribe(wf.windowFocused,some_fn):subscribe(wf.windowUnfocused,some_fn2) -- run a function whenever a terminal window is focused]]

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- HYPER+w: Bring up MOOM
wfun = function()
  hs.eventtap.keyStroke({'ctrl'}, 'ù')
  k.triggered = true
end
k:bind({}, 'w', nil, wfun)

-- HYPER+right: Bring up MOOM
rightfun = function()
  hs.eventtap.keyStroke({'ctrl'}, 'ù')
  hs.timer.doAfter(0.08, function(n)
      hs.eventtap.keyStroke({}, 'right')
  end)
  k.triggered = true
end
k:bind({}, 'right', nil, rightfun)

-- HYPER+left: Bring up MOOM
leftfun = function()
  hs.eventtap.keyStroke({'ctrl'}, 'ù')
  hs.timer.doAfter(0.08, function(n)
      hs.eventtap.keyStroke({}, 'left')
  end)
  k.triggered = true
end
k:bind({}, 'left', nil, leftfun)

-- HYPER+left: Bring up MOOM
onefun = function()
    --hs.alert.show("onefun")
    hs.application.launchOrFocus("Google Chrome")
    app = hs.application.frontmostApplication()
    app:selectMenuItem({"People", "work"})
    k.triggered = true
end
k:bind({}, '1', nil, onefun)

-- HYPER+left: Bring up MOOM
twofun = function()
    --hs.alert.show("onefun")
    hs.application.launchOrFocus("Google Chrome")
    app = hs.application.frontmostApplication()
    app:selectMenuItem({"People", "personal"})
    k.triggered = true
end
k:bind({}, '2', nil, twofun)

rightwindow = function()
    local app = application.frontmostApplication()
    local appname = app:title()
    if appname == "iTerm2" then
    end
    --alert(appname)

    --hs.application.launchOrFocus("Google Chrome")
    --app = hs.application.frontmostApplication()
    --app:selectMenuItem({"People", "personal"})
    --k.triggered = true
end
hotkey.bind({"ctrl"}, "right", rightwindow)
--
-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  if k.firstPress then
      k.secondPress = true
  else
      k.firstPress = true
      k.secondPress = false
  end
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
    k:exit()
    if not k.triggered and k.secondPress then
        hs.eventtap.keyStroke({'cmd'}, 'ù')
        k.firstPress = false
        k.secondPress = false
    elseif k.triggered then
        k.firstPress = false
        k.secondPress = false
    else
        hs.timer.doAfter(0.30, function(n) 
            k.firstPress = false
            k.secondPress = false
        end)
    end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

--[[
--hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
      --hs.alert.show("Hello World!")
--end)

---- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
--pressedF18 = function()
  --hs.alert.show("pressed f18!")
  --k.triggered = false
  --k:enter()
--end

---- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
----   send ESCAPE if no other keys are pressed.
--releasedF18 = function()
  --k:exit()
  --if not k.triggered then
    --hs.eventtap.keyStroke({cmd}, 'ù')
  --end
--end

---- Bind the Hyper key
--f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- HYPER+L: Open news.google.com in the default browser
lfun = function()
  news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
  hs.osascript.javascript(news)
  k.triggered = true
end
--k:bind('', 'l', nil, lfun)

-- HYPER+M: Call a pre-defined trigger in Alfred 3
mfun = function()
  cmd = "tell application \"Alfred 3\" to run trigger \"emoj\" in workflow \"com.sindresorhus.emoj\" with argument \"\""
  hs.osascript.applescript(cmd)
  k.triggered = true
end
--k:bind({}, 'm', nil, mfun)

-- HYPER+E: Act like ⌃e and move to end of line.
efun = function()
  hs.eventtap.keyStroke({'⌃'}, 'e')
  k.triggered = true
end
--k:bind({}, 'e', nil, efun)

-- HYPER+A: Act like ⌃a and move to beginning of line.
afun = function()
  hs.eventtap.keyStroke({'⌃'}, 'a')
  k.triggered = true
end
--k:bind({}, 'a', nil, afun)
--]]
