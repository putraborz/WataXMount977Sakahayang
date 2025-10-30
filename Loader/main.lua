--[[ 
    LEXHOST Loader (No Verification Version)
    Dibuat oleh Putra / Lex Digital Host
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- URL script utama
local successUrls = {
    "https://raw.githubusercontent.com/putraborz/WataXMountAtin/main/Loader/WataX.lua",
    "https://raw.githubusercontent.com/putraborz/WataXMount977Sakahayang/refs/heads/main/Loader/mainmap925.lua"
}

-- Fungsi notifikasi
local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "LEXHOST",
            Text = text or "",
            Duration = duration or 3
        })
    end)
end

-- GUI utama
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "LexHostLoader"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 200)
frame.Position = UDim2.new(0.5, -170, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(255, 255, 255)

-- Animasi muncul frame
frame.BackgroundTransparency = 1
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0
}):Play()

-- Label LEXHOST
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "LEXHOST"
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Efek RGB teks
task.spawn(function()
    while title and title.Parent do
        for hue = 0, 255, 4 do
            title.TextColor3 = Color3.fromHSV(hue / 255, 1, 1)
            task.wait(0.03)
        end
    end
end)

-- Avatar pemain
local avatar = Instance.new("ImageLabel", frame)
avatar.Size = UDim2.new(0, 64, 0, 64)
avatar.Position = UDim2.new(0, 20, 0, 60)
avatar.BackgroundTransparency = 1
task.spawn(function()
    local ok, img = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100)
    end)
    if ok and img then
        avatar.Image = img
    else
        avatar.Image = "rbxassetid://112840507"
    end
end)

-- Nama pemain
local uname = Instance.new("TextLabel", frame)
uname.Position = UDim2.new(0, 100, 0, 70)
uname.Size = UDim2.new(1, -110, 0, 30)
uname.BackgroundTransparency = 1
uname.Font = Enum.Font.GothamBold
uname.TextSize = 20
uname.TextColor3 = Color3.fromRGB(255, 255, 255)
uname.TextXAlignment = Enum.TextXAlignment.Left
uname.Text = player.Name

-- Status teks
local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0, 20, 0, 135)
status.Size = UDim2.new(1, -40, 0, 24)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = "Klik tombol di bawah untuk memulai..."

-- Tombol start
local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(0.6, 0, 0, 36)
startBtn.Position = UDim2.new(0.2, 0, 1, -50)
startBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
startBtn.Text = "Mulai Script"
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 18
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

-- Tombol close
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Jalankan script utama
local function runScripts()
    status.Text = "🔄 Memuat script..."
    startBtn.Active = false
    for _, url in ipairs(successUrls) do
        local ok, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not ok then
            warn("Gagal memuat:", url, err)
        end
        task.wait(0.4)
    end
    notify("LEXHOST", "✅ Script berhasil dijalankan", 4)
    status.Text = "✅ Script selesai dijalankan!"
    task.wait(1)
    gui:Destroy()
end

startBtn.MouseButton1Click:Connect(runScripts)
