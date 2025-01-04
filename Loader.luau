local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local gameId = game.PlaceId

getgenv().JogoSuportado = true

local function GetIcon()
  local success, result = pcall(function()
  return MarketplaceService:GetProductInfo(gameId)
  end)
  if success and result then
  IconId = result.IconImageAssetId
  end
  end
  
  GetIcon()
  
  local JOGOS_SUPORTADOS = {"4924922222", "9791603388"}
  
local function SetProps(Instance, Props)
    if Props then
        for prop, value in pairs(Props) do
            Instance[prop] = value
        end
    end
    return Instance
end

local function Create(...)
    local args = {...}
    local new = Instance.new(args[1])
    local parent = args[2]
    local props = args[3]
    
    if parent then
        new.Parent = parent
    end
    if props then
        SetProps(new, props)
    end
    return new
end

local function Corner(parent, radius)
    return Create("UICorner", parent, {
        CornerRadius = radius or UDim.new(0, 5)
    })
end

local function Stroke(parent, Colorstk, Thickness)
    local new = Create("UIStroke", parent, {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Colorstk or Color3.fromRGB(120, 120, 120),
        Thickness = Thickness or 0.1
    })
    return new
end

local ViewportSize = workspace.CurrentCamera.ViewportSize
local UIScale = ViewportSize.Y / 660

local function MakeDrag(Instance)
    local Dragging, DragInput, DragStart, StartPosition

    local function Update(input)
        local Delta = input.Position - DragStart
        Instance.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end

    Instance.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = Instance.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    Instance.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

local ScreenGui = Create("ScreenGui", CoreGui, {
    Name = "Loader",
    ResetOnSpawn = false
})
  Create("UIScale", ScreenGui, {
    Scale = UIScale
})

local Icon = Create("ImageLabel", ScreenGui, {
    Name = "Icon",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Size = UDim2.new(0, 0, 0, 0),
    Position = UDim2.new(0, 600, 0, 250),
    Active = true,
    Image = "rbxassetid://10734897102",
    BackgroundTransparency = 0
})
Corner(Icon, UDim.new(0.05, 0))

local tween = TweenService:Create(Icon, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 100, 0, 100)})
tween:Play()
tween.Completed:Wait()
task.wait(3)
local tween = TweenService:Create(Icon, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 400, 0, 250)})
tween:Play()
tween.Completed:Wait()
task.wait(0.1)
local Text = Create("TextLabel", ScreenGui, {
    Name = "Text",
    Size = UDim2.new(0, 275, 0, 0),
    Position = UDim2.new(0, 510, 0, 300),
    Text = "DarkMoonHub V1.0",
    TextSize = 50,
    Font = Enum.Font.FredokaOne,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    BackgroundTransparency = 1
})
task.wait(3)
Icon:Destroy()
Text:Destroy()

local MainFrame = Create("Frame", ScreenGui, {
    Name = "MainFrame",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Size = UDim2.new(0.4, 0, 0, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Active = true,
    BackgroundTransparency = 0
})
Corner(MainFrame, UDim.new(0.05, 0))
MakeDrag(MainFrame)
local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Size = UDim2.new(0.4, 0, 0.6, 0)})
tween:Play()
tween.Completed:Wait()
task.wait(0.1)

local GameName = Create("TextLabel", MainFrame, {
    Name = "GameName",
    Size = UDim2.new(0, 130, 0, 30),
    Position = UDim2.new(0, 365, 0, 53),
    Text = MarketplaceService:GetProductInfo(gameId).Name,
    TextSize = 20,
    Font = Enum.Font.FredokaOne,
    TextColor3 = Color3.fromRGB(240, 240, 240),
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    BackgroundTransparency = 1,
    TextScaled = true
})

local LoadButton = Create("TextButton", MainFrame, {
  Name = "LoadButton",
  Size = UDim2.new(0, 130, 0, 45),
  Position = UDim2.new(0, 365, 0, 215),
  BackgroundColor3 = Color3.fromRGB(0, 225, 0),
  TextColor3 = Color3.fromRGB(255, 255, 255),
  TextSize = 20,
  Font = Enum.Font.FredokaOne,
  TextXAlignment = Enum.TextXAlignment.Center,
  TextYAlignment = Enum.TextYAlignment.Center,
  Text = "Load",
})
Corner(LoadButton, UDim.new(0, 10))

if not table.find(JOGOS_SUPORTADOS, tostring(game.PlaceId)) then
  getgenv().JogoSuportado = false
  SetProps(LoadButton, {
    BackgroundColor3 = Color3.fromRGB(210, 0, 0),
    Text = "Unsupported",
    AutoButtonColor = false
  })
end

LoadButton.MouseButton1Click:Connect(function()
  if getgenv().JogoSuportado then
    ScreenGui:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/Scripts/refs/heads/main/DarkMoonHub.luau"))()
   end
end)

local IconeDoJogo = "rbxassetid://" .. IconId

local GameIcon = Create("ImageLabel", MainFrame, {
    Name = "Icon",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Size = UDim2.new(0, 110, 0, 110),
    Position = UDim2.new(0, 375, 0, 100),
    Active = true,
    Image = IconeDoJogo,
    BackgroundTransparency = 0
})
Corner(GameIcon, UDim.new(0.05, 0))

local FrameSeparador = Create("Frame", MainFrame, {
  Name = "Separator",
  Size = UDim2.new(0, 1, 0, 335),
  Position = UDim2.new(0, 350, 0, 5)
})Corner(FrameSeparador, UDim.new(0, 10))

local TextLaEmCima = Create("TextLabel", MainFrame, {
  Name = "TextDeCima",
  BackgroundTransparency = 1,
  TextColor3 = Color3.fromRGB(255, 255, 255),
  Text = "DarkMoon Hub",
  TextSize = 30,
  Font = Enum.Font.FredokaOne,
  Position = UDim2.new(0, 25, 0, 5),
  Size = UDim2.new(0, 150, 0, 25)
})

local Discord = Create("TextLabel", MainFrame, {
  Name = "DiscordText",
  Text = "https://discord.gg/YDXM43cBU6",
  Size = UDim2.new(0, 200, 0, 25),
  Position = UDim2.new(0, 310, 0, 340),
  TextColor3 = Color3.fromRGB(255, 255, 255),
  Font = Enum.Font.FredokaOne,
  TextSize = 15,
  BackgroundTransparency = 1,
  TextScaled = true,
  TextXAlignment = Enum.TextXAlignment.Right
})

local DiscordCopy = Create("TextButton", MainFrame, {
  Name = "CopyDiscord",
  Text = "",
  Size = UDim2.new(0, 200, 0, 25),
  Position = UDim2.new(0, 310, 0, 340),
  BackgroundTransparency = 1
})

DiscordCopy.MouseButton1Click:Connect(function()
  setclipboard("https://discord.gg/YDXM43cBU6")
  end)

local Bagulho1 = Create("Frame", MainFrame, {
  Name = "Bagulho1",
  BackgroundColor3 = Color3.fromRGB(35, 35, 35),
  Size = UDim2.new(0, 200, 0, 290),
  Position = UDim2.new(0, 25, 0, 50),
  Active = true
})Corner(Bagulho1, UDim.new(0, 10))

local Texto2 = Create("TextLabel", MainFrame, {
  Name = "TextoSupported",
  Text = "Supported Games",
  Position = UDim2.new(0, 120, 0, 40),
  TextColor3 = Color3.fromRGB(255, 255, 255),
  Font = Enum.Font.FredokaOne,
  TextSize = 14
})

local ScrollSuportados = Create("ScrollingFrame", Bagulho1, {
  Name = "ScrollSuportados",
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    AnchorPoint = Vector2.new(0, 0),
    Visible = true,
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
    ScrollingDirection = "Y",
    ElasticBehavior = "Never",
    ScrollBarThickness = 0,
    AutomaticCanvasSize = "Y",
    CanvasSize = UDim2.new(0, 0, 0, 0)
})

Create("UIListLayout", ScrollSuportados, {
  Padding = UDim.new(0, 5)
})

Create("UIPadding", ScrollSuportados, {
  PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingTop = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 5)
})

-- Negocio dos Troco que usa os bagulho 1 e 2

local function AddJogoSuportado(Configs)
  local Text = Configs.Text or Configs[1] or "Nada"
  
  local Frame1 = Create("Frame", ScrollSuportados, {
    Name = "Option",
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
  })Corner(Frame1, UDim.new(0, 1))

local Image = Create("ImageLabel", Frame1, {
  Name = "OptionIcon",
  Image = "rbxassetid://10723395215",
  Size = UDim2.new(0, 20, 0, 20),
  BackgroundTransparency = 1,
  Position = UDim2.new(0, 0, 0, 0)
})

local TextLabel = Create("TextLabel", Frame1, {
  Name = "OptionText",
  Text = Text,
  Size = UDim2.new(0, 170, 0, 20),
  Position = UDim2.new(0, 23, 0, 0),
  TextColor3 = Color3.fromRGB(255, 255, 255),
  Font = Enum.Font.FredokaOne,
  TextXAlignment = Enum.TextXAlignment.Left,
  BackgroundTransparency = 1,
  TextSize = 15,
  TextWrapped= false
})

ScrollSuportados.CanvasSize = ScrollSuportados.CanvasSize + UDim2.new(0, 0, 0, 25)
end

AddJogoSuportado({
  Text = "Underground War 2.0"
})

AddJogoSuportado({
  Text = "BrookHaven 🏡RP"
})
