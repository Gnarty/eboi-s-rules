local personaje1 = PlayerType.PLAYER_THESOUL_B
local personaje2 = PlayerType.PLAYER_THEFORGOTTEN_B
local challenge = Isaac.GetChallengeIdByName("Gnarty's temptation")
-- deteccion de reto y personaje
function EBOI_EVENT:analisis_constante2(player)
    if Isaac.GetChallenge() ~= challenge then return end

    ---print(player:GetPlayerType())
    if player:GetPlayerType() ~= personaje1 and player:GetPlayerType() ~= personaje2 then
        player:Die()
    end

    if player:GetPlayerType() == personaje1 then
        ---print("alma: ",player:GetCard(0),player:GetCard(1),player:GetCard(2))

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

local segundos = 0
function EBOI_EVENT:deteccion_de_dropeo_gnarty(ent,inp,button)
    if Isaac.GetChallenge() ~= challenge then return end
    if not ent then return end
    
    if button == 11 and ent:ToPlayer() then
        segundos = segundos + 1
        if segundos >= 125 then
            segundos = 0
            return true
        end

        if inp == 0 then
            return false
        end
    end
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_INPUT_ACTION, EBOI_EVENT.deteccion_de_dropeo_gnarty)

