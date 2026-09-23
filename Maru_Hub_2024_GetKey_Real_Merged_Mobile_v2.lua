--========================================================
-- Maru Hub 2024 | GetKey + Main UI (Merged)
-- Key xác thực: real
-- Nhập "real" -> VERIFY -> Maru Hub 2024 mở
--========================================================

--========================================================
-- Nynox Hub | PREMIUM - FIXED CENTER + NO WELCOME BACK
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local CONFIG = {
    Name = "Nynox Hub", --- Muốn đổi Hub khác 
    Version = "Premium",
    Key = "real", --- Key xác thực: real
    GetKeyURL = "", --- Thêm Url Link Của bạn để Copy lấy key
    ScriptURL = "" --- Thêm Url raw loadstring của bạn  
}

local C = {
    Background = Color3.fromRGB(10, 11, 16),
    Sidebar = Color3.fromRGB(15, 16, 23),
    Card = Color3.fromRGB(20, 21, 29),
    Card2 = Color3.fromRGB(27, 28, 38),
    Primary = Color3.fromRGB(105, 88, 255),
    PrimaryHover = Color3.fromRGB(125, 110, 255),
    Text = Color3.fromRGB(245, 245, 250),
    SubText = Color3.fromRGB(145, 148, 160),
    Success = Color3.fromRGB(70, 220, 130),
    Error = Color3.fromRGB(245, 80, 95),
    White = Color3.fromRGB(255, 255, 255)
}

local function New(class, properties)
    local object = Instance.new(class)
    for property, value in pairs(properties or {}) do object[property] = value end
    return object
end

local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function AddStroke(parent, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(75, 78, 95)
    stroke.Thickness = 1
    stroke.Transparency = transparency or 0.5
    stroke.Parent = parent
    return stroke
end

local function Tween(object, properties, time)
    local info = TweenInfo.new(time or 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(object, info, properties):Play()
end

local Gui = New("ScreenGui", {
    Name = "NovaHubPremium",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})
Gui.Parent = PlayerGui

local Main = New("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 700, 0, 430),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 2
})
Main.Parent = Gui
AddCorner(Main, 16)
AddStroke(Main, 0.25)

local Scale = Instance.new("UIScale")
Scale.Name = "ResponsiveScale"
Scale.Parent = Main
local Camera = workspace.CurrentCamera
local function UpdateScale()
    Camera = workspace.CurrentCamera
    if not Camera then return end
    local viewport = Camera.ViewportSize
    local widthScale = viewport.X / 760
    local heightScale = viewport.Y / 500
    local value = math.min(widthScale, heightScale)
    value = math.clamp(value, 0.58, 1)
    Scale.Scale = value
end
UpdateScale()
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)

local Sidebar = New("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 175, 1, 0),
    BackgroundColor3 = C.Sidebar,
    BorderSizePixel = 0,
    ZIndex = 3
})
Sidebar.Parent = Main
AddCorner(Sidebar, 16)

local Logo = New("Frame", {
    Size = UDim2.new(0, 40, 0, 40),
    Position = UDim2.new(0, 16, 0, 18),
    BackgroundColor3 = C.Primary,
    BorderSizePixel = 0,
    ZIndex = 5
})
Logo.Parent = Sidebar
AddCorner(Logo, 11)

local LogoText = New("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "N",
    TextColor3 = C.White,
    TextSize = 21,
    Font = Enum.Font.GothamBold
})
LogoText.Parent = Logo

local HubName = New("TextLabel", {
    Size = UDim2.new(0, 105, 0, 22),
    Position = UDim2.new(0, 65, 0, 17),
    BackgroundTransparency = 1,
    Text = CONFIG.Name,
    TextColor3 = C.Text,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
HubName.Parent = Sidebar

local Premium = New("TextLabel", {
    Size = UDim2.new(0, 100, 0, 17),
    Position = UDim2.new(0, 65, 0, 38),
    BackgroundTransparency = 1,
    Text = "PREMIUM",
    TextColor3 = C.Primary,
    TextSize = 9,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
Premium.Parent = Sidebar

local Nav = New("Frame", {
    Size = UDim2.new(1, -20, 0, 165),
    Position = UDim2.new(0, 10, 0, 82),
    BackgroundTransparency = 1
})
Nav.Parent = Sidebar
local Pages = {}

local function CreateNav(name, title, y)
    local Button = New("TextButton", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 42),
        Position = UDim2.new(0, 0, 0, y),
        BackgroundColor3 = C.Card,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = " ".. title,
        TextColor3 = C.SubText,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    })
    Button.Parent = Nav
    AddCorner(Button, 9)
    local Indicator = New("Frame", {
        Size = UDim2.new(0, 3, 0, 22),
        Position = UDim2.new(0, 0, 0.5, -11),
        BackgroundColor3 = C.Primary,
        BorderSizePixel = 0,
        Visible = false
    })
    Indicator.Parent = Button
    AddCorner(Indicator, 3)
    Pages[name] = { Button = Button, Indicator = Indicator }
    return Button
end

local HomeButton = CreateNav("Home", "HOME", 0)
local MainButton = CreateNav("Main", "MAIN", 50)
local SettingsButton = CreateNav("Settings", "SETTINGS", 100)

local UserCard = New("Frame", {
    Size = UDim2.new(1, -20, 0, 57),
    Position = UDim2.new(0, 10, 1, -67),
    BackgroundColor3 = C.Card,
    BorderSizePixel = 0
})
UserCard.Parent = Sidebar
AddCorner(UserCard, 10)

local Avatar = New("ImageLabel", {
    Size = UDim2.new(0, 37, 0, 37),
    Position = UDim2.new(0, 9, 0.5, -18),
    BackgroundColor3 = C.Card2,
    BorderSizePixel = 0,
    Image = "rbxthumb://type=AvatarHeadShot&id=".. Player.UserId.. "&w=100&h=100"
})
Avatar.Parent = UserCard
AddCorner(Avatar, 9)

local UserName = New("TextLabel", {
    Size = UDim2.new(1, -55, 0, 20),
    Position = UDim2.new(0, 53, 0, 8),
    BackgroundTransparency = 1,
    Text = Player.DisplayName,
    TextColor3 = C.Text,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
UserName.Parent = UserCard

local Online = New("TextLabel", {
    Size = UDim2.new(1, -55, 0, 17),
    Position = UDim2.new(0, 53, 0, 29),
    BackgroundTransparency = 1,
    Text = "● Online",
    TextColor3 = C.Success,
    TextSize = 9,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left
})
Online.Parent = UserCard

local Content = New("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -190, 1, -20),
    Position = UDim2.new(0, 185, 0, 10),
    BackgroundTransparency = 1,
    ZIndex = 4
})
Content.Parent = Main

local Header = New("Frame", {
    Size = UDim2.new(1, -5, 0, 35), -- Thu gọn header lại vì không còn chữ to
    BackgroundTransparency = 1
})
Header.Parent = Content

-- ĐÃ SỬA: Chỉ để chữ Hub nhỏ gọn, không còn Welcome back
local PageTitle = New("TextLabel", {
    Size = UDim2.new(1, -50, 0, 20),
    Position = UDim2.new(0, 5, 0, 0),
    BackgroundTransparency = 1,
    Text = "Get Key Premium Pass", -- Chỉ 1 chữ Hub
    TextColor3 = C.Text,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
PageTitle.Parent = Header

local PageDescription = New("TextLabel", {
    Size = UDim2.new(1, -50, 0, 16),
    Position = UDim2.new(0, 5, 0, 18),
    BackgroundTransparency = 1,
    Text = "Premium key verification system",
    TextColor3 = C.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
})
PageDescription.Parent = Header

local Close = New("TextButton", {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -40, 0, 4),
    BackgroundColor3 = C.Card2,
    BorderSizePixel = 0,
    Text = "×",
    TextColor3 = C.SubText,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
})
Close.Parent = Main
AddCorner(Close, 8)
Close.MouseEnter:Connect(function() Tween(Close, { BackgroundColor3 = C.Error, TextColor3 = C.White }) end)
Close.MouseLeave:Connect(function() Tween(Close, { BackgroundColor3 = C.Card2, TextColor3 = C.SubText }) end)
Close.MouseButton1Click:Connect(function()
    Tween(Main, { BackgroundTransparency = 1 }, 0.2)
    task.wait(0.2)
    Gui:Destroy()
end)

local function CreatePage(name)
    local Page = New("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 1, -45), -- Đã chỉnh lại vì header nhỏ hơn
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundTransparency = 1,
        Visible = false
    })
    Page.Parent = Content
    return Page
end

local HomePage = CreatePage("HomePage")
local MainPage = CreatePage("MainPage")
local SettingsPage = CreatePage("SettingsPage")

local Welcome = New("Frame", {
    Size = UDim2.new(1, -10, 0, 105),
    Position = UDim2.new(0, 5, 0, 3),
    BackgroundColor3 = C.Card,
    BorderSizePixel = 0
})
Welcome.Parent = HomePage
AddCorner(Welcome, 13)
AddStroke(Welcome, 0.55)

local WelcomeTitle = New("TextLabel", {
    Size = UDim2.new(1, -25, 0, 27),
    Position = UDim2.new(0, 15, 0, 15),
    BackgroundTransparency = 1,
    Text = "Nynox Hub Premium",
    TextColor3 = C.Text,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
WelcomeTitle.Parent = Welcome

local WelcomeText = New("TextLabel", {
    Size = UDim2.new(1, -25, 0, 35),
    Position = UDim2.new(0, 15, 0, 45),
    BackgroundTransparency = 1,
    Text = "Your premium experience is ready.\nVerify your key to continue.",
    TextColor3 = C.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})
WelcomeText.Parent = Welcome

local function InfoCard(parent, x, title, value)
    local Card = New("Frame", {
        Size = UDim2.new(0.31, 0, 0, 82),
        Position = UDim2.new(x, 0, 0, 120),
        BackgroundColor3 = C.Card,
        BorderSizePixel = 0
    })
    Card.Parent = parent
    AddCorner(Card, 11)
    AddStroke(Card, 0.65)
    local Title = New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18),
        Position = UDim2.new(0, 10, 0, 11),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = C.SubText,
        TextSize = 9,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    Title.Parent = Card
    local Value = New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 27),
        Position = UDim2.new(0, 10, 0, 38),
        BackgroundTransparency = 1,
        Text = value,
        TextColor3 = C.Text,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    Value.Parent = Card
    return Card
end

InfoCard(HomePage, 0, "STATUS", "READY")
InfoCard(HomePage, 0.345, "VERSION", CONFIG.Version)
InfoCard(HomePage, 0.69, "USER", Player.Name)

local KeyPanel = New("Frame", {
    Size = UDim2.new(1, -10, 0, 142),
    Position = UDim2.new(0, 5, 0, 215),
    BackgroundColor3 = C.Card,
    BorderSizePixel = 0
})
KeyPanel.Parent = HomePage
AddCorner(KeyPanel, 13)
AddStroke(KeyPanel, 0.55)

local KeyTitle = New("TextLabel", {
    Size = UDim2.new(1, -25, 0, 23),
    Position = UDim2.new(0, 15, 0, 12),
    BackgroundTransparency = 1,
    Text = "Key Verification",
    TextColor3 = C.Text,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
KeyTitle.Parent = KeyPanel

local KeyBox = New("TextBox", {
    Size = UDim2.new(0.60, 0, 0, 37),
    Position = UDim2.new(0, 15, 0, 45),
    BackgroundColor3 = C.Card2,
    BorderSizePixel = 0,
    PlaceholderText = "Enter your key...",
    PlaceholderColor3 = C.SubText,
    Text = "",
    TextColor3 = C.Text,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    TextXAlignment = Enum.TextXAlignment.Left
})
KeyBox.Parent = KeyPanel
AddCorner(KeyBox, 8)
AddStroke(KeyBox, 0.7)

local Verify = New("TextButton", {
    Size = UDim2.new(0.34, 0, 0, 37),
    Position = UDim2.new(0.64, 0, 0, 45),
    BackgroundColor3 = C.Primary,
    BorderSizePixel = 0,
    Text = "VERIFY",
    TextColor3 = C.White,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
})
Verify.Parent = KeyPanel
AddCorner(Verify, 8)

local GetKey = New("TextButton", {
    Size = UDim2.new(0.60, 0, 0, 34),
    Position = UDim2.new(0, 15, 0, 92),
    BackgroundColor3 = C.Card2,
    BorderSizePixel = 0,
    Text = "COPY GET-KEY LINK",
    TextColor3 = C.Text,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
})
GetKey.Parent = KeyPanel
AddCorner(GetKey, 8)
AddStroke(GetKey, 0.7)

local KeyStatus = New("TextLabel", {
    Size = UDim2.new(0.34, 0, 0, 34),
    Position = UDim2.new(0.64, 0, 0, 92),
    BackgroundTransparency = 1,
    Text = "● Waiting",
    TextColor3 = C.SubText,
    TextSize = 9,
    Font = Enum.Font.GothamMedium
})
KeyStatus.Parent = KeyPanel

local MainTitle = New("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 0, 8),
    BackgroundTransparency = 1,
    Text = "Main Features",
    TextColor3 = C.Text,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
MainTitle.Parent = MainPage

local function CreateToggle(parent, text, y, callback)
    local Row = New("Frame", {
        Size = UDim2.new(1, -10, 0, 54),
        Position = UDim2.new(0, 5, 0, y),
        BackgroundColor3 = C.Card,
        BorderSizePixel = 0
    })
    Row.Parent = parent
    AddCorner(Row, 10)
    local Label = New("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.Text,
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    Label.Parent = Row
    local Toggle = New("TextButton", {
        Size = UDim2.new(0, 45, 0, 24),
        Position = UDim2.new(1, -59, 0.5, -12),
        BackgroundColor3 = Color3.fromRGB(45, 46, 55),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    })
    Toggle.Parent = Row
    AddCorner(Toggle, 20)
    local Circle = New("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 3, 0.5, -9),
        BackgroundColor3 = C.White,
        BorderSizePixel = 0
    })
    Circle.Parent = Toggle
    AddCorner(Circle, 20)
    local Enabled = false
    Toggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            Tween(Toggle, { BackgroundColor3 = C.Primary })
            Tween(Circle, { Position = UDim2.new(1, -21, 0.5, -9) })
        else
            Tween(Toggle, { BackgroundColor3 = Color3.fromRGB(45, 46, 55) })
            Tween(Circle, { Position = UDim2.new(0, 3, 0.5, -9) })
        end
        if callback then callback(Enabled) end
    end)
    return Row
end

CreateToggle(MainPage, "Premium Feature #1", 45)
CreateToggle(MainPage, "Premium Feature #2", 108)
CreateToggle(MainPage, "Premium Feature #3", 171)
CreateToggle(MainPage, "Premium Feature #4", 234)

local SettingsTitle = New("TextLabel", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 0, 8),
    BackgroundTransparency = 1,
    Text = "Settings",
    TextColor3 = C.Text,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
SettingsTitle.Parent = SettingsPage
CreateToggle(SettingsPage, "UI Animations", 45)
CreateToggle(SettingsPage, "Notifications", 108)
CreateToggle(SettingsPage, "Premium Effects", 171)

local Notification = New("Frame", {
    Size = UDim2.new(0, 270, 0, 57),
    Position = UDim2.new(1, 15, 0, 20),
    BackgroundColor3 = C.Card2,
    BorderSizePixel = 0,
    ZIndex = 50
})
Notification.Parent = Gui
AddCorner(Notification, 10)
AddStroke(Notification, 0.3)

local NotificationTitle = New("TextLabel", {
    Size = UDim2.new(1, -20, 0, 19),
    Position = UDim2.new(0, 12, 0, 7),
    BackgroundTransparency = 1,
    Text = "Nynox Hub",
    TextColor3 = C.Text,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
})
NotificationTitle.Parent = Notification

local NotificationText = New("TextLabel", {
    Size = UDim2.new(1, -20, 0, 20),
    Position = UDim2.new(0, 12, 0, 28),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = C.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd
})
NotificationText.Parent = Notification

local NotificationId = 0
local function Notify(text, success)
    NotificationId += 1
    local id = NotificationId
    NotificationText.Text = text
    NotificationTitle.TextColor3 = success and C.Success or C.Text
    Tween(Notification, { Position = UDim2.new(1, -285, 0, 20) }, 0.3)
    task.delay(2.5, function()
        if id ~= NotificationId then return end
        Tween(Notification, { Position = UDim2.new(1, 15, 0, 20) }, 0.3)
    end)
end

local function ShowPage(page, description, selectedName)
    HomePage.Visible = false
    MainPage.Visible = false
    SettingsPage.Visible = false
    page.Visible = true
    -- ĐÃ XÓA Welcome back, chỉ giữ Hub
    PageDescription.Text = description
    for name, data in pairs(Pages) do
        data.Indicator.Visible = false
        Tween(data.Button, { BackgroundTransparency = 1, TextColor3 = C.SubText }, 0.15)
    end
    local selected = Pages[selectedName]
    if selected then
        selected.Indicator.Visible = true
        Tween(selected.Button, { BackgroundColor3 = C.Card, BackgroundTransparency = 0, TextColor3 = C.Text }, 0.15)
    end
end

HomeButton.MouseButton1Click:Connect(function() ShowPage(HomePage, "Premium key verification system", "Home") end)
MainButton.MouseButton1Click:Connect(function() ShowPage(MainPage, "Premium features and controls", "Main") end)
SettingsButton.MouseButton1Click:Connect(function() ShowPage(SettingsPage, "Customize your experience", "Settings") end)

Verify.MouseEnter:Connect(function() Tween(Verify, { BackgroundColor3 = C.PrimaryHover }, 0.15) end)
Verify.MouseLeave:Connect(function() Tween(Verify, { BackgroundColor3 = C.Primary }, 0.15) end)
GetKey.MouseEnter:Connect(function() Tween(GetKey, { BackgroundColor3 = Color3.fromRGB(36, 37, 49) }, 0.15) end)
GetKey.MouseLeave:Connect(function() Tween(GetKey, { BackgroundColor3 = C.Card2 }, 0.15) end)

GetKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(CONFIG.GetKeyURL)
        KeyStatus.Text = "● Link copied"
        KeyStatus.TextColor3 = C.Success
        Notify("Get-key link copied!", true)
    else
        KeyStatus.Text = "● Copy unsupported"
        KeyStatus.TextColor3 = C.Error
        Notify("Clipboard is not supported.", false)
    end
end)

local function StartMaruHub()
    -- // Notification khi kích hoạt
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Maru Hub",
        Text = "Success!",
        Icon = "rbxassetid://9681970193",
        Duration = 10
    })

    -- // Services
    local CoreGui = game:GetService("CoreGui")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = Players.LocalPlayer

    -- Cleanup UI cũ
    for _, oldUI in ipairs(CoreGui:GetChildren()) do
    	if oldUI.Name == "OriginalMatchUI" then
    		oldUI:Destroy()
    	end
    end

    -- // ScreenGui
    local Screen = Instance.new("ScreenGui")
    Screen.Name = "OriginalMatchUI"
    Screen.ResetOnSpawn = false
    Screen.Parent = CoreGui

    -- // Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 610, 0, 458)

    -- Mobile scale: keeps the original Maru Hub layout while making it smaller on phones.
    local MobileScale = Instance.new("UIScale")
    MobileScale.Scale = 0.779
    MobileScale.Parent = Main
    Main.Position = UDim2.new(0.5, -305, 0.5, -229)
    Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = Screen

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    -- // NÚT BẬT/TẮT MENU (TOGGLE BUTTON)
    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 46, 0, 46)
    ToggleButton.Position = UDim2.new(0, 20, 0.2, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleButton.Image = "rbxassetid://9681970193"
    ToggleButton.Active = true
    ToggleButton.Parent = Screen

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    ToggleCorner.Parent = ToggleButton

    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Thickness = 1.5
    ToggleStroke.Color = Color3.fromRGB(50, 50, 50)
    ToggleStroke.Parent = ToggleButton

    -- Logíc Bật/Tắt Menu khi click nút
    ToggleButton.MouseButton1Click:Connect(function()
    	Main.Visible = not Main.Visible
    	TweenService:Create(ToggleButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 45, 0, 45)}):Play()
    	task.wait(0.1)
    	TweenService:Create(ToggleButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 46, 0, 46)}):Play()
    end)

    -- Logic Kéo Thả Cho Nút Bật/Tắt (Drag Toggle Button)
    local btnDragging, btnDragStart, btnStartPos
    ToggleButton.InputBegan:Connect(function(input)
    	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    		btnDragging = true
    		btnDragStart = input.Position
    		btnStartPos = ToggleButton.Position
    	end
    end)

    UserInputService.InputChanged:Connect(function(input)
    	if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    		local delta = input.Position - btnDragStart
    		ToggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    	end
    end)

    UserInputService.InputEnded:Connect(function(input)
    	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    		btnDragging = false
    	end
    end)

    -- // Header TopBar
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 44)
    Header.BackgroundTransparency = 1
    Header.ZIndex = 10
    Header.Parent = Main

    -- Logo Hub Header
    local Logo = Instance.new("ImageLabel")
    Logo.Size = UDim2.new(0, 28, 0, 28)
    Logo.Position = UDim2.new(0, 10, 0.5, -14)
    Logo.BackgroundTransparency = 1
    Logo.Image = "rbxassetid://9681970193"
    Logo.ZIndex = 12
    Logo.Parent = Header

    -- Dãy Tab
    local TabsHolder = Instance.new("ScrollingFrame")
    TabsHolder.Size = UDim2.new(1, -60, 0, 34)
    TabsHolder.Position = UDim2.new(0, 48, 0.5, -17)
    TabsHolder.BackgroundTransparency = 1
    TabsHolder.BorderSizePixel = 0
    TabsHolder.ScrollBarThickness = 0
    TabsHolder.ScrollingDirection = Enum.ScrollingDirection.X
    TabsHolder.Active = true
    TabsHolder.Parent = Header

    local TabsList = Instance.new("UIListLayout")
    TabsList.FillDirection = Enum.FillDirection.Horizontal
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 6)
    TabsList.Parent = TabsHolder

    TabsList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    	TabsHolder.CanvasSize = UDim2.new(0, TabsList.AbsoluteContentSize.X + 10, 0, 0)
    end)

    -- // Body Container
    local Body = Instance.new("Frame")
    Body.Size = UDim2.new(1, -20, 1, -52)
    Body.Position = UDim2.new(0, 10, 0, 44)
    Body.BackgroundTransparency = 1
    Body.Parent = Main

    local Tabs = {}
    local Pages = {}

    local function CreateColumn(parent, posX)
    	local Scroll = Instance.new("ScrollingFrame")
    	Scroll.Size = UDim2.new(0.49, 0, 1, 0)
    	Scroll.Position = UDim2.new(posX, 0, 0, 0)
    	Scroll.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    	Scroll.BorderSizePixel = 0
    	Scroll.ScrollBarThickness = 2
    	Scroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)
    	Scroll.Active = true
    	Scroll.Parent = parent

    	local Corner = Instance.new("UICorner")
    	Corner.CornerRadius = UDim.new(0, 8)
    	Corner.Parent = Scroll

    	local Layout = Instance.new("UIListLayout")
    	Layout.SortOrder = Enum.SortOrder.LayoutOrder
    	Layout.Padding = UDim.new(0, 7)
    	Layout.Parent = Scroll

    	local Padding = Instance.new("UIPadding")
    	Padding.PaddingTop = UDim.new(0, 10)
    	Padding.PaddingBottom = UDim.new(0, 10)
    	Padding.PaddingLeft = UDim.new(0, 10)
    	Padding.PaddingRight = UDim.new(0, 10)
    	Padding.Parent = Scroll

    	Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    		Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
    	end)

    	return Scroll
    end

    local function CreatePage(name)
    	local Page = Instance.new("Frame")
    	Page.Name = name .. "Page"
    	Page.Size = UDim2.new(1, 0, 1, 0)
    	Page.BackgroundTransparency = 1
    	Page.Visible = false
    	Page.Parent = Body

    	local LeftCol = CreateColumn(Page, 0)
    	local RightCol = CreateColumn(Page, 0.51)

    	Pages[name] = {
    		Frame = Page,
    		Left = LeftCol,
    		Right = RightCol
    	}

    	return Pages[name]
    end

    -- Khởi tạo các trang
    local GeneralPage = CreatePage("General")
    local FarmPage = CreatePage("Farm")
    local ItemsPage = CreatePage("Items")
    local CombatPage = CreatePage("Combat")
    local MiscPage = CreatePage("Miscellaneous")
    local WebhookPage = CreatePage("Webhook")

    -- // COMPONENTS

    -- Title Section
    local function CreateSectionTitle(parent, text, order)
    	local Container = Instance.new("Frame")
    	Container.Size = UDim2.new(1, 0, 0, 26)
    	Container.BackgroundTransparency = 1
    	Container.LayoutOrder = order
    	Container.Parent = parent

    	local Label = Instance.new("TextLabel")
    	Label.Size = UDim2.new(1, 0, 0, 18)
    	Label.Position = UDim2.new(0, 0, 0, 0)
    	Label.BackgroundTransparency = 1
    	Label.Text = text
    	Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    	Label.Font = Enum.Font.GothamMedium
    	Label.TextSize = 11.5
    	Label.Parent = Container

    	local Line = Instance.new("Frame")
    	Line.Size = UDim2.new(0.85, 0, 0, 1)
    	Line.Position = UDim2.new(0.075, 0, 1, -2)
    	Line.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
    	Line.BorderSizePixel = 0
    	Line.Parent = Container

    	local Gradient = Instance.new("UIGradient")
    	Gradient.Transparency = NumberSequence.new({
    		NumberSequenceKeypoint.new(0, 1),
    		NumberSequenceKeypoint.new(0.5, 0.2),
    		NumberSequenceKeypoint.new(1, 1)
    	})
    	Gradient.Parent = Line
    end

    -- Button
    local function CreateButton(parent, text, order, callback)
    	local Button = Instance.new("TextButton")
    	Button.Size = UDim2.new(1, 0, 0, 36)
    	Button.LayoutOrder = order
    	Button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    	Button.BorderSizePixel = 0
    	Button.Text = text
    	Button.TextColor3 = Color3.fromRGB(190, 190, 190)
    	Button.Font = Enum.Font.GothamMedium
    	Button.TextSize = 11.5
    	Button.AutoButtonColor = false
    	Button.Parent = parent

    	local Corner = Instance.new("UICorner")
    	Corner.CornerRadius = UDim.new(0, 6)
    	Corner.Parent = Button

    	Button.MouseButton1Click:Connect(function()
    		TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(85, 85, 85)}):Play()
    		task.wait(0.1)
    		TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
    		if callback then callback() end
    	end)
    end

    -- Toggle Switch
    local function CreateToggle(parent, text, defaultState, order, callback)
    	local enabled = defaultState or false

    	local Card = Instance.new("TextButton")
    	Card.Size = UDim2.new(1, 0, 0, 38)
    	Card.LayoutOrder = order
    	Card.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    	Card.Text = ""
    	Card.AutoButtonColor = false
    	Card.Parent = parent

    	local Corner = Instance.new("UICorner")
    	Corner.CornerRadius = UDim.new(0, 6)
    	Corner.Parent = Card

    	local Label = Instance.new("TextLabel")
    	Label.Size = UDim2.new(0.78, 0, 1, 0)
    	Label.Position = UDim2.new(0, 12, 0, 0)
    	Label.BackgroundTransparency = 1
    	Label.Text = text
    	Label.TextColor3 = Color3.fromRGB(160, 160, 160)
    	Label.Font = Enum.Font.Gotham
    	Label.TextSize = 11
    	Label.TextXAlignment = Enum.TextXAlignment.Left
    	Label.Parent = Card

    	local Circle = Instance.new("Frame")
    	Circle.Size = UDim2.new(0, 20, 0, 20)
    	Circle.Position = UDim2.new(1, -28, 0.5, -10)
    	Circle.BackgroundColor3 = enabled and Color3.fromRGB(0, 175, 240) or Color3.fromRGB(50, 50, 50)
    	Circle.BorderSizePixel = 0
    	Circle.Parent = Card

    	local CircleCorner = Instance.new("UICorner")
    	CircleCorner.CornerRadius = UDim.new(1, 0)
    	CircleCorner.Parent = Circle

    	local Icon = Instance.new("TextLabel")
    	Icon.Size = UDim2.new(1, 0, 1, 0)
    	Icon.BackgroundTransparency = 1
    	Icon.Text = "✓"
    	Icon.TextColor3 = Color3.fromRGB(15, 15, 15)
    	Icon.Font = Enum.Font.GothamBlack
    	Icon.TextSize = enabled and 13 or 0
    	Icon.TextTransparency = enabled and 0 or 1
    	Icon.Parent = Circle

    	Card.MouseButton1Click:Connect(function()
    		enabled = not enabled

    		TweenService:Create(Circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    			BackgroundColor3 = enabled and Color3.fromRGB(0, 175, 240) or Color3.fromRGB(50, 50, 50)
    		}):Play()

    		TweenService:Create(Icon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    			TextSize = enabled and 13 or 0,
    			TextTransparency = enabled and 0 or 1
    		}):Play()

    		if callback then callback(enabled) end
    	end)
    end

    -- Dropdown
    local function CreateDropdown(parent, labelText, options, defaultOpt, order, callback)
    	local selected = defaultOpt or options[1] or "None"
    	local isOpen = false

    	local Card = Instance.new("Frame")
    	Card.Size = UDim2.new(1, 0, 0, 42)
    	Card.LayoutOrder = order
    	Card.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    	Card.ClipsDescendants = true
    	Card.Parent = parent

    	local CardCorner = Instance.new("UICorner")
    	CardCorner.CornerRadius = UDim.new(0, 6)
    	CardCorner.Parent = Card

    	local TopContainer = Instance.new("Frame")
    	TopContainer.Size = UDim2.new(1, 0, 0, 42)
    	TopContainer.BackgroundTransparency = 1
    	TopContainer.Parent = Card

    	local Label = Instance.new("TextLabel")
    	Label.Size = UDim2.new(0.5, 0, 1, 0)
    	Label.Position = UDim2.new(0, 12, 0, 0)
    	Label.BackgroundTransparency = 1
    	Label.Text = labelText
    	Label.TextColor3 = Color3.fromRGB(160, 160, 160)
    	Label.Font = Enum.Font.Gotham
    	Label.TextSize = 11
    	Label.TextXAlignment = Enum.TextXAlignment.Left
    	Label.Parent = TopContainer

    	local DropBtn = Instance.new("TextButton")
    	DropBtn.Size = UDim2.new(0, 120, 0, 28)
    	DropBtn.Position = UDim2.new(1, -128, 0.5, -14)
    	DropBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    	DropBtn.Text = ""
    	DropBtn.AutoButtonColor = false
    	DropBtn.Parent = TopContainer

    	local BtnCorner = Instance.new("UICorner")
    	BtnCorner.CornerRadius = UDim.new(0, 6)
    	BtnCorner.Parent = DropBtn

    	local BtnStroke = Instance.new("UIStroke")
    	BtnStroke.Thickness = 1
    	BtnStroke.Color = Color3.fromRGB(50, 50, 50)
    	BtnStroke.Parent = DropBtn

    	local SelectedLabel = Instance.new("TextLabel")
    	SelectedLabel.Size = UDim2.new(1, -28, 1, 0)
    	SelectedLabel.Position = UDim2.new(0, 10, 0, 0)
    	SelectedLabel.BackgroundTransparency = 1
    	SelectedLabel.Text = selected
    	SelectedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    	SelectedLabel.Font = Enum.Font.Gotham
    	SelectedLabel.TextSize = 11
    	SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    	SelectedLabel.Parent = DropBtn

    	local ArrowIcon = Instance.new("ImageLabel")
    	ArrowIcon.Size = UDim2.new(0, 12, 0, 12)
    	ArrowIcon.Position = UDim2.new(1, -18, 0.5, -6)
    	ArrowIcon.BackgroundTransparency = 1
    	ArrowIcon.Image = "rbxassetid://6031094678"
    	ArrowIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    	ArrowIcon.Parent = DropBtn

    	local ListContainer = Instance.new("Frame")
    	ListContainer.Size = UDim2.new(1, -24, 0, #options * 26 + 4)
    	ListContainer.Position = UDim2.new(0, 12, 0, 42)
    	ListContainer.BackgroundTransparency = 1
    	ListContainer.Parent = Card

    	local ListLayout = Instance.new("UIListLayout")
    	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    	ListLayout.Padding = UDim.new(0, 4)
    	ListLayout.Parent = ListContainer

    	for _, optText in ipairs(options) do
    		local ItemBtn = Instance.new("TextButton")
    		ItemBtn.Size = UDim2.new(1, 0, 0, 24)
    		ItemBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    		ItemBtn.Text = optText
    		ItemBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
    		ItemBtn.Font = Enum.Font.Gotham
    		ItemBtn.TextSize = 10.5
    		ItemBtn.AutoButtonColor = false
    		ItemBtn.Parent = ListContainer

    		local ItemCorner = Instance.new("UICorner")
    		ItemCorner.CornerRadius = UDim.new(0, 4)
    		ItemCorner.Parent = ItemBtn

    		ItemBtn.MouseButton1Click:Connect(function()
    			selected = optText
    			SelectedLabel.Text = selected
    			isOpen = false

    			TweenService:Create(Card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    				Size = UDim2.new(1, 0, 0, 42)
    			}):Play()

    			TweenService:Create(ArrowIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()

    			if callback then callback(selected) end
    		end)
    	end

    	DropBtn.MouseButton1Click:Connect(function()
    		isOpen = not isOpen
    		local expandedHeight = 42 + (#options * 26 + 10)
    		local targetHeight = isOpen and expandedHeight or 42

    		TweenService:Create(Card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    			Size = UDim2.new(1, 0, 0, targetHeight)
    		}):Play()

    		TweenService:Create(ArrowIcon, TweenInfo.new(0.25), {Rotation = isOpen and 180 or 0}):Play()
    	end)
    end

    -- Slider
    local function CreateSlider(parent, text, minVal, maxVal, defaultVal, order, callback)
    	local value = defaultVal or minVal
    	local dragging = false

    	local Container = Instance.new("Frame")
    	Container.Size = UDim2.new(1, 0, 0, 42)
    	Container.LayoutOrder = order
    	Container.BackgroundTransparency = 1
    	Container.Parent = parent

    	local Label = Instance.new("TextLabel")
    	Label.Size = UDim2.new(0.6, 0, 0, 16)
    	Label.Position = UDim2.new(0, 0, 0, 0)
    	Label.BackgroundTransparency = 1
    	Label.Text = text
    	Label.TextColor3 = Color3.fromRGB(160, 160, 160)
    	Label.Font = Enum.Font.Gotham
    	Label.TextSize = 11
    	Label.TextXAlignment = Enum.TextXAlignment.Left
    	Label.Parent = Container

    	local ValBox = Instance.new("TextBox")
    	ValBox.Size = UDim2.new(0, 45, 0, 18)
    	ValBox.Position = UDim2.new(1, -45, 0, -2)
    	ValBox.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    	ValBox.Text = tostring(value)
    	ValBox.TextColor3 = Color3.fromRGB(180, 180, 180)
    	ValBox.Font = Enum.Font.Gotham
    	ValBox.TextSize = 11
    	ValBox.TextXAlignment = Enum.TextXAlignment.Center
    	ValBox.ClearTextOnFocus = false
    	ValBox.Parent = Container

    	local BoxCorner = Instance.new("UICorner")
    	BoxCorner.CornerRadius = UDim.new(0, 4)
    	BoxCorner.Parent = ValBox

    	local BoxStroke = Instance.new("UIStroke")
    	BoxStroke.Thickness = 1
    	BoxStroke.Color = Color3.fromRGB(50, 50, 50)
    	BoxStroke.Parent = ValBox

    	local SliderBack = Instance.new("Frame")
    	SliderBack.Size = UDim2.new(1, 0, 0, 5)
    	SliderBack.Position = UDim2.new(0, 0, 1, -8)
    	SliderBack.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    	SliderBack.BorderSizePixel = 0
    	SliderBack.Parent = Container

    	local BackCorner = Instance.new("UICorner")
    	BackCorner.CornerRadius = UDim.new(1, 0)
    	BackCorner.Parent = SliderBack

    	local initPercent = math.clamp((value - minVal) / (maxVal - minVal), 0, 1)
    	local SliderFill = Instance.new("Frame")
    	SliderFill.Size = UDim2.new(initPercent, 0, 1, 0)
    	SliderFill.BackgroundColor3 = Color3.fromRGB(0, 175, 240)
    	SliderFill.BorderSizePixel = 0
    	SliderFill.Parent = SliderBack

    	local FillCorner = Instance.new("UICorner")
    	FillCorner.CornerRadius = UDim.new(1, 0)
    	FillCorner.Parent = SliderFill

    	local Knob = Instance.new("Frame")
    	Knob.Size = UDim2.new(0, 8, 0, 14)
    	Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    	Knob.Position = UDim2.new(initPercent, 0, 0.5, 0)
    	Knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    	Knob.BorderSizePixel = 0
    	Knob.Parent = SliderBack

    	local KnobCorner = Instance.new("UICorner")
    	KnobCorner.CornerRadius = UDim.new(0, 3)
    	KnobCorner.Parent = Knob

    	local function UpdateVisual(val)
    		local percent = math.clamp((val - minVal) / (maxVal - minVal), 0, 1)
    		SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    		Knob.Position = UDim2.new(percent, 0, 0.5, 0)
    		ValBox.Text = tostring(val)
    	end

    	local function Update(input)
    		local posX = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
    		value = math.floor(minVal + (maxVal - minVal) * posX)
    		UpdateVisual(value)
    		if callback then callback(value) end
    	end

    	SliderBack.InputBegan:Connect(function(input)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			dragging = true
    			Update(input)
    		end
    	end)

    	UserInputService.InputChanged:Connect(function(input)
    		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    			Update(input)
    		end
    	end)

    	UserInputService.InputEnded:Connect(function(input)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			dragging = false
    		end
    	end)

    	ValBox.FocusLost:Connect(function(enterPressed)
    		local num = tonumber(ValBox.Text)
    		if num then
    			value = math.clamp(math.floor(num), minVal, maxVal)
    		else
    			value = math.clamp(defaultVal or minVal, minVal, maxVal)
    		end
    		UpdateVisual(value)
    		if callback then callback(value) end
    	end)
    end

    -- TextBox Component
    local function CreateTextBox(parent, labelText, placeholder, order, callback)
    	local Container = Instance.new("Frame")
    	Container.Size = UDim2.new(1, 0, 0, 58)
    	Container.LayoutOrder = order
    	Container.BackgroundTransparency = 1
    	Container.Parent = parent

    	local Label = Instance.new("TextLabel")
    	Label.Size = UDim2.new(1, 0, 0, 18)
    	Label.Position = UDim2.new(0, 0, 0, 0)
    	Label.BackgroundTransparency = 1
    	Label.Text = labelText
    	Label.TextColor3 = Color3.fromRGB(160, 160, 160)
    	Label.Font = Enum.Font.Gotham
    	Label.TextSize = 11
    	Label.TextXAlignment = Enum.TextXAlignment.Left
    	Label.Parent = Container

    	local BoxFrame = Instance.new("Frame")
    	BoxFrame.Size = UDim2.new(1, 0, 0, 34)
    	BoxFrame.Position = UDim2.new(0, 0, 0, 22)
    	BoxFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    	BoxFrame.Parent = Container

    	local BoxCorner = Instance.new("UICorner")
    	BoxCorner.CornerRadius = UDim.new(0, 6)
    	BoxCorner.Parent = BoxFrame

    	local Input = Instance.new("TextBox")
    	Input.Size = UDim2.new(1, -20, 1, 0)
    	Input.Position = UDim2.new(0, 10, 0, 0)
    	Input.BackgroundTransparency = 1
    	Input.Text = ""
    	Input.PlaceholderText = placeholder or ""
    	Input.PlaceholderColor3 = Color3.fromRGB(70, 70, 70)
    	Input.TextColor3 = Color3.fromRGB(190, 190, 190)
    	Input.Font = Enum.Font.Gotham
    	Input.TextSize = 11
    	Input.TextXAlignment = Enum.TextXAlignment.Left
    	Input.ClearTextOnFocus = false
    	Input.Parent = BoxFrame

    	Input.FocusLost:Connect(function(enterPressed)
    		if callback then callback(Input.Text) end
    	end)
    end

    -- // GẮN CHỨC NĂNG VÀO CÁC TABS

    -- 1. TAB GENERAL
    CreateSectionTitle(GeneralPage.Left, "🏡 Home Menu 🏡", 1)
    CreateToggle(GeneralPage.Left, "Auto Farm Level", false, 2)
    CreateToggle(GeneralPage.Left, "Enabled Dressrosa Quests", false, 3)
    CreateToggle(GeneralPage.Left, "Enabled Zou Quests", false, 4)

    CreateSectionTitle(GeneralPage.Left, "🎄 Xmas 🎄", 5)
    CreateToggle(GeneralPage.Left, "Auto Farm Candy", false, 6)
    CreateToggle(GeneralPage.Left, "Auto Collect Present", false, 7)
    CreateSectionTitle(GeneralPage.Left, "🍒Berries 🍒", 8)
    CreateToggle(GeneralPage.Left, "Auto Collect Berries", false, 9)
    CreateToggle(GeneralPage.Left, "Collect Berries Hop", false, 10)
    CreateSectionTitle(GeneralPage.Left, "🌋Prehistoric Island Spawn:🔴 🌋", 11)
    CreateToggle(GeneralPage.Left, "Auto Flind Prehistoric Island", false, 12)
    CreateToggle(GeneralPage.Left, "Auto Relic Events", false, 13)
    CreateToggle(GeneralPage.Left, "Auto Collect Dragon Eggs", false, 14)
    CreateToggle(GeneralPage.Left, "Auto Collect Dragon Bones", false, 15)
    CreateToggle(GeneralPage.Left, "Auto Prehistoric Fully", false, 16)
    CreateSectionTitle(GeneralPage.Left, "🐲Dojo 🐲", 17)
    CreateToggle(GeneralPage.Left, "Auto Dragon Hunter", false, 18)
    CreateToggle(GeneralPage.Left, "Auto Dojo Quests", false, 19)
    CreateSectionTitle(GeneralPage.Left, "🛡️Mix Function 🛡️", 20)
    CreateToggle(GeneralPage.Left, "Auto Farm pirate", false, 21)
    CreateToggle(GeneralPage.Left, "Auto Farm Factory", false, 22)
    CreateSectionTitle(GeneralPage.Right, "⚙️ Settings ⚙️", 1)
    CreateDropdown(GeneralPage.Right, "Select Combat / Weapon", {"Melee", "Sword", "Blox Fruit", "Gun"}, "Melee", 2)
    CreateSlider(GeneralPage.Right, "Tween Speed", 50, 350, 81, 3)
    CreateToggle(GeneralPage.Right, "Bring Mob [ Turn off if bug ]", true, 4)
    CreateToggle(GeneralPage.Right, "Enabled Bypass TP", false, 5)
    CreateToggle(GeneralPage.Right, "Disabled Damage Text", false, 6)

    CreateSectionTitle(GeneralPage.Right, "🎒 Race V4 🎒", 7)
    CreateButton(GeneralPage.Right, "Change Last Gears", 8, function()
    	local commF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    	if commF then
    		commF:InvokeServer("UpgradeRace", "Buy")
    	end
    end)

    -- 2. TAB WEBHOOK
    CreateTextBox(WebhookPage.Left, "Webhook Link", "", 1, function(text)
    	_G.WebhookUrl = text
    end)
    CreateToggle(WebhookPage.Left, "Tag everyone", false, 2, function(state)
    	_G.TagEveryone = state
    end)
    CreateToggle(WebhookPage.Left, "Name Mask", false, 3, function(state)
    	_G.NameMask = state
    end)

    CreateToggle(WebhookPage.Right, "Send When Stored Fruits", false, 1, function(state)
    	_G.SendStoredFruits = state
    end)
    CreateToggle(WebhookPage.Right, "Send When Find Leviathan", false, 2, function(state)
    	_G.SendLeviathan = state
    end)
    CreateToggle(WebhookPage.Right, "Send When Find Mystic Island", false, 3, function(state)
    	_G.SendMysticIsland = state
    end)
    CreateToggle(WebhookPage.Right, "Send When Find Prehistoric Island", false, 4, function(state)
    	_G.SendPrehistoricIsland = state
    end)

    -- // TẠO NÚT TAB TRÊN HEADER
    local function SwitchTab(tabName, button)
    	for name, pageData in pairs(Pages) do
    		pageData.Frame.Visible = (name == tabName)
    	end

    	for _, tabData in ipairs(Tabs) do
    		local isTarget = (tabData.Btn == button)
    		TweenService:Create(tabData.Btn, TweenInfo.new(0.15), {
    			BackgroundColor3 = isTarget and Color3.fromRGB(180, 180, 180) or Color3.fromRGB(40, 40, 40),
    			TextColor3 = isTarget and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(150, 150, 150)
    		}):Play()
    	end
    end

    local function MakeTab(text, active, order)
    	local Tab = Instance.new("TextButton")
    	Tab.Size = UDim2.new(0, 136, 1, 0)
    	Tab.LayoutOrder = order
    	Tab.BackgroundColor3 = active and Color3.fromRGB(180, 180, 180) or Color3.fromRGB(40, 40, 40)
    	Tab.Text = text
    	Tab.TextColor3 = active and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(150, 150, 150)
    	Tab.Font = Enum.Font.GothamMedium
    	Tab.TextSize = 13
    	Tab.AutoButtonColor = false
    	Tab.Parent = TabsHolder

    	local Corner = Instance.new("UICorner")
    	Corner.CornerRadius = UDim.new(0, 6)
    	Corner.Parent = Tab

    	table.insert(Tabs, {Btn = Tab})

    	if active then
    		Pages[text].Frame.Visible = true
    	end

    	Tab.MouseButton1Click:Connect(function()
    		SwitchTab(text, Tab)
    	end)
    end

    MakeTab("General", true, 1)
    MakeTab("Farm", false, 2)
    MakeTab("Items", false, 3)
    MakeTab("Combat", false, 4)
    MakeTab("Miscellaneous", false, 5)
    MakeTab("Webhook", false, 6)

    -- Không kéo menu bằng thanh tab/chức năng.
end

local Verified = false
local function VerifyKey()
    local Input = KeyBox.Text
    if Input == "" then
        KeyStatus.Text = "● Enter a key"
        KeyStatus.TextColor3 = C.Error
        Notify("Please enter your key.", false)
        return
    end
    if Input == CONFIG.Key then
        Verified = true
        KeyStatus.Text = "● Verified"
        KeyStatus.TextColor3 = C.Success
        Verify.Text = "VERIFIED"
        Tween(Verify, { BackgroundColor3 = C.Success }, 0.2)
        Notify("Key verified successfully!", true)
        task.wait(0.7)
        Gui:Destroy()
        StartMaruHub()
    else
        Verified = false
        KeyStatus.Text = "● Invalid key"
        KeyStatus.TextColor3 = C.Error
        KeyBox.Text = ""
        Notify("Invalid key.", false)
    end
end

Verify.MouseButton1Click:Connect(VerifyKey)
KeyBox.FocusLost:Connect(function(enterPressed) if enterPressed then VerifyKey() end end)

-- Thanh chức năng không còn kéo di chuyển toàn bộ UI.
local Resize = New("TextButton", {
    Name = "ResizeHandle",
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -30, 1, -30),
    BackgroundTransparency = 1,
    Text = "◢",
    TextColor3 = C.SubText,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    ZIndex = 15
})
Resize.Parent = Main
local Resizing = false
local ResizeStart
local ResizeStartSize
local MIN_WIDTH = 520
local MIN_HEIGHT = 330
local MAX_WIDTH = 900
local MAX_HEIGHT = 600
Resize.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Resizing = true
        ResizeStart = input.Position
        ResizeStartSize = Main.Size
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then Resizing = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if not Resizing then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local Delta = input.Position - ResizeStart
        local Width = ResizeStartSize.X.Offset + Delta.X
        local Height = ResizeStartSize.Y.Offset + Delta.Y
        Width = math.clamp(Width, MIN_WIDTH, MAX_WIDTH)
        Height = math.clamp(Height, MIN_HEIGHT, MAX_HEIGHT)
        Main.Size = UDim2.new(0, Width, 0, Height)
    end
end)
Resize.MouseEnter:Connect(function() Tween(Resize, { TextColor3 = C.Primary }, 0.15) end)
Resize.MouseLeave:Connect(function() Tween(Resize, { TextColor3 = C.SubText }, 0.15) end)

local OriginalSize = UDim2.new(0, 700, 0, 430)
Main.Size = UDim2.new(0, 0, 0, 0)
Tween(Main, { Size = OriginalSize }, 0.45)

ShowPage(HomePage, "Premium key verification system", "Home")
task.delay(0.5, function() Notify("Nynox Hub Premium loaded.", true) end)