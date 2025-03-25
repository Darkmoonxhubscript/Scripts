local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local gameId = game.PlaceId

getgenv().JogoSuportado = true


local IconId = "0"
local function GetIcon()
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(gameId)
    end)
    if success and result then
        IconId = result.IconImageAssetId
    end
end
GetIcon()

local gameName = "Error Name"
local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(gameId)
end)
if success and info then
    gameName = info.Name
end

local JOGOS_SUPORTADOS = {893973440}

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
    return Create("UIStroke", parent, {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Colorstk or Color3.fromRGB(120, 120, 120),
        Thickness = Thickness or 0.1
    })
end

local function MakeDrag(Instance)
    if not Instance:IsA("GuiObject") then return end

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
    Scale = 0.9384163618087769
})

local Icon = Create("ImageLabel", ScreenGui, {
    Name = "Icon",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Size = UDim2.new(0, 100, 0, 100),
    Position = UDim2.new(0, 600, 0, 250),
    Image = "rbxassetid://10734897102",
    BackgroundTransparency = 0
})
Corner(Icon, UDim.new(0, 15))

local tween = TweenService:Create(Icon, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 100, 0, 100)})
tween:Play()
tween.Completed:Wait()
task.wait(3)
tween = TweenService:Create(Icon, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 320, 0, 250)})
tween:Play()
tween.Completed:Wait()
task.wait(0.1)

local Text = Create("TextLabel", ScreenGui, {
    Name = "Text",
    Size = UDim2.new(0, 275, 0, 0),
    Position = UDim2.new(0, 510, 0, 300),
    Text = "DarkMoonHub V2.8",
    TextSize = 50,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
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
    Active = true
})
Corner(MainFrame, UDim.new(0.05, 0))
MakeDrag(MainFrame)

tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Size = UDim2.new(0.4, 0, 0.6, 0)})
tween:Play()
tween.Completed:Wait()

local GameName = Create("TextLabel", MainFrame, {
    Name = "GameName",
    Size = UDim2.new(0, 130, 0, 45),
    Position = UDim2.new(0, 365, 0, 53),
    Text = gameName,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(240, 240, 240),
    BackgroundTransparency = 1,
    TextScaled = false,
    TextYAlignment = "Bottom"
})

local LoadButton = Create("TextButton", MainFrame, {
    Name = "LoadButton",
    Size = UDim2.new(0, 130, 0, 45),
    Position = UDim2.new(0, 365, 0, 215),
    BackgroundColor3 = table.find(JOGOS_SUPORTADOS, game.PlaceId) and Color3.fromRGB(0, 225, 0) or Color3.fromRGB(210, 0, 0),
    Text = table.find(JOGOS_SUPORTADOS, game.PlaceId) and "Load" or "Unsupported",
    AutoButtonColor = table.find(JOGOS_SUPORTADOS, game.PlaceId) and true or false,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20,
    Font = Enum.Font.GothamBold
})
Corner(LoadButton, UDim.new(0, 10))

LoadButton.MouseButton1Click:Connect(function()
    if table.find(JOGOS_SUPORTADOS, game.PlaceId) then
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/Scripts/refs/heads/main/DarkMoonHub.luau"))()
    end
end)

local GameIcon = Create("ImageLabel", MainFrame, {
    Name = "Icon",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Size = UDim2.new(0, 110, 0, 110),
    Position = UDim2.new(0, 375, 0, 100),
    Image = "rbxassetid://" .. IconId
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
  Font = Enum.Font.GothamBold,
  Position = UDim2.new(0, 40, 0, 8),
  Size = UDim2.new(0, 150, 0, 25)
})

local Discord = Create("TextLabel", MainFrame, {
  Name = "DiscordText",
  Text = "https://discord.gg/YDXM43cBU6",
  Size = UDim2.new(0, 200, 0, 17),
  Position = UDim2.new(0, 310, 0, 340),
  TextColor3 = Color3.fromRGB(255, 255, 255),
  Font = Enum.Font.GothamBold,
  TextSize = 15,
  BackgroundTransparency = 1,
  TextScaled = true,
  TextXAlignment = Enum.TextXAlignment.Right
})

local DiscordCopy = Create("TextButton", MainFrame, {
  Name = "CopyDiscord",
  Text = "",
  Size = UDim2.new(0, 200, 0, 17),
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
  Font = Enum.Font.GothamMedium,
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
  local Text = Configs.Nome or Configs[1] or "Nada"
  
  local Frame1 = Create("Frame", ScrollSuportados, {
    Name = "Option",
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
  })Corner(Frame1, UDim.new(0, 10))

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
  Font = Enum.Font.Gotham,
  TextXAlignment = Enum.TextXAlignment.Left,
  BackgroundTransparency = 1,
  TextSize = 15,
  TextWrapped = false,
  TextTruncate = "AtEnd"
})

ScrollSuportados.CanvasSize = ScrollSuportados.CanvasSize + UDim2.new(0, 0, 0, 25)
end

AddJogoSuportado({
  Nome = "Flee The Facility"
})
