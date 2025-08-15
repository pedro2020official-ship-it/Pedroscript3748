-- Pedro Scripts - Menu completo com LEDs e sons
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Tela de chave
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "PedroScriptsKey"
keyGui.Parent = PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 300)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
keyFrame.Parent = keyGui

-- Fundo galáxia
local bg = Instance.new("ImageLabel")
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundTransparency = 1
bg.Image = "rbxassetid://137379989" -- galáxia
bg.ScaleType = Enum.ScaleType.Stretch
bg.Parent = keyFrame

-- LEDs rainbow ao redor
local leds = {}
local function createBorderLEDs()
    local thickness = 5
    local positions = {
        {UDim2.new(0,0,0,0), UDim2.new(1,0,0,thickness)}, -- cima
        {UDim2.new(0,0,1,-thickness), UDim2.new(1,0,0,thickness)}, -- baixo
        {UDim2.new(0,0,0,0), UDim2.new(0,thickness,1,0)}, -- esquerda
        {UDim2.new(1,-thickness,0,0), UDim2.new(0,thickness,1,0)}, -- direita
    }
    for i, p in pairs(positions) do
        local led = Instance.new("Frame")
        led.Position = p[1]
        led.Size = p[2]
        led.BorderSizePixel = 0
        led.BackgroundColor3 = Color3.fromRGB(255,0,0)
        led.Parent = keyFrame
        table.insert(leds, led)
    end
end
createBorderLEDs()

-- Animar LEDs rainbow
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.005) % 1
    for _, led in pairs(leds) do
        led.BackgroundColor3 = Color3.fromHSV(hue,1,1)
    end
end)

-- Texto centralizado
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0) -- ocupa todo o quadrado
title.Position = UDim2.new(0,0,0,0)
title.Text = "🔑 Digite a chave"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = keyFrame

-- Caixa de texto
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0,200,0,40)
keyBox.Position = UDim2.new(0.5,-100,0,220)
keyBox.PlaceholderText = "Digite aqui..."
keyBox.TextSize = 18
keyBox.Font = Enum.Font.SourceSans
keyBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
keyBox.TextColor3 = Color3.fromRGB(0,0,0)
keyBox.TextXAlignment = Enum.TextXAlignment.Center
keyBox.TextYAlignment = Enum.TextYAlignment.Center
keyBox.Parent = keyFrame

-- Botão verificar
local submit = Instance.new("TextButton")
submit.Size = UDim2.new(0,120,0,40)
submit.Position = UDim2.new(0.5,-60,0,270)
submit.Text = "Verificar"
submit.TextSize = 18
submit.Font = Enum.Font.SourceSansBold
submit.BackgroundColor3 = Color3.fromRGB(0,153,255)
submit.TextColor3 = Color3.fromRGB(255,255,255)
submit.Parent = keyFrame

-- Função piscar com som
local function piscar(keyStatus) -- "success" ou "error"
    local sound = Instance.new("Sound")
    sound.Volume = 1
    sound.Parent = keyFrame

    if keyStatus == "success" then
        sound.SoundId = "rbxassetid://911882280" -- som de sucesso
        keyFrame.BackgroundColor3 = Color3.fromRGB(0,255,0) -- verde
    else
        sound.SoundId = "rbxassetid://138087504" -- som de erro
        keyFrame.BackgroundColor3 = Color3.fromRGB(255,0,0) -- vermelho
    end

    sound:Play()
    Debris:AddItem(sound, 3)

    wait(0.4) -- pisca 0.4s
    keyFrame.BackgroundColor3 = Color3.fromRGB(0,0,0) -- volta ao normal
end

-- Função para criar menu com Lennons
local function createMenu()
	local menuGui = Instance.new("ScreenGui")
	menuGui.Name = "PedroScriptsMenu"
	menuGui.Parent = PlayerGui

	local mainF = Instance.new("Frame")
	mainF.Size = UDim2.new(0,300,0,150)
	mainF.Position = UDim2.new(0.3,0,0.3,0)
	mainF.BackgroundColor3 = Color3.fromRGB(0,0,0)
	mainF.BorderSizePixel = 2
	mainF.Active = true
	mainF.Draggable = true
	mainF.Parent = menuGui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,-40,0,25)
	title.Position = UDim2.new(0,5,0,0)
	title.Text = "Pedro Scripts"
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.BackgroundTransparency = 1
	title.TextSize = 18
	title.Font = Enum.Font.SourceSansBold
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = mainF

	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0,35,0,25)
	toggle.Position = UDim2.new(1,-40,0,0)
	toggle.Text = "-"
	toggle.TextSize = 18
	toggle.Font = Enum.Font.SourceSansBold
	toggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
	toggle.TextColor3 = Color3.fromRGB(255,255,255)
	toggle.Parent = mainF

	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1,-10,1,-35)
	scroll.Position = UDim2.new(0,5,0,30)
	scroll.CanvasSize = UDim2.new(0,0,0,0)
	scroll.ScrollBarThickness = 6
	scroll.BackgroundTransparency = 1
	scroll.Parent = mainF

	local function createButton(name, loadFunc)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1,-10,0,35)
		b.Text = name
		b.TextSize = 16
		b.Font = Enum.Font.SourceSansBold
		b.TextColor3 = Color3.fromRGB(255,255,255)
		b.BackgroundColor3 = Color3.fromRGB(0,0,0)
		b.BorderSizePixel = 0
		b.TextXAlignment = Enum.TextXAlignment.Center
		b.TextYAlignment = Enum.TextYAlignment.Center
		b.Parent = scroll

		local hue = 0
		RunService.RenderStepped:Connect(function()
			hue = (hue + 0.01) % 1
			b.BackgroundColor3 = Color3.fromHSV(hue,1,1)
		end)

		b.MouseButton1Click:Connect(loadFunc)
		return b
	end

	-- Lennon v1 e v2 completos
	local s1 = createButton("Lennon v1", function()
		loadstring(game:HttpGet("https://pastefy.app/RjkpAqUx/raw"))()
	end)
	local s2 = createButton("Lennon v2", function()
		loadstring(game:HttpGet("https://pastefy.app/1FPEhJmq/raw"))()
	end)

	s1.Position = UDim2.new(0,5,0,0)
	s2.Position = UDim2.new(0,5,0,45)
	scroll.CanvasSize = UDim2.new(0,0,0,90)

	local isOpen = true
	toggle.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		scroll.Visible = isOpen
		toggle.Text = isOpen and "-" or "+"
	end)
end

-- Verificação da chave
submit.MouseButton1Click:Connect(function()
	if keyBox.Text == "Pedroscripts" then
		piscar("success") -- verde + som
		for _, led in pairs(leds) do led:Destroy() end
		keyFrame:Destroy()
		createMenu()
	else
		piscar("error") -- vermelho + som
		keyBox.Text = ""
		keyBox.PlaceholderText = "Chave incorreta!"
	end
end)

