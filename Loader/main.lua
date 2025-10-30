--[[ 
  LexHost Pro Loader (Dengan Verifikasi)
  Modern UI, animasi halus, RGB border, logo pelangi
  Verifikasi dari:
    https://raw.githubusercontent.com/putraborz/VerifikasiScWata/refs/heads/main/Loader/vip.txt
    https://raw.githubusercontent.com/putraborz/VerifikasiScWata/refs/heads/main/Loader/7.txt
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local urlVip = "https://raw.githubusercontent.com/putraborz/VerifikasiScWata/refs/heads/main/Loader/vip.txt"
local urlSatuan = "https://raw.githubusercontent.com/putraborz/VerifikasiScWata/refs/heads/main/Loader/7.txt"

local successUrls = {
    "https://raw.githubusercontent.com/putraborz/WataXMountAtin/main/Loader/WataX.lua",
    "https://raw.githubusercontent.com/putraborz/WataXMount977Sakahayang/refs/heads/main/Loader/mainmap925.lua"
}

local TIKTOK_LINK = "https://www.tiktok.com/"
local DISCORD_LINK = "https://discord.gg/"

-- safe fetch
local function fetch(url)
    local ok, res = pcall(function()
        return game:HttpGet(url, true)
    end)
    return ok and res or nil
end

-- verifikasi username
local function isVerified(uname)
    local vip = fetch(urlVip)
    local sat = fetch(urlSatuan)
    if not vip or not sat then return false end
    uname = uname:lower()

    local function checkList(list)
        for line in list:gmatch("[^\r\n]+") do
            -- support comments after name with -- or trailing spaces
            local nameOnly = line:match("^(.-)%s*%-%-") or line
            nameOnly = nameOnly:match("^%s*(.-)%s*$")
            if nameOnly:lower() == uname then
                return true
            end
        end
        return false
    end

    return checkList(vip) or checkList(sat)
end

-- notifikasi (safe)
local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "LexHost",
            Text = text or "",
            Duration = duration or 4
        })
    end)
end

-- ===== GUI BUILD =====
local gui = Instance.new("ScreenGui")
gui.Name = "LexHostPro"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- master frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 380, 0, 220)
frame.Position = UDim2.new(0.5, -190, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 16)

-- main stroke (RGB)
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.LineJoinMode = Enum.LineJoinMode.Round
stroke.Transparency = 0.0

-- subtle glass overlay
local glass = Instance.new("Frame", frame)
glass.Size = UDim2.new(1, 0, 1, 0)
glass.Position = UDim2.new(0, 0, 0, 0)
glass.BackgroundTransparency = 0.85
glass.BorderSizePixel = 0
local glassCorner = Instance.new("UICorner", glass)
glassCorner.CornerRadius = UDim.new(0, 16)

-- TOP BAR (logo + close)
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 46)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundTransparency = 1

local logo = Instance.new("TextLabel", topBar)
logo.Text = "LEXHOST PRO"
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 18
logo.Size = UDim2.new(0, 220, 1, 0)
logo.Position = UDim2.new(0, 16, 0, 6)
logo.BackgroundTransparency = 1
logo.TextColor3 = Color3.fromRGB(255,255,255)
logo.TextXAlignment = Enum.TextXAlignment.Left

-- animated subtitle
local subtitle = Instance.new("TextLabel", topBar)
subtitle.Text = "Secure Loader"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.Size = UDim2.new(0, 160, 1, 0)
subtitle.Position = UDim2.new(0, 16, 0, 28)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(200,200,200)
subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- close button
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 32, 0, 28)
closeBtn.Position = UDim2.new(1, -44, 0, 9)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,8)

-- left area: avatar + name
local avatar = Instance.new("ImageLabel", frame)
avatar.Size = UDim2.new(0,84,0,84)
avatar.Position = UDim2.new(0, 16, 0, 66)
avatar.BackgroundTransparency = 1
avatar.ScaleType = Enum.ScaleType.Fit
local avCorner = Instance.new("UICorner", avatar)
avCorner.CornerRadius = UDim.new(0,12)

local uname = Instance.new("TextLabel", frame)
uname.Position = UDim2.new(0, 112, 0, 74)
uname.Size = UDim2.new(1, -128, 0, 28)
uname.BackgroundTransparency = 1
uname.Font = Enum.Font.GothamBold
uname.TextSize = 18
uname.TextColor3 = Color3.fromRGB(255,255,255)
uname.TextXAlignment = Enum.TextXAlignment.Left
uname.Text = player.Name

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0, 112, 0, 104)
status.Size = UDim2.new(1, -128, 0, 22)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(180,180,180)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = "Tekan Verifikasi untuk melanjutkan..."

-- right area: buttons
local btnRow = Instance.new("Frame", frame)
btnRow.Size = UDim2.new(0.46, 0, 0, 36)
btnRow.Position = UDim2.new(1, - (0.46 * frame.Size.X.Scale * 380) - 16, 0, 70) -- relative but we will reposition below
btnRow.Position = UDim2.new(0.52, -16, 0, 70)
btnRow.BackgroundTransparency = 1

-- helper: create button
local function makeButton(text, sizeX)
    local b = Instance.new("TextButton")
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.Size = UDim2.new(sizeX, 0, 1, 0)
    b.AutoButtonColor = false
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0,8)
    return b
end

local tiktokBtn = makeButton("TikTok", 0.32)
tiktokBtn.Parent = frame
tiktokBtn.Size = UDim2.new(0.22, 0, 0, 34)
tiktokBtn.Position = UDim2.new(0.52, 0, 0, 140)
tiktokBtn.BackgroundColor3 = Color3.fromRGB(255,70,130)

local verifyBtn = makeButton("Verifikasi", 0.56)
verifyBtn.Parent = frame
verifyBtn.Size = UDim2.new(0.46, 0, 0, 38)
verifyBtn.Position = UDim2.new(0.05, 0, 0, 160)
verifyBtn.BackgroundColor3 = Color3.fromRGB(60,180,100)

local discordBtn = makeButton("Discord", 0.18)
discordBtn.Parent = frame
discordBtn.Size = UDim2.new(0.22, 0, 0, 34)
discordBtn.Position = UDim2.new(0.8, 0, 0, 140)
discordBtn.BackgroundColor3 = Color3.fromRGB(88,101,242)

-- small loader ring (when verifying)
local loader = Instance.new("ImageLabel", frame)
loader.Size = UDim2.new(0,18,0,18)
loader.Position = UDim2.new(0, 92, 0, 110)
loader.BackgroundTransparency = 1
loader.Image = "rbxassetid://6031094672" -- small gear-ish (use fallback if not present)
loader.Visible = false
loader.ImageTransparency = 0.2

-- subtle drop shadow (frame duplicate)
local drop = Instance.new("ImageLabel", gui)
drop.Size = frame.Size + UDim2.new(0,12,0,12)
drop.Position = frame.Position + UDim2.new(0,6,0,6)
drop.AnchorPoint = frame.AnchorPoint
drop.BackgroundTransparency = 1
drop.Image = "rbxassetid://7035638282" -- soft shadow asset (optional, will fail silently)
drop.ImageTransparency = 0.8

-- UDF: animate stroke rainbow
task.spawn(function()
    local hue = 0
    while frame.Parent do
        hue = (hue + 1) % 360
        stroke.Color = Color3.fromHSV(hue/360, 0.95, 1)
        -- subtle logo tint
        logo.TextColor3 = Color3.fromHSV(((hue+120)%360)/360, 0.95, 1)
        task.wait(0.02)
    end
end)

-- pulse subtitle
task.spawn(function()
    local dir = 1
    local t = 0
    while subtitle.Parent do
        t = t + 0.02 * dir
        if t >= 1 then dir = -1 end
        if t <= 0 then dir = 1 end
        subtitle.TextTransparency = 0.2 + 0.5 * t
        task.wait(0.02)
    end
end)

-- avatar load
task.spawn(function()
    local ok, img = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420)
    end)
    if ok and img then avatar.Image = img end
end)

-- button hover/press animations
local function bindButtonAnimations(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = btn.Size + UDim2.new(0,6,0,6)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = btn.Size - UDim2.new(0,6,0,6)}):Play()
    end)
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.06), {Position = btn.Position + UDim2.new(0,0,0,2)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.06), {Position = btn.Position - UDim2.new(0,0,0,2)}):Play()
    end)
end

bindButtonAnimations(tiktokBtn)
bindButtonAnimations(verifyBtn)
bindButtonAnimations(discordBtn)
bindButtonAnimations(closeBtn)

-- copy to clipboard helper
local function copyToClipboard(link)
    if setclipboard then
        pcall(setclipboard, link)
        notify("LEXHOST", "Link disalin ke clipboard", 3)
        return true
    else
        notify("LEXHOST", "Fitur salin tidak tersedia di executor ini", 4)
        return false
    end
end

-- button actions
tiktokBtn.MouseButton1Click:Connect(function()
    if copyToClipboard(TIKTOK_LINK) then
        status.Text = "✅ Link TikTok disalin!"
    else
        status.Text = "⚠️ Salin gagal, cek console."
    end
    task.delay(2, function() if status and status.Parent then status.Text = "Tekan Verifikasi untuk melanjutkan..." end end)
end)

discordBtn.MouseButton1Click:Connect(function()
    if copyToClipboard(DISCORD_LINK) then
        status.Text = "✅ Link Discord disalin!"
    else
        status.Text = "⚠️ Salin gagal, cek console."
    end
    task.delay(2, function() if status and status.Parent then status.Text = "Tekan Verifikasi untuk melanjutkan..." end end)
end)

closeBtn.MouseButton1Click:Connect(function()
    -- smooth close
    local t = TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Position = frame.Position + UDim2.new(0,0,0,20)})
    t:Play()
    t.Completed:Wait()
    if gui and gui.Parent then gui:Destroy() end
end)

-- core verification + run logic
local function runSuccessUrls()
    for _, url in ipairs(successUrls) do
        local ok, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not ok then
            warn("Gagal load:", url, err)
        end
        task.wait(0.35)
    end
end

local function doVerify()
    if not (verifyBtn and status) then return end
    status.Text = "⏳ Memeriksa daftar..."
    verifyBtn.Active = false
    loader.Visible = true

    -- rotate loader visually
    local rot = 0
    local rotConn
    rotConn = RunService.Heartbeat:Connect(function(dt)
        rot = rot + dt * 360
        loader.Rotation = rot % 360
    end)

    local ok, result = pcall(function()
        return isVerified(player.Name)
    end)

    -- stop loader
    rotConn:Disconnect()
    loader.Visible = false
    verifyBtn.Active = true

    if not ok then
        status.Text = "⚠️ Error saat verifikasi."
        notify("LEXHOST", "Gagal memeriksa daftar (error).", 4)
        return
    end

    if result then
        status.Text = "✅ Terverifikasi — menjalankan script..."
        notify("LEXHOST", "Akun terverifikasi. Menjalankan script...", 3)
        -- small flourish
        TweenService:Create(logo, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {TextTransparency = 0.3}):Play()
        task.wait(0.5)
        runSuccessUrls()
        status.Text = "✅ Selesai. Terima kasih!"
        task.wait(0.8)
        if gui and gui.Parent then gui:Destroy() end
    else
        status.Text = "❌ Kamu tidak terdaftar."
        notify("LEXHOST", "Kamu belum terdaftar untuk menggunakan fitur ini.", 5)
    end
end

verifyBtn.MouseButton1Click:Connect(doVerify)

-- small entrance animation: scale + fade in
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, -0, 0.5, -0)
TweenService:Create(frame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 380, 0, 220),
    Position = UDim2.new(0.5, -190, 0.5, -110)
}):Play()

-- final: ensure on-screen safety (try-catch parent)
pcall(function() gui.Parent = player:FindFirstChild("PlayerGui") or game:GetService("CoreGui") end)
