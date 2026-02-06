-- =========================================
--GOJOU HUB😈🟣 | AIMBOT (HEAD LOCK) + ESP FIXO + DISTANCE
-- =========================================

-- ========= CONFIG =========
local SETTINGS = {
	AimEnabled = true,
	FOV = 140,
	Smoothness = 0.6
}

local THEME = {
	Main = Color3.fromRGB(130, 60, 200),
	Light = Color3.fromRGB(180, 120, 255),
	Dark = Color3.fromRGB(70, 30, 120),
	Black = Color3.fromRGB(12, 12, 12),
	BlackSoft = Color3.fromRGB(22, 22, 22),
	Text = Color3.fromRGB(255,255,255)
}

THEME.RedMain  = THEME.Main
THEME.RedLight = THEME.Light
THEME.RedDark  = THEME.Dark

-- ========= SERVICES =========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ========= HOLD =========
local HoldingFire = false
UserInputService.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		HoldingFire = true
	end
end)
UserInputService.InputEnded:Connect(function(i,gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		HoldingFire = false
	end
end)
UserInputService.TouchStarted:Connect(function() HoldingFire = true end)
UserInputService.TouchEnded:Connect(function() HoldingFire = false end)

-- ========= GUI =========
local gui = Instance.new("ScreenGui")
gui.Name = "RedPanel"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- ========= FLOATING BUTTON (ROXO FIX) =========
local float = Instance.new("Frame")
float.Parent = gui
float.Size = UDim2.new(0,56,0,56)
float.Position = UDim2.new(0.08,0,0.45,0)
float.BackgroundColor3 = Color3.fromRGB(130, 60, 200) -- roxo
float.Active = true
float.Draggable = false
float.ZIndex = 1000

Instance.new("UICorner", float).CornerRadius = UDim.new(0,8)

-- BORDA PRETA
local stroke = Instance.new("UIStroke", float)
stroke.Color = Color3.fromRGB(0,0,0)
stroke.Thickness = 2
stroke.Transparency = 0

-- AURA / BRILHO
local aura = Instance.new("UIStroke", float)
aura.Color = Color3.fromRGB(180,120,255)
aura.Thickness = 6
aura.Transparency = 0.75
aura.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- LETRA G
local text = Instance.new("TextLabel", float)
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.Text = "G"
text.Font = Enum.Font.GothamBlack
text.TextScaled = true
text.TextColor3 = Color3.fromRGB(255,255,255)
text.ZIndex = 1001
text.TextStrokeTransparency = 0.4

-- ========= DRAG + CLICK (FIX REAL) =========
local dragging = false
local dragStart
local startPos
local CLICK_DISTANCE = 6

float.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = float.Position
	end
end)

float.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		local delta = input.Position - dragStart
		float.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

float.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		local moved = (input.Position - dragStart).Magnitude
		if moved < CLICK_DISTANCE then
			panel.Visible = not panel.Visible
		end
		dragging = false
	end
end)

-- ========= PANEL COM SCROLL =========
local panel = Instance.new("ScrollingFrame", gui)
panel.Size = UDim2.new(0,260,0,360) -- altura visível do painel
panel.Position = UDim2.new(0.5,-130,0.5,-180)
panel.BackgroundColor3 = THEME.Black
panel.Visible = false
panel.Active = true
panel.ZIndex = 900
panel.ScrollBarThickness = 6
panel.AutomaticCanvasSize = Enum.AutomaticSize.Y -- ajusta altura total conforme botões
panel.ScrollingDirection = Enum.ScrollingDirection.Y -- vertical
Instance.new("UICorner", panel).CornerRadius = UDim.new(0,12)
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = THEME.RedMain
panelStroke.Thickness = 2
panelStroke.Transparency = 0.15

-- ========= DRAG + CLICK =========
local dragging = false
local dragStart
local startPos
local clickThreshold = 5

float.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = float.Position
	end
end)

float.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		if delta.Magnitude > clickThreshold then
			float.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

float.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local delta = (input.Position - dragStart).Magnitude
		if delta < clickThreshold then
			panel.Visible = not panel.Visible
		end
		dragging = false
	end
end)

-- ========= TITLE =========
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1,0,0,36)
title.BackgroundColor3 = THEME.RedDark
title.Text = "GOJOU HUB😈"
title.TextColor3 = THEME.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.ZIndex = 901
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

-- ========= CLOSE BUTTON COM CONFIRMAÇÃO =========
local closeBtn = Instance.new("TextButton", panel)
closeBtn.Size = UDim2.new(0,28,0,28)
closeBtn.Position = UDim2.new(1,-32,0,4) -- canto superior direito
closeBtn.BackgroundColor3 = THEME.RedLight
closeBtn.Text = "❌"
closeBtn.TextColor3 = THEME.Text
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.ZIndex = 1002
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)

closeBtn.MouseButton1Click:Connect(function()
    -- Cria frame de confirmação
    local confirmFrame = Instance.new("Frame", gui)
    confirmFrame.Size = UDim2.new(0,260,0,120)
    confirmFrame.Position = UDim2.new(0.5,-130,0.5,-60)
    confirmFrame.BackgroundColor3 = THEME.Black
    confirmFrame.ZIndex = 2000
    Instance.new("UICorner", confirmFrame).CornerRadius = UDim.new(0,12)

    -- Texto de confirmação
    local confirmText = Instance.new("TextLabel", confirmFrame)
    confirmText.Size = UDim2.new(1,-20,0,60)
    confirmText.Position = UDim2.new(0,10,0,10)
    confirmText.BackgroundTransparency = 1
    confirmText.TextColor3 = THEME.Text
    confirmText.Text = "Tem certeza que quer fechar o GOJOU HUB?"
    confirmText.Font = Enum.Font.GothamBold
    confirmText.TextSize = 16
    confirmText.TextWrapped = true
    confirmText.TextXAlignment = Enum.TextXAlignment.Center
    confirmText.TextYAlignment = Enum.TextYAlignment.Center
    confirmText.ZIndex = 2001

    -- Botão SIM
    local yesBtn = Instance.new("TextButton", confirmFrame)
    yesBtn.Size = UDim2.new(0,100,0,30)
    yesBtn.Position = UDim2.new(0.1,0,1,-40)
    yesBtn.BackgroundColor3 = THEME.RedMain
    yesBtn.Text = "SIM"
    yesBtn.TextColor3 = THEME.Text
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextSize = 14
    yesBtn.ZIndex = 2001
    Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0,6)

    -- Botão NÃO
    local noBtn = Instance.new("TextButton", confirmFrame)
    noBtn.Size = UDim2.new(0,100,0,30)
    noBtn.Position = UDim2.new(0.55,0,1,-40)
    noBtn.BackgroundColor3 = THEME.RedLight
    noBtn.Text = "NÃO"
    noBtn.TextColor3 = THEME.Text
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextSize = 14
    noBtn.ZIndex = 2001
    Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0,6)

    -- Função SIM: fechar tudo
    yesBtn.MouseButton1Click:Connect(function()
        -- Remove GUI
        panel:Destroy()
        float:Destroy()
        confirmFrame:Destroy()

        -- Desativa todas as funções
        SETTINGS.AimEnabled = false
        TeamCheckEnabled = false
        DistanceEnabled = false

        -- Remove ESP
        for _,hl in pairs(ESP) do
            hl:Destroy()
        end
        ESP = {}

        -- Remove labels de distância
        for _,lbl in pairs(DistanceLabels) do
            lbl:Destroy()
        end
        DistanceLabels = {}

        -- Remove FOVCircle
        if FOVCircle then
            FOVCircle.Visible = false
            FOVCircle:Remove()
        end
    end)

    -- Função NÃO: apenas fecha a confirmação
    noBtn.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end)

-- ========= BUTTON FUNCTION =========
local function btn(txt,y)
	local b = Instance.new("TextLabel", panel)
	b.Size = UDim2.new(1,-30,0,32)
	b.Position = UDim2.new(0,15,0,y)
	b.BackgroundColor3 = THEME.BlackSoft
	b.TextColor3 = THEME.Text
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.ZIndex = 902
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

-- ========= AIMBOT =========
local aimBtnLbl = btn("🎯 AIMBOT",45)
local toggle = Instance.new("Frame", panel)
toggle.Size = UDim2.new(0,40,0,20)
local textCenterY = aimBtnLbl.Position.Y.Offset + (aimBtnLbl.Size.Y.Offset/2) - (toggle.Size.Y.Offset/2)
toggle.Position = UDim2.new(0,180,0,textCenterY)
toggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
toggle.ZIndex = 903
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,10)
local circle = Instance.new("Frame", toggle)
circle.Size = UDim2.new(0,18,0,18)
circle.Position = UDim2.new(0,1,0,1)
circle.BackgroundColor3 = THEME.RedMain
circle.ZIndex = 904
Instance.new("UICorner", circle).CornerRadius = UDim.new(1,9)

local function UpdateToggle()
	if SETTINGS.AimEnabled then
		circle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		toggle.BackgroundColor3 = THEME.RedLight
	else
		circle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		toggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

toggle.InputBegan:Connect(function()
	SETTINGS.AimEnabled = not SETTINGS.AimEnabled
	UpdateToggle()
	
	local status = SETTINGS.AimEnabled and "ATIVADO ✅" or "DESATIVADO ❌"
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "🎯 AIMBOT",
			Text = status,
			Duration = 3
		})
	end)
end)
UpdateToggle()

-- ========= TEAM CHECK =========
local teamBtnLbl = btn("🛡️ TEAM CHECK",85)
local teamToggle = Instance.new("Frame", panel)
teamToggle.Size = UDim2.new(0,40,0,20)
local teamCenterY = teamBtnLbl.Position.Y.Offset + (teamBtnLbl.Size.Y.Offset/2) - (teamToggle.Size.Y.Offset/2)
teamToggle.Position = UDim2.new(0,180,0,teamCenterY)
teamToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
teamToggle.ZIndex = 903
Instance.new("UICorner", teamToggle).CornerRadius = UDim.new(0,10)
local teamCircle = Instance.new("Frame", teamToggle)
teamCircle.Size = UDim2.new(0,18,0,18)
teamCircle.Position = UDim2.new(0,1,0,1)
teamCircle.BackgroundColor3 = THEME.RedMain
teamCircle.ZIndex = 904
Instance.new("UICorner", teamCircle).CornerRadius = UDim.new(1,9)
local TeamCheckEnabled = true

local function UpdateTeamToggle()
	if TeamCheckEnabled then
		teamCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		teamToggle.BackgroundColor3 = THEME.RedLight
	else
		teamCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		teamToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

teamToggle.InputBegan:Connect(function()
	TeamCheckEnabled = not TeamCheckEnabled
	UpdateTeamToggle()
	
	local status = TeamCheckEnabled and "ATIVADO ✅" or "DESATIVADO ❌"
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "🛡️ TEAM CHECK",
			Text = status,
			Duration = 3
		})
	end)
end)
UpdateTeamToggle()

-- ========= DISTANCE =========
local distBtnLbl = btn("Mostrar Distância",125)
local distToggle = Instance.new("Frame", panel)
distToggle.Size = UDim2.new(0,40,0,20)
local distCenterY = distBtnLbl.Position.Y.Offset + (distBtnLbl.Size.Y.Offset/2) - (distToggle.Size.Y.Offset/2)
distToggle.Position = UDim2.new(0,180,0,distCenterY)
distToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
distToggle.ZIndex = 903
Instance.new("UICorner", distToggle).CornerRadius = UDim.new(0,10)
local distCircle = Instance.new("Frame", distToggle)
distCircle.Size = UDim2.new(0,18,0,18)
distCircle.Position = UDim2.new(0,1,0,1)
distCircle.BackgroundColor3 = THEME.RedMain
distCircle.ZIndex = 904
Instance.new("UICorner", distCircle).CornerRadius = UDim.new(1,9)

local DistanceEnabled = false
local DistanceLabels = {}

local function UpdateDistToggle()
	if DistanceEnabled then
		distCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		distToggle.BackgroundColor3 = THEME.RedLight
	else
		distCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		distToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

distToggle.InputBegan:Connect(function()
	DistanceEnabled = not DistanceEnabled
	UpdateDistToggle()
	
	local status = DistanceEnabled and "ATIVADO ✅" or "DESATIVADO ❌"
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "📏 DISTANCE",
			Text = status,
			Duration = 3
		})
	end)
end)
UpdateDistToggle()

-- ========= DISTANCE RENDER UNIVERSAL =========
RunService.RenderStepped:Connect(function()
    -- Remove labels antigos
	for _,lbl in pairs(DistanceLabels) do
		lbl:Destroy()
	end
	DistanceLabels = {}

	if DistanceEnabled and LocalPlayer.Character then
        -- Função pra pegar a parte central de um personagem
        local function getRoot(char)
            if char:FindFirstChild("HumanoidRootPart") then return char.HumanoidRootPart end
            if char:FindFirstChild("UpperTorso") then return char.UpperTorso end
            if char:FindFirstChild("LowerTorso") then return char.LowerTorso end
            for _,v in pairs(char:GetChildren()) do
                if v:IsA("BasePart") then return v end
            end
            return nil
        end

        local localRoot = getRoot(LocalPlayer.Character)
        if not localRoot then return end

		for _,p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
                local targetRoot = getRoot(p.Character)
                if targetRoot then
                    local pos, onScreen = Camera:WorldToViewportPoint(targetRoot.Position)
                    if onScreen then
                        local dist = (targetRoot.Position - localRoot.Position).Magnitude
                        local lbl = Instance.new("TextLabel", gui)
                        lbl.Size = UDim2.new(0,100,0,20)
                        lbl.Position = UDim2.new(0,pos.X-50,0,pos.Y-30)
                        lbl.BackgroundTransparency = 1
                        lbl.TextColor3 = Color3.fromRGB(255,255,255)
                        lbl.Font = Enum.Font.GothamBold
                        lbl.TextSize = 13
                        lbl.ZIndex = 2000
                        lbl.Text = string.format("%.1f", dist).."m"
                        table.insert(DistanceLabels,lbl)
                    end
                end
			end
		end
	end
end)

-- ========= FOV =========
local fovTxt = btn("👁️ FOV",165)
local fovPlus = btn("➕ FOV",205)
local fovMinus = btn("➖ FOV",245)
fovPlus.InputBegan:Connect(function()
	SETTINGS.FOV = math.clamp(SETTINGS.FOV + 10, 50, 500)
	fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
end)
fovMinus.InputBegan:Connect(function()
	SETTINGS.FOV = math.clamp(SETTINGS.FOV - 10, 50, 500)
	fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
end)

-- ========= FOV VISUAL =========
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = THEME.RedLight
FOVCircle.Transparency = 1
FOVCircle.Filled = false
RunService.RenderStepped:Connect(function()
	local vp = Camera.ViewportSize
	FOVCircle.Position = Vector2.new(vp.X/2, vp.Y/2)
	FOVCircle.Radius = SETTINGS.FOV
	FOVCircle.Visible = SETTINGS.AimEnabled
end)

-- ========= ESP FIXO =========
local ESP = {}
local function CreateESP(player)
	if player == LocalPlayer then return end
	if ESP[player] then ESP[player]:Destroy() end

	local char = player.Character or player.CharacterAdded:Wait()
	if not char then return end
	if not char:FindFirstChild("HumanoidRootPart") then
		char:WaitForChild("HumanoidRootPart",5)
	end
	if not char then return end

	local hl = Instance.new("Highlight")
	hl.Adornee = char
	hl.FillColor = THEME.RedMain
	hl.OutlineColor = Color3.new(1,1,1)
	hl.FillTransparency = 0.5
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = char

	ESP[player] = hl
end

for _,p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		CreateESP(p)
		p.CharacterAdded:Connect(function()
			task.wait(0.3)
			CreateESP(p)
		end)
	end
end

-- ========= AIMBOT AUTOMÁTICO =========
local function GetTarget()
	local vp = Camera.ViewportSize
	local center = Vector2.new(vp.X/2, vp.Y/2)

	local best,dist = nil, math.huge

	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
			if TeamCheckEnabled and p.Team == LocalPlayer.Team then continue end
			local head = p.Character.Head
			local pos,on = Camera:WorldToViewportPoint(head.Position)
			if on then
				local d = (Vector2.new(pos.X,pos.Y)-center).Magnitude
				if d <= SETTINGS.FOV then
					local mag = (Camera.CFrame.Position-head.Position).Magnitude
					if mag < dist then
						dist = mag
						best = head
					end
				end
			end
		end
	end
	return best
end

RunService.RenderStepped:Connect(function()
	if not SETTINGS.AimEnabled then return end
	local target = GetTarget()
	if not target then return end
	local camPos = Camera.CFrame.Position
	local dir = (target.Position - camPos).Unit
	local dot = Camera.CFrame.LookVector:Dot(dir)
	if dot > 0.3 then
		local cf = CFrame.new(camPos, target.Position)
		Camera.CFrame = Camera.CFrame:Lerp(cf, SETTINGS.Smoothness)
	end
end)

-- ========= ESP BOX + LINHA =========
local espBoxBtnLbl = btn("📦 ESP BOX + LINHA", 285)
local espBoxToggle = Instance.new("Frame", panel)
espBoxToggle.Size = UDim2.new(0,40,0,20)
local espBoxCenterY = espBoxBtnLbl.Position.Y.Offset + (espBoxBtnLbl.Size.Y.Offset/2) - (espBoxToggle.Size.Y.Offset/2)
espBoxToggle.Position = UDim2.new(0,180,0,espBoxCenterY)
espBoxToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
espBoxToggle.ZIndex = 903
Instance.new("UICorner", espBoxToggle).CornerRadius = UDim.new(0,10)
local espBoxCircle = Instance.new("Frame", espBoxToggle)
espBoxCircle.Size = UDim2.new(0,18,0,18)
espBoxCircle.Position = UDim2.new(0,1,0,1)
espBoxCircle.BackgroundColor3 = THEME.RedMain
espBoxCircle.ZIndex = 904
Instance.new("UICorner", espBoxCircle).CornerRadius = UDim.new(1,9)

local ESPBoxEnabled = false
local ESPBoxLines = {}
local ESPBoxFrames = {}

local function UpdateESPBoxToggle()
	if ESPBoxEnabled then
		espBoxCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		espBoxToggle.BackgroundColor3 = THEME.RedLight
	else
		espBoxCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		espBoxToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
        -- Limpa ESP caso desligado
        for _,line in pairs(ESPBoxLines) do line:Destroy() end
        for _,frame in pairs(ESPBoxFrames) do frame:Destroy() end
        ESPBoxLines, ESPBoxFrames = {}, {}
	end
end

espBoxToggle.InputBegan:Connect(function()
	ESPBoxEnabled = not ESPBoxEnabled
	UpdateESPBoxToggle()
	
	local status = ESPBoxEnabled and "ATIVADO ✅" or "DESATIVADO ❌"
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "📦 ESP BOX + LINHA",
			Text = status,
			Duration = 3
		})
	end)
end)
UpdateESPBoxToggle()

-- ========= ESP NOME + LINHA =========
local espNameBtnLbl = btn("👤 ESP NOME + LINHA", 285)
local espNameToggle = Instance.new("Frame", panel)
espNameToggle.Size = UDim2.new(0,40,0,20)
local espNameCenterY = espNameBtnLbl.Position.Y.Offset + (espNameBtnLbl.Size.Y.Offset/2) - (espNameToggle.Size.Y.Offset/2)
espNameToggle.Position = UDim2.new(0,180,0,espNameCenterY)
espNameToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
espNameToggle.ZIndex = 903
Instance.new("UICorner", espNameToggle).CornerRadius = UDim.new(0,10)

local espNameCircle = Instance.new("Frame", espNameToggle)
espNameCircle.Size = UDim2.new(0,18,0,18)
espNameCircle.Position = UDim2.new(0,1,0,1)
espNameCircle.BackgroundColor3 = THEME.RedMain
espNameCircle.ZIndex = 904
Instance.new("UICorner", espNameCircle).CornerRadius = UDim.new(1,9)

local ESPNameEnabled = false
local NameESPObjects = {}

local function UpdateESPNameToggle()
	if ESPNameEnabled then
		espNameCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		espNameToggle.BackgroundColor3 = THEME.RedLight
	else
		espNameCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		espNameToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)

		for _,objs in pairs(NameESPObjects) do
			for _,o in pairs(objs) do
				if o.Destroy then o:Destroy() end
			end
		end
		NameESPObjects = {}
	end
end

espNameToggle.InputBegan:Connect(function()
	ESPNameEnabled = not ESPNameEnabled
	UpdateESPNameToggle()

	local status = ESPNameEnabled and "ATIVADO ✅" or "DESATIVADO ❌"
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "👤 ESP NOME + LINHA",
			Text = status,
			Duration = 3
		})
	end)
end)
UpdateESPNameToggle()

-- ========= ESP NOME + LINHA RENDER =========
RunService.RenderStepped:Connect(function()
	if not ESPNameEnabled then return end

	for _,objs in pairs(NameESPObjects) do
		for _,o in pairs(objs) do
			if o.Destroy then o:Destroy() end
		end
	end
	NameESPObjects = {}

	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
			local head = p.Character.Head
			local root = p.Character:FindFirstChild("HumanoidRootPart")
			if not root then continue end

			local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
			if onScreen then
				-- Nome
				local nameLbl = Instance.new("TextLabel", gui)
				nameLbl.Size = UDim2.new(0,120,0,18)
				nameLbl.Position = UDim2.new(0,pos.X-60,0,pos.Y-28)
				nameLbl.BackgroundTransparency = 1
				nameLbl.Text = p.Name
				nameLbl.TextColor3 = THEME.RedLight
				nameLbl.Font = Enum.Font.GothamBold
				nameLbl.TextSize = 13 -- menor, alinhado
				nameLbl.TextStrokeTransparency = 0
				nameLbl.ZIndex = 2000

				-- Linha
				local line = Drawing.new("Line")
				line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
				line.To = Vector2.new(pos.X, pos.Y)
				line.Color = THEME.RedMain
				line.Thickness = 2
				line.Transparency = 1

				NameESPObjects[p] = {nameLbl, line}
			end
		end
	end
end)

-- ========= AIMBOT REGULÁVEL =========

-- TEXTO (nome + número)
local aimbotPowerTxt = Instance.new("TextLabel", panel)
aimbotPowerTxt.Size = UDim2.new(1,-30,0,20)
aimbotPowerTxt.Position = UDim2.new(0,15,0,325)
aimbotPowerTxt.BackgroundTransparency = 1
aimbotPowerTxt.TextColor3 = THEME.Text
aimbotPowerTxt.Font = Enum.Font.GothamBold
aimbotPowerTxt.TextSize = 13
aimbotPowerTxt.ZIndex = 905
aimbotPowerTxt.TextXAlignment = Enum.TextXAlignment.Left
aimbotPowerTxt.Text = "🎯 Aimbot Regulável: "..string.format("%.2f", SETTINGS.Smoothness)

-- BOTÃO +
local aimbotPlus = Instance.new("TextButton", panel)
aimbotPlus.Size = UDim2.new(0,40,0,24)
aimbotPlus.Position = UDim2.new(0,80,0,350)
aimbotPlus.Text = "+"
aimbotPlus.Font = Enum.Font.GothamBold
aimbotPlus.TextSize = 18
aimbotPlus.BackgroundColor3 = THEME.RedDark
aimbotPlus.TextColor3 = THEME.Text
aimbotPlus.ZIndex = 906
Instance.new("UICorner", aimbotPlus).CornerRadius = UDim.new(0,6)

-- BOTÃO -
local aimbotMinus = Instance.new("TextButton", panel)
aimbotMinus.Size = UDim2.new(0,40,0,24)
aimbotMinus.Position = UDim2.new(0,140,0,350)
aimbotMinus.Text = "-"
aimbotMinus.Font = Enum.Font.GothamBold
aimbotMinus.TextSize = 18
aimbotMinus.BackgroundColor3 = THEME.RedDark
aimbotMinus.TextColor3 = THEME.Text
aimbotMinus.ZIndex = 906
Instance.new("UICorner", aimbotMinus).CornerRadius = UDim.new(0,6)

-- FUNÇÕES
aimbotPlus.MouseButton1Click:Connect(function()
	SETTINGS.Smoothness = math.clamp(SETTINGS.Smoothness + 0.05, 0.05, 1)
	aimbotPowerTxt.Text = "🎯 Aimbot Regulável: "..string.format("%.2f", SETTINGS.Smoothness)
end)

aimbotMinus.MouseButton1Click:Connect(function()
	SETTINGS.Smoothness = math.clamp(SETTINGS.Smoothness - 0.05, 0.05, 1)
	aimbotPowerTxt.Text = "🎯 Aimbot Regulável: "..string.format("%.2f", SETTINGS.Smoothness)
end)

-- ========= ANTI-BAN 80% (VISUAL) =========
local antiBanEnabled = false

local antiBanLbl = Instance.new("TextLabel", panel)
antiBanLbl.Size = UDim2.new(1,-30,0,32)
antiBanLbl.Position = UDim2.new(0,15,0,385)
antiBanLbl.BackgroundColor3 = THEME.BlackSoft
antiBanLbl.TextColor3 = THEME.Text
antiBanLbl.Text = "🛡️ Anti-ban 80%"
antiBanLbl.Font = Enum.Font.GothamBold
antiBanLbl.TextSize = 13
antiBanLbl.ZIndex = 902
Instance.new("UICorner", antiBanLbl).CornerRadius = UDim.new(0,8)

local antiBanToggle = Instance.new("Frame", panel)
antiBanToggle.Size = UDim2.new(0,40,0,20)
antiBanToggle.Position = UDim2.new(0,180,0,391)
antiBanToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
antiBanToggle.ZIndex = 903
Instance.new("UICorner", antiBanToggle).CornerRadius = UDim.new(0,10)

local antiBanCircle = Instance.new("Frame", antiBanToggle)
antiBanCircle.Size = UDim2.new(0,18,0,18)
antiBanCircle.Position = UDim2.new(0,1,0,1)
antiBanCircle.BackgroundColor3 = THEME.RedMain
antiBanCircle.ZIndex = 904
Instance.new("UICorner", antiBanCircle).CornerRadius = UDim.new(1,9)

local function UpdateAntiBan()
	if antiBanEnabled then
		antiBanCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		antiBanToggle.BackgroundColor3 = THEME.RedLight
	else
		antiBanCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		antiBanToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

antiBanToggle.InputBegan:Connect(function()
	antiBanEnabled = not antiBanEnabled
	UpdateAntiBan()

	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "🛡️ Anti-ban 80%",
			Text = antiBanEnabled and "ATIVADO ✅" or "DESATIVADO ❌",
			Duration = 3
		})
	end)
end)

UpdateAntiBan()

-- ========= MODO SEGURO (VISUAL) =========
local safeModeEnabled = false

local safeModeLbl = Instance.new("TextLabel", panel)
safeModeLbl.Size = UDim2.new(1,-30,0,32)
safeModeLbl.Position = UDim2.new(0,15,0,425)
safeModeLbl.BackgroundColor3 = THEME.BlackSoft
safeModeLbl.TextColor3 = THEME.Text
safeModeLbl.Text = "🔒 Modo Seguro"
safeModeLbl.Font = Enum.Font.GothamBold
safeModeLbl.TextSize = 13
safeModeLbl.ZIndex = 902
Instance.new("UICorner", safeModeLbl).CornerRadius = UDim.new(0,8)

local safeToggle = Instance.new("Frame", panel)
safeToggle.Size = UDim2.new(0,40,0,20)
safeToggle.Position = UDim2.new(0,180,0,431)
safeToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
safeToggle.ZIndex = 903
Instance.new("UICorner", safeToggle).CornerRadius = UDim.new(0,10)

local safeCircle = Instance.new("Frame", safeToggle)
safeCircle.Size = UDim2.new(0,18,0,18)
safeCircle.Position = UDim2.new(0,1,0,1)
safeCircle.BackgroundColor3 = THEME.RedMain
safeCircle.ZIndex = 904
Instance.new("UICorner", safeCircle).CornerRadius = UDim.new(1,9)

local function UpdateSafeMode()
	if safeModeEnabled then
		safeCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		safeToggle.BackgroundColor3 = THEME.RedLight
	else
		safeCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		safeToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

safeToggle.InputBegan:Connect(function()
	safeModeEnabled = not safeModeEnabled
	UpdateSafeMode()

	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "🔒 Modo Seguro",
			Text = safeModeEnabled and "ATIVADO ✅" or "DESATIVADO ❌",
			Duration = 3
		})
	end)
end)

UpdateSafeMode()

-- ========= CRÉDITOS (DENTRO DO SCROLL) =========
local credits = Instance.new("TextLabel", panel)
credits.Size = UDim2.new(1,-30,0,32)
credits.Position = UDim2.new(0,15,0,465) -- logo abaixo do Modo Seguro (safeToggle)
credits.BackgroundColor3 = THEME.BlackSoft
credits.TextColor3 = THEME.Text
credits.Font = Enum.Font.GothamBold
credits.TextSize = 12
credits.ZIndex = 902
credits.Text = "CRIADOR: TKK | gojou730"
credits.TextXAlignment = Enum.TextXAlignment.Center
credits.TextYAlignment = Enum.TextYAlignment.Center
Instance.new("UICorner", credits).CornerRadius = UDim.new(0,8)

-- ========= MENSAGEM AO EXECUTAR =========
pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "GOJOU HUB😈",
		Text = "GOJOU HUB ATIVADO😈",
		Duration = 5
	})
end)

warn("GOJOU HUB CARREGADO😈🟣")
