-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- URLs
local urlVip = "https://raw.githubusercontent.com/putraborz/VerifikasiScWata/refs/heads/main/Loader/vip.txt"
local urlSatuan = "https://raw.githubusercontent.com/putraborz/VerifikasiScWata/refs/heads/main/Loader/7.txt"
local successUrls = {
    "https://raw.githubusercontent.com/putraborz/WataXMountAtin/main/Loader/WataX.lua",
    "https://raw.githubusercontent.com/putraborz/WataXMount977Sakahayang/refs/heads/main/Loader/mainmap925.lua"
}
local TIKTOK_LINK = "https://www.tiktok.com/"
local DISCORD_LINK = "https://discord.gg/"

-- Utility functions
local function fetch(url)
    local ok, res = pcall(function() return game:HttpGet(url,true) end)
    return ok and res or nil
end

local function isVerified(uname)
    local vip = fetch(urlVip)
    local sat = fetch(urlSatuan)
    if not vip or not sat then return false end
    uname = uname:lower()
    local function checkList(list)
        for line in list:gmatch("[^\r\n]+") do
            local nameOnly = line:match("^(.-)%s*%-%-") or line
            nameOnly = nameOnly:match("^%s*(.-)%s*$")
            if nameOnly:lower() == uname then return true end
        end
        return false
    end
    return checkList(vip) or checkList(sat)
end

local function notify(title, text, duration)
    local ok = pcall(function()
        StarterGui:SetCore("SendNotification", {Title=title or "Info", Text=text or "", Duration=duration or 4})
    end)
    if not ok then print(("[%s] %s"):format(title or "Info", text or "")) end
end

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "WataXLoader"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 220)
frame.Position = UDim2.new(0.5, -180, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(255,255,255)
frame.BackgroundTransparency = 1 -- fade-in

TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=0}):Play()

-- Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Avatar
local avatar = Instance.new("ImageLabel", frame)
avatar.Size = UDim2.new(0, 70, 0, 70)
avatar.Position = UDim2.new(0, 20, 0, 45)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxassetid://112840507" -- default
avatar.ImageTransparency = 1

-- Ambil thumbnail dengan retry sampai berhasil
task.spawn(function()
    local success, img
    repeat
        success, img = pcall(function()
            return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100)
        end)
        if success and img and img ~= "" then
            avatar.Image = img
            TweenService:Create(avatar, TweenInfo.new(0.5), {ImageTransparency=0}):Play()
        else
            task.wait(0.5)
        end
    until success and img and img ~= ""
end)

-- Username
local unameLabel = Instance.new("TextLabel", frame)
unameLabel.Position = UDim2.new(0, 100, 0, 55)
unameLabel.Size = UDim2.new(1, -120, 0, 30)
unameLabel.BackgroundTransparency = 1
unameLabel.Font = Enum.Font.GothamBold
unameLabel.TextSize = 20
unameLabel.TextColor3 = Color3.fromRGB(255,255,255)
unameLabel.TextXAlignment = Enum.TextXAlignment.Left
unameLabel.Text = player.Name

-- Status
local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,20,0,135)
status.Size = UDim2.new(1,-40,0,24)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(255,255,255)
status.Text = "Klik tombol verifikasi untuk lanjut..."

-- Buttons
local btnRow = Instance.new("Frame", frame)
btnRow.Size = UDim2.new(0.86,0,0,36)
btnRow.Position = UDim2.new(0.07,0,1,-50)
btnRow.BackgroundTransparency = 1

-- TikTok Button
local tiktokBtn = Instance.new("TextButton", btnRow)
tiktokBtn.Size = UDim2.new(0.18,0,1,0)
tiktokBtn.Position = UDim2.new(0,0,0,0)
tiktokBtn.Text = "TikTok"
tiktokBtn.Font = Enum.Font.GothamBold
tiktokBtn.TextSize = 14
tiktokBtn.TextColor3 = Color3.fromRGB(255,255,255)
tiktokBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner", tiktokBtn).CornerRadius = UDim.new(0,8)

-- Discord Button
local discordBtn = Instance.new("TextButton", btnRow)
discordBtn.Size = UDim2.new(0.18,0,1,0)
discordBtn.Position = UDim2.new(0.82,0,0,0)
discordBtn.Text = "Discord"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 12
discordBtn.TextColor3 = Color3.fromRGB(255,255,255)
discordBtn.BackgroundColor3 = Color3.fromRGB(88,101,242)
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0,8)

-- Clipboard
local function copyToClipboard(link)
    if setclipboard then
        pcall(setclipboard, link)
        notify("Lex","Link disalin ke clipboard",3)
        return true
    else
        notify("Lex","Fitur salin tidak tersedia di executor ini",4)
        print("Link (copy manual):", link)
        return false
    end
end

tiktokBtn.MouseButton1Click:Connect(function()
    local ok = copyToClipboard(TIKTOK_LINK)
    status.Text = ok and "✅ Link TikTok disalin!" or "⚠️ Salin TikTok gagal"
    task.delay(2,function() if status and status.Parent then status.Text = "Klik tombol verifikasi untuk lanjut..." end end)
end)

discordBtn.MouseButton1Click:Connect(function()
    local ok = copyToClipboard(DISCORD_LINK)
    status.Text = ok and "✅ Link Discord disalin!" or "⚠️ Salin Discord gagal"
    task.delay(2,function() if status and status.Parent then status.Text = "Klik tombol verifikasi untuk lanjut..." end end)
end)

-- Verifikasi Script Button
local verifyBtn = Instance.new("TextButton", btnRow)
verifyBtn.Size = UDim2.new(0.56,0,1,0)
verifyBtn.Position = UDim2.new(0.22,0,0,0)
verifyBtn.Text = "Verifikasi Script"
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 16
verifyBtn.TextColor3 = Color3.fromRGB(255,255,255)
verifyBtn.BackgroundColor3 = Color3.fromRGB(60,180,100)
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0,8)

-- Glow RGB animasi
local glow = Instance.new("UIStroke", verifyBtn)
glow.Thickness = 2
task.spawn(function()
    while verifyBtn.Parent do
        for i=0,1,0.01 do
            glow.Color = Color3.fromHSV(i,1,1)
            task.wait(0.03)
        end
    end
end)

-- Getar saat klik
local function shakeButton(button)
    local originalPos = button.Position
    local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut,4,true)
    local tween = TweenService:Create(button, tweenInfo, {Position = originalPos + UDim2.new(0,5,0,0)})
    tween:Play()
end

-- Fungsi verifikasi
local function doVerify()
    status.Text = "Memeriksa..."
    verifyBtn.Active = false
    local ok,result = pcall(function() return isVerified(player.Name) end)
    verifyBtn.Active = true

    if not ok then
        status.Text = "⚠️ Error saat verifikasi."
        notify("WataX","Gagal memeriksa daftar (error).",4)
        return
    end

    if result then
        status.Text = "✅ KAMU TERDAFTAR SEBAGAI PENGGUNA"
        _G.WataX_Replay = true
        task.wait(0.8)
        for _,url in ipairs(successUrls) do
            local ok2, err = pcall(function() loadstring(game:HttpGet(url))() end)
            if not ok2 then warn("Gagal load:",url,err) end
        end
        task.wait(0.4)
        if gui and gui.Parent then gui:Destroy() end
    else
        status.Text = "❌ KAMU TIDAK TERDAFTAR SEBAGAI PENGGUNA"
        _G.WataX_Replay = false
        notify("WataX","❌ Kamu belum terdaftar untuk menggunakan fitur ini.",4)
    end
end

verifyBtn.MouseButton1Click:Connect(function()
    shakeButton(verifyBtn)
    doVerify()
end)
