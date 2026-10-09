-- Shyzu Roblox - Fluent UI, one information tab only
-- UI/info display refactor based on the uploaded script. No floating logo toggle.
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local TargetGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
local LOGO_ID = "rbxthumb://type=Asset&id=126234343701615&w=420&h=420"

-- Remove older copies of this UI so they don't stack.
for _, name in ipairs({"ShizuRoblox_Toggle", "ShizuRoblox_Stats", "ShizuRoblox_InfoOnly"}) do
    local old = TargetGui:FindFirstChild(name)
    if old then old:Destroy() end
end

local ok, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)
if not ok or not Fluent then warn("[Shyzu Roblox] Không tải được Fluent UI") return end

local Window = Fluent:CreateWindow({
    Title = "shyzu Roblox",
    SubTitle = "PLAYER INFO",
    TabWidth = 0,
    Size = UDim2.fromOffset(520, 430),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = nil
})

-- Keep exactly one tab.
local Info = Window:AddTab({Title = "Thông Tin", Icon = "info"})
Window:SelectTab(Info)

local function getValue(names)
    local folders = {LocalPlayer:FindFirstChild("leaderstats"), LocalPlayer}
    for _, folder in ipairs(folders) do
        if folder then
            for _, name in ipairs(names) do
                local obj = folder:FindFirstChild(name)
                if obj then
                    local value = obj:IsA("ValueBase") and obj.Value or obj:GetAttribute("Value")
                    if value ~= nil then return tostring(value) end
                end
            end
        end
    end
    return "Chưa đọc được từ client"
end

local function getItems()
    local result = {}
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    local character = LocalPlayer.Character
    local function scan(container, prefix)
        if not container then return end
        for _, obj in ipairs(container:GetChildren()) do
            if obj:IsA("Tool") then table.insert(result, prefix .. obj.Name) end
        end
    end
    scan(backpack, "🎒 ")
    scan(character, "✋ ")
    if #result == 0 then return "Không tìm thấy Tool đang mang / đang cầm" end
    return table.concat(result, "\n")
end

local playerSection = Info:AddSection("PLAYER INFO")
local playerLabel = Info:AddParagraph({Title = "Nhân vật", Content = "Đang tải..."})
local itemSection = Info:AddSection("FRUIT & PVP ITEMS")
local itemLabel = Info:AddParagraph({Title = "Backpack / đang cầm", Content = "Đang quét..."})
Info:AddParagraph({Title = "Lưu ý", Content = "Chỉ hiển thị dữ liệu mà client đang cung cấp. Fruit trong kho lưu trữ và tiến trình nhiệm vụ có thể không đọc được trực tiếp."})

local function refresh()
    playerLabel:SetDesc(
        "Tên: " .. LocalPlayer.Name .. " (@" .. LocalPlayer.DisplayName .. ")\n" ..
        "Level: " .. getValue({"Level", "level"}) .. "\n" ..
        "Beli: " .. getValue({"Beli", "Money", "Belly"}) .. "\n" ..
        "Fragments (F): " .. getValue({"Fragments", "fragment"}) .. "\n" ..
        "Race: " .. getValue({"Race", "race"}) .. "\n" ..
        "Race V3: cần dữ liệu nhiệm vụ riêng của game"
    )
    itemLabel:SetDesc(getItems())
end

Info:AddButton({Title = "Làm mới thông tin", Description = "Quét lại chỉ số và Tool đang có", Callback = refresh})
refresh()
task.spawn(function()
    while task.wait(3) do
        pcall(refresh)
    end
end)

-- Hide Fluent titlebar close/minimize controls if their common names/text are present.
task.defer(function()
    for _ = 1, 20 do
        task.wait(0.25)
        for _, root in ipairs({TargetGui, LocalPlayer:FindFirstChildOfClass("PlayerGui")}) do
            if root then
                for _, obj in ipairs(root:GetDescendants()) do
                    if obj:IsA("GuiButton") then
                        local n = string.lower(obj.Name or "")
                        local t = string.lower(obj:IsA("TextButton") and obj.Text or "")
                        if n:find("close") or n:find("minimize") or t == "x" or t == "×" or t == "-" or t == "−" then
                            obj.Visible = false
                        end
                    end
                end
            end
        end
    end
end)
