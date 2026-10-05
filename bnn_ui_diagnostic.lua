-- BNN UI diagnostic only.
local function report(tag, ok, err)
    if ok then warn("[BNN UI OK] "..tag)
    else warn("[BNN UI ERROR] "..tag..": "..tostring(err)) end
end

report("getgenv", type(getgenv) == "function")
report("loadstring", type(loadstring) == "function")
report("game", game ~= nil)

local ok, err = pcall(function()
    local lp = game:GetService("Players").LocalPlayer
    assert(lp, "LocalPlayer is nil")
end)
report("LocalPlayer", ok, err)

warn("[BNN UI] The supplied file contains LPH_ATTRIBUTES(VM(NONE)) references.")
warn("[BNN UI] This diagnostic intentionally does not define/bypass those symbols.")
