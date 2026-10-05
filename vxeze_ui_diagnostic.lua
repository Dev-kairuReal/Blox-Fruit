-- Vxeze UI diagnostic only.
local function report(tag, ok, err)
    if ok then warn("[VXEZE UI OK] "..tag)
    else warn("[VXEZE UI ERROR] "..tag..": "..tostring(err)) end
end

report("getgenv", type(getgenv) == "function")
report("loadstring", type(loadstring) == "function")
report("game", game ~= nil)

local ok, err = pcall(function()
    assert(game:GetService("HttpService"), "HttpService unavailable")
end)
report("HttpService", ok, err)

warn("[VXEZE UI] The supplied script loads its interface through VxezeUI.SourceUrl/SourceMirror.")
warn("[VXEZE UI] Expected objects after loading: VxezeUI.Library and VxezeUI.Window.")
warn("[VXEZE UI] This diagnostic does not fetch or execute the remote interface.")
