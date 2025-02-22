---@param player EntityPlayer
local personaje = PlayerType.PLAYER_EDEN_B
local challenge = Isaac.GetChallengeIdByName("Eboi's Addiction")

-- cambio de trinket
function EBOI_EVENT:analisis_constante(player)
    if Isaac.GetChallenge() ~= challenge then
        return
    end

    if player:GetPlayerType() ~= personaje then
        player:Die()
    end


    if player:HasTrinket(TrinketType.TRINKET_POKER_CHIP) then
    else
        player:TryRemoveTrinket(player:GetTrinket(0))
        player:AddTrinket(76,true)
    end
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,EBOI_EVENT.analisis_constante)

--ButtonAction.ACTION_DROP



function EBOI_EVENT:deteccion_de_dropeo_eevee(ent,inp,button)
    if Isaac.GetChallenge() ~= challenge then return end
    if not ent then return end
    if button == 11 and ent:ToPlayer() and ent:ToPlayer():GetPlayerType() == personaje then
        if inp == 0 then
            return false 
        end
    end
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_INPUT_ACTION, EBOI_EVENT.deteccion_de_dropeo_eevee)

