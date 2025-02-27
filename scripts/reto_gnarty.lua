local personaje1 = PlayerType.PLAYER_THESOUL_B
local personaje2 = PlayerType.PLAYER_THEFORGOTTEN_B
local challenge_gnarty = Isaac.GetChallengeIdByName("Gnarty's temptation")
local sfxManager = SFXManager()
local segundos = 0
-- deteccion de reto y personaje
function EBOI_EVENT:analisis_constante2(player)
    if Isaac.GetChallenge() ~= challenge_gnarty then return end

    ---print(player:GetPlayerType())
    if player:GetPlayerType() ~= personaje1 and player:GetPlayerType() ~= personaje2 then
        player:Die()
    end

    if player:GetPlayerType() == personaje2 then

        for i = 0, 3 do
            if player:GetCard(i) ~= 0 and player:GetCard(0) ~= Card.CARD_SUICIDE_KING then
                player:SetCard(i,Card.CARD_SUICIDE_KING)
            end

            if player:GetPill(i) ~= 0 then
                player:SetCard(i,Card.CARD_SUICIDE_KING)
            end

        end
        
    end
    
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,EBOI_EVENT.analisis_constante2)


function EBOI_EVENT:contador_gnarty()
    if Isaac.GetChallenge() ~= challenge_gnarty then return end
    segundos = segundos + 1
    --print(segundos)
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_UPDATE, EBOI_EVENT.contador_gnarty)

-- Conteo para cambio entre carta e item

function EBOI_EVENT:deteccion_de_dropeo_gnarty(ent,inp,button)
    if Isaac.GetChallenge() ~= challenge_gnarty then return end
    if not ent then return end
    if button == 11 and ent:ToPlayer() then
        if segundos >= 35 then
            segundos = 0
            sfxManager:Play(SoundEffect.SOUND_SHELLGAME, 1, 2, false, 1, 0)
            return true
        end

        if inp == 0 then
            return false
        end
    end
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_INPUT_ACTION, EBOI_EVENT.deteccion_de_dropeo_gnarty)


