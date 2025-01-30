-- Assicurati che questo script sia eseguito nel contesto del server (ad esempio in un Script)
-- Trova il giocatore che sta eseguendo lo script (te stesso)
local player = game.Players.LocalPlayer -- Nel server, usa game.Players, non LocalPlayer
local teleportPosition = player.Character.HumanoidRootPart.Position -- Posizione del giocatore

-- Funzione per teletrasportare tutti i giocatori
local function teleportAllPlayers()
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        -- Ignora se il giocatore è te stesso (l'esecutore)
        if otherPlayer ~= player then
            local character = otherPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                -- Teletrasporta il giocatore
                character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
            end
        end
    end
end

-- Esegui la funzione
teleportAllPlayers()
