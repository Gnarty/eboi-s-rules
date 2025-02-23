---@param player EntityPlayer
local personaje = PlayerType.PLAYER_SAMSON
local challenge_kinkan = Isaac.GetChallengeIdByName("KinKan's Awakening")
local juego = Game()
local nivel = juego:GetLevel()
local PRIMER_PISO = 1
-- penalizacion por cambiar de personaje
function EBOI_EVENT:analisis_constante(player)
    if Isaac.GetChallenge() ~= challenge_kinkan then
        return
    end

    --print("vida", player:GetHearts())

end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,EBOI_EVENT.analisis_constante)

function EBOI_EVENT:iniciador_kinkan(player)
    if Isaac.GetChallenge() ~= challenge_kinkan then
        return
    end
    player:AddBrokenHearts(9)
end


EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT,EBOI_EVENT.iniciador_kinkan)

function EBOI_EVENT:verificador_de_vida()
    if Isaac.GetChallenge() ~= challenge_kinkan then
        return
    end
    local etapa = nivel:GetStage()
    local jugador1 = Isaac.GetPlayer()
    if etapa ~= PRIMER_PISO then
        jugador1:AddBrokenHearts(-1)
        jugador1:AddEternalHearts(2)
    end
    
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL,EBOI_EVENT.verificador_de_vida)