--// ULTRA FPS BOOST v2
--// Dark Texture + Remove Effects + Keep Animation
--// Anti Screen Shake + FPS Counter + Low Quality + Batch Loading

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local DARK_AMOUNT = 0.65

local REMOVE_TEXTURE = true        -- xoá Decal/Texture/SurfaceAppearance + TextureID của mesh
local REMOVE_EFFECTS = true        -- tắt Particle/Trail/Beam/Smoke/Fire/Sparkles/Highlight
local REMOVE_EXPLOSIONS = true     -- ẩn vụ nổ
local REMOVE_LIGHTS = true         -- tắt Point/Spot/Surface light
local REMOVE_POST_EFFECTS = true   -- tắt Bloom/Blur/SunRays/ColorCorrection/DepthOfField, Atmosphere, Clouds
local DISABLE_SHADOWS = true
local LOW_WATER_TERRAIN = true     -- nước phẳng, tắt cỏ Terrain
local LOWEST_QUALITY = true        -- QualityLevel thấp nhất
local MUTE_SOUNDS = false          -- tắt tiếng (đổi thành true nếu muốn)
local UNLOCK_FPS = true            -- mở khoá giới hạn FPS (cần executor hỗ trợ setfpscap)
local FPS_CAP = 999
local ANTI_SCREEN_SHAKE = true
local SHOW_FPS = true

local HIDE_FX_PARTS = true         -- tự ẩn part/mesh hiệu ứng mới spawn (skill, shockwave...)
local FX_KEEP_SECONDS = 4          -- part còn tồn tại quá số giây này sẽ được coi là đồ thật và hiện lại
local TOGGLE_KEY = Enum.KeyCode.RightControl -- phím bật/tắt chế độ ẩn hiệu ứng

local BATCH_SIZE = 400             -- xử lý bao nhiêu object rồi nghỉ 1 frame (tránh đứng hình lúc load)

--------------------------------------------------
-- DARK COLOR
--------------------------------------------------

local function darkColor(color)
    return Color3.new(
        color.R * DARK_AMOUNT,
        color.G * DARK_AMOUNT,
        color.B * DARK_AMOUNT
    )
end

--------------------------------------------------
-- CLEAN OBJECT
--------------------------------------------------

local function clean(obj)

    -- GIỮ ANIMATION
    if obj:IsA("Animator")
        or obj:IsA("Animation")
        or obj:IsA("AnimationController") then
        return
    end

    -- BLOCK / PART / MESH
    if obj:IsA("BasePart") then

        pcall(function()
            obj.Color = darkColor(obj.Color)
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end)

        if DISABLE_SHADOWS then
            pcall(function()
                obj.CastShadow = false
            end)
        end

        if obj:IsA("MeshPart") then
            pcall(function()
                obj.RenderFidelity = Enum.RenderFidelity.Performance
            end)

            if REMOVE_TEXTURE then
                pcall(function()
                    obj.TextureID = ""
                end)
            end
        end

        return
    end

    -- TEXTURE
    if REMOVE_TEXTURE then
        if obj:IsA("Decal")
            or obj:IsA("Texture")
            or obj:IsA("SurfaceAppearance") then

            pcall(function()
                obj:Destroy()
            end)
            return
        end

        if obj:IsA("SpecialMesh") then
            pcall(function()
                obj.TextureId = ""
            end)
            return
        end
    end

    -- EFFECT
    if REMOVE_EFFECTS then
        if obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Beam")
            or obj:IsA("Smoke")
            or obj:IsA("Fire")
            or obj:IsA("Sparkles")
            or obj:IsA("Highlight") then

            pcall(function()
                obj.Enabled = false
            end)
            return
        end
    end

    -- EXPLOSION
    if REMOVE_EXPLOSIONS and obj:IsA("Explosion") then
        pcall(function()
            obj.Visible = false
            obj.BlastPressure = 0
        end)
        return
    end

    -- LIGHT
    if REMOVE_LIGHTS then
        if obj:IsA("PointLight")
            or obj:IsA("SpotLight")
            or obj:IsA("SurfaceLight") then

            pcall(function()
                obj.Enabled = false
            end)
            return
        end
    end

    -- POST EFFECT / ATMOSPHERE / CLOUDS
    if REMOVE_POST_EFFECTS then
        if obj:IsA("PostEffect") then
            pcall(function()
                obj.Enabled = false
            end)
            return
        end

        if obj:IsA("Atmosphere") then
            pcall(function()
                obj.Density = 0
                obj.Haze = 0
                obj.Glare = 0
            end)
            return
        end

        if obj:IsA("Clouds") then
            pcall(function()
                obj.Enabled = false
            end)
            return
        end
    end

    -- SOUND
    if MUTE_SOUNDS and obj:IsA("Sound") then
        pcall(function()
            obj.Volume = 0
        end)
    end
end

--------------------------------------------------
-- CLEAN THEO LÔ (KHÔNG GIẬT KHI LOAD MAP LỚN)
--------------------------------------------------

local function cleanAll(root)
    local count = 0

    for _, obj in ipairs(root:GetDescendants()) do
        clean(obj)

        count += 1
        if count % BATCH_SIZE == 0 then
            task.wait()
        end
    end
end

task.spawn(function()
    cleanAll(workspace)
    cleanAll(Lighting)
end)

-- OBJECT SPAWN SAU NÀY
--------------------------------------------------
-- ẨN PART/MESH HIỆU ỨNG MỚI SPAWN (CHỈ ẨN PHÍA MÌNH, KHÔNG ẢNH HƯỞNG GAMEPLAY)
--------------------------------------------------

local fxEnabled = HIDE_FX_PARTS
local fxQueue = {}                                  -- { {part, hạn} }
local fxHidden = setmetatable({}, { __mode = "k" })

-- part thuộc nhân vật (người chơi / NPC / dummy) thì không ẩn
local function isCharacterPart(obj)
    local model = obj:FindFirstAncestorOfClass("Model")

    while model do
        if model:FindFirstChildOfClass("Humanoid") then
            return true
        end
        model = model:FindFirstAncestorOfClass("Model")
    end

    return false
end

local function showFx(part)
    if fxHidden[part] then
        fxHidden[part] = nil
        pcall(function()
            part.LocalTransparencyModifier = 0
        end)
    end
end

local function hideFx(obj)
    if not fxEnabled then return end
    if not obj:IsA("BasePart") or obj:IsA("Terrain") then return end
    if isCharacterPart(obj) then return end

    pcall(function()
        obj.LocalTransparencyModifier = 1
    end)

    fxHidden[obj] = true
    table.insert(fxQueue, { obj, os.clock() + FX_KEEP_SECONDS })
end

-- Dọn hàng đợi: part biến mất -> bỏ; sống quá lâu hoặc hoá ra là nhân vật -> hiện lại
task.spawn(function()
    while true do
        task.wait(0.25)

        local now = os.clock()
        local i = 1

        while i <= #fxQueue do
            local item = fxQueue[i]
            local part = item[1]

            local remove = false

            if not part.Parent then
                remove = true
            elseif now >= item[2] or isCharacterPart(part) then
                showFx(part)
                remove = true
            end

            if remove then
                fxQueue[i] = fxQueue[#fxQueue]
                fxQueue[#fxQueue] = nil
            else
                i += 1
            end
        end
    end
end)

-- Phím bật/tắt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.KeyCode ~= TOGGLE_KEY then
        return
    end

    fxEnabled = not fxEnabled

    if not fxEnabled then
        for _, item in ipairs(fxQueue) do
            showFx(item[1])
        end
        table.clear(fxQueue)
    end
end)

workspace.DescendantAdded:Connect(function(obj)
    task.defer(function()
        clean(obj)
        hideFx(obj)
    end)
end)

Lighting.DescendantAdded:Connect(function(obj)
    task.defer(clean, obj)
end)

--------------------------------------------------
-- LIGHTING
--------------------------------------------------

pcall(function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Lighting.FogEnd = 100000
    Lighting.ShadowSoftness = 0
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
end)

-- Compatibility = nhẹ nhất (cần executor hỗ trợ sethiddenproperty)
pcall(function()
    if sethiddenproperty then
        sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
    end
end)

--------------------------------------------------
-- TERRAIN / WATER
--------------------------------------------------

if LOW_WATER_TERRAIN then
    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            if sethiddenproperty then
                sethiddenproperty(terrain, "Decoration", false)
            end
        end
    end)
end

--------------------------------------------------
-- QUALITY / FPS CAP
--------------------------------------------------

if LOWEST_QUALITY then
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
end

if UNLOCK_FPS then
    pcall(function()
        if setfpscap then
            setfpscap(FPS_CAP)
        end
    end)
end

--------------------------------------------------
-- ANTI SCREEN SHAKE
--------------------------------------------------

if ANTI_SCREEN_SHAKE then

    pcall(function()
        RunService:UnbindFromRenderStep("AntiScreenShake")
    end)

    RunService:BindToRenderStep(
        "AntiScreenShake",
        Enum.RenderPriority.Camera.Value + 1,
        function()

            local Camera = workspace.CurrentCamera
            if not Camera then
                return
            end

            pcall(function()
                -- bỏ rung do CameraOffset
                local char = Player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.CameraOffset ~= Vector3.zero then
                    hum.CameraOffset = Vector3.zero
                end

                -- giữ vị trí + hướng nhìn, bỏ roll/nghiêng
                local cf = Camera.CFrame
                local pos = cf.Position
                local look = cf.LookVector

                if math.abs(look.Y) < 0.999 then
                    Camera.CFrame = CFrame.lookAt(pos, pos + look, Vector3.yAxis)
                end
            end)
        end
    )

end

--------------------------------------------------
-- FPS COUNTER
--------------------------------------------------

if SHOW_FPS then

    local playerGui = Player:WaitForChild("PlayerGui")

    local old = playerGui:FindFirstChild("UltraFPSCounter")
    if old then
        old:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "UltraFPSCounter"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = playerGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 260, 0, 28)
    label.Position = UDim2.new(0, 8, 0, 8)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.5
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = "FPS: --"
    label.Parent = gui

    local frames = 0
    local elapsed = 0

    RunService.RenderStepped:Connect(function(dt)

        frames += 1
        elapsed += dt

        if elapsed >= 0.5 then

            local fps = math.floor(frames / elapsed)
            label.Text = "FPS: " .. fps .. "  |  HIDE FX: " .. (fxEnabled and "ON" or "OFF")

            -- xanh = mượt, vàng = tạm, đỏ = lag
            if fps >= 50 then
                label.TextColor3 = Color3.fromRGB(80, 255, 120)
            elseif fps >= 30 then
                label.TextColor3 = Color3.fromRGB(255, 220, 80)
            else
                label.TextColor3 = Color3.fromRGB(255, 80, 80)
            end

            frames = 0
            elapsed = 0
        end

    end)

end

print("ULTRA FPS BOOST v2 LOADED")
