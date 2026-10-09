-- shyzu Roblox - single-tab player tracker (Roblox Studio LocalScript)
-- UI/information tracker only. It does not teleport, auto-farm, or collect items.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local LOGO_ID = "rbxthumb://type=Asset&id=126234343701615&w=420&h=420"
local REFRESH_SECONDS = 1

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local gui = make("ScreenGui", {
    Name = "ShyzuRobloxTracker",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, player:WaitForChild("PlayerGui"))

local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0, 440, 0, 520),
    BackgroundColor3 = Color3.fromRGB(17, 18, 25),
    BorderSizePixel = 0,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 14)}, main)
make("UIStroke", {Color = Color3.fromRGB(76, 78, 103), Thickness = 1}, main)

local header = make("Frame", {
    Name = "Header", Size = UDim2.new(1, 0, 0, 76),
    BackgroundColor3 = Color3.fromRGB(25, 26, 37), BorderSizePixel = 0,
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 14)}, header)
make("Frame", {Position = UDim2.new(0, 0, 1, -14), Size = UDim2.new(1, 0, 0, 14), BackgroundColor3 = header.BackgroundColor3, BorderSizePixel = 0}, header)
make("ImageLabel", {
    Name = "Logo", BackgroundTransparency = 1,
    Position = UDim2.new(0, 14, 0, 12), Size = UDim2.new(0, 52, 0, 52),
    Image = LOGO_ID, ScaleType = Enum.ScaleType.Fit,
}, header)
make("TextLabel", {
    Name = "Title", BackgroundTransparency = 1,
    Position = UDim2.new(0, 76, 0, 14), Size = UDim2.new(1, -90, 0, 28),
    Font = Enum.Font.GothamBold, Text = "shyzu Roblox", TextSize = 21,
    TextColor3 = Color3.fromRGB(245, 245, 255), TextXAlignment = Enum.TextXAlignment.Left,
}, header)
make("TextLabel", {
    Name = "Subtitle", BackgroundTransparency = 1,
    Position = UDim2.new(0, 77, 0, 42), Size = UDim2.new(1, -90, 0, 18),
    Font = Enum.Font.Gotham, Text = "PLAYER INFO  •  INVENTORY  •  SEA PROGRESS", TextSize = 10,
    TextColor3 = Color3.fromRGB(155, 158, 180), TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local scroll = make("ScrollingFrame", {
    Name = "Content", Position = UDim2.new(0, 12, 0, 88), Size = UDim2.new(1, -24, 1, -100),
    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4,
    ScrollBarImageColor3 = Color3.fromRGB(115, 105, 190), CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, main)
make("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)

local function section(title, order)
    local frame = make("Frame", {
        Name = title:gsub("%W", "") .. "Section", Size = UDim2.new(1, -6, 0, 44),
        AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(26, 27, 39),
        BorderSizePixel = 0, LayoutOrder = order,
    }, scroll)
    make("UICorner", {CornerRadius = UDim.new(0, 10)}, frame)
    make("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}, frame)
    make("UIListLayout", {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, frame)
    make("TextLabel", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.GothamBold, Text = title, TextSize = 13,
        TextColor3 = Color3.fromRGB(185, 176, 255), TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
    }, frame)
    return frame
end

local function line(parent, name, order)
    return make("TextLabel", {
        Name = name, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 19),
        Font = Enum.Font.Gotham, Text = name .. ": —", TextSize = 12,
        TextColor3 = Color3.fromRGB(226, 227, 238), TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order,
    }, parent)
end

local stats = section("PLAYER INFO", 1)
local nameLine = line(stats, "Name", 2)
local levelLine = line(stats, "Level", 3)
local moneyLine = line(stats, "Beli", 4)
local fragmentsLine = line(stats, "Fragments (F)", 5)
local raceLine = line(stats, "Race / V3", 6)
local seaLine = line(stats, "Sea estimate", 7)

local items = section("ITEMS & FRUIT DETECTED", 2)
local itemsLine = line(items, "Backpack / equipped", 2)
local fruitLine = line(items, "Fruit held", 3)
local desiredLine = line(items, "Equipment status", 4)

local quests = section("SEA PROGRESSION CHECKLIST", 3)
local questLine = line(quests, "Next milestone", 2)
local questNote = line(quests, "Important note", 3)

local function findValue(names)
    local containers = {player:FindFirstChild("leaderstats"), player}
    for _, container in ipairs(containers) do
        if container then
            for _, name in ipairs(names) do
                local obj = container:FindFirstChild(name)
                if obj and (obj:IsA("StringValue") or obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("BoolValue")) then
                    return obj.Value
                end
            end
        end
    end
    return nil
end

local function display(value)
    if value == nil then return "not exposed by this game client" end
    return tostring(value)
end

local function getTools()
    local found = {}
    local function scan(container)
        if container then
            for _, child in ipairs(container:GetChildren()) do
                if child:IsA("Tool") then table.insert(found, child.Name) end
            end
        end
    end
    scan(player:FindFirstChildOfClass("Backpack"))
    scan(player.Character)
    table.sort(found)
    return found
end

local function containsAny(text, words)
    text = string.lower(text)
    for _, word in ipairs(words) do
        if string.find(text, string.lower(word), 1, true) then return true end
    end
    return false
end

local function update()
    local level = tonumber(findValue({"Level", "Lvl", "level"}))
    local money = findValue({"Beli", "Money", "Cash", "BeliAmount"})
    local fragments = findValue({"Fragments", "Fragment", "F"})
    local race = findValue({"Race", "race", "RaceName"})
    local tools = getTools()
    local toolText = #tools > 0 and table.concat(tools, ", ") or "No Tool found in Backpack/Character"
    local fruitTools = {}
    for _, item in ipairs(tools) do
        if containsAny(item, {"Fruit", "Rocket", "Spin", "Chop", "Spring", "Bomb", "Smoke", "Spike", "Flame", "Falcon", "Ice", "Sand", "Dark", "Diamond", "Light", "Rubber", "Barrier", "Ghost", "Magma", "Quake", "Buddha", "Love", "Spider", "Sound", "Phoenix", "Portal", "Rumble", "Pain", "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough", "Shadow", "Venom", "Control", "Spirit", "Dragon", "Leopard", "Kitsune", "Yeti"}) then
            table.insert(fruitTools, item)
        end
    end

    nameLine.Text = "Name: " .. player.Name .. "  (@" .. player.DisplayName .. ")"
    levelLine.Text = "Level: " .. display(level)
    moneyLine.Text = "Beli: " .. display(money)
    fragmentsLine.Text = "Fragments (F): " .. display(fragments)
    raceLine.Text = "Race / V3: " .. display(race) .. " (V3 needs game-specific quest data)"
    local sea = "unknown"
    if level then
        if level < 700 then sea = "First Sea (based on level)"
        elseif level < 1500 then sea = "Second Sea (based on level)"
        else sea = "Third Sea (based on level)" end
    end
    seaLine.Text = "Sea estimate: " .. sea
    itemsLine.Text = "Backpack / equipped: " .. toolText
    fruitLine.Text = "Fruit held: " .. (#fruitTools > 0 and table.concat(fruitTools, ", ") or "No fruit Tool detected")
    desiredLine.Text = "Equipment status: names detected from Backpack/Character only; stored inventory may not be exposed"

    if not level then
        questLine.Text = "Next milestone: level data unavailable; check the in-game quest panel"
        questNote.Text = "Checklist is guidance only; quest flags are not exposed to this UI"
    elseif level < 700 then
        questLine.Text = "Next milestone: reach Lv. 700, talk to Military Detective, get key, defeat Ice Admiral, then speak to Experienced Captain"
        questNote.Text = "Second Sea unlock needs the in-game quest sequence; level alone does not unlock it"
    elseif level < 850 then
        questLine.Text = "Next milestone: complete the Second Sea progression; Bartilo / Colosseum quest starts at its required level"
        questNote.Text = "Follow the active quest text and NPC requirements in-game"
    elseif level < 1500 then
        questLine.Text = "Next milestone: finish Colosseum Quest, defeat Don Swan, then continue King Red Head / rip_indra story"
        questNote.Text = "Third Sea requires Lv. 1500 and the required storyline steps"
    else
        questLine.Text = "Next milestone: check Third Sea questline and item-specific requirements in-game"
        questNote.Text = "Stored fruits and quest flags may not be visible to a LocalScript"
    end
end

update()
task.spawn(function()
    while gui.Parent do
        task.wait(REFRESH_SECONDS)
        update()
    end
end)
