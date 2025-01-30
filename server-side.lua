-- Riferimenti ai servizi
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variabili
local cheatActive = false
local teleportPosition = nil
local playerThatActivated = nil

-- Funzione per attivare il cheat
local function activateCheat(player)
    -- Memorizziamo la posizione del giocatore che attiva il cheat
    teleportPosition = player.Character.HumanoidRootPart.Position
    playerThatActivated = player
    cheatActive = true
    
    -- Teletrasportiamo tutti gli altri giocatori verso di te e blocchiamo il movimento
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer.Character and otherPlayer ~= player then
            local character = otherPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
                -- Blocca il movimento (rende il giocatore immobile)
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.PlatformStand = true
                end
            end
        end
    end
end

-- Funzione per disattivare il cheat
local function deactivateCheat()
    cheatActive = false
    -- Ripristina il movimento dei giocatori
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
end

-- Ascolta l'evento che cambia lo stato del cheat
game.ReplicatedStorage:WaitForChild("CheatStatusChanged").OnServerEvent:Connect(function(player, status)
    if status == "activate" then
        activateCheat(player)
    elseif status == "deactivate" then
        deactivateCheat()
    end
end)
