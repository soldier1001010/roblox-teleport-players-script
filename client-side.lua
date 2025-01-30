-- Riferimenti ai servizi
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Crea il RemoteEvent
local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "CheatStatusChanged"
remoteEvent.Parent = ReplicatedStorage

-- Creazione dell'interfaccia (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 50)
button.Position = UDim2.new(0, 10, 0, 25)
button.Text = "Attiva Cheat"
button.Parent = frame

-- Stato del cheat
local cheatActive = false

-- Funzione per attivare/disattivare il cheat
local function toggleCheat()
    cheatActive = not cheatActive
    if cheatActive then
        button.Text = "Disattiva Cheat"
        remoteEvent:FireServer("activate")  -- Invia al server di attivare il cheat
    else
        button.Text = "Attiva Cheat"
        remoteEvent:FireServer("deactivate")  -- Invia al server di disattivare il cheat
    end
end

-- Collega la funzione al click del bottone
button.MouseButton1Click:Connect(toggleCheat)
