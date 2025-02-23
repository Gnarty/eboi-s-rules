---@param player EntityPlayer
local personaje = PlayerType.PLAYER_EDEN_B
local challenge_eevee = Isaac.GetChallengeIdByName("Eboi's Addiction")
local eevee_uso_el_item = false

function EBOI_EVENT:analisis_constante(player)
    if Isaac.GetChallenge() ~= challenge_eevee then
        return
    end
    
    if player:GetPlayerType() ~= personaje then
        player:Die()
    end


    -- cambio de trinket
    if player:HasTrinket(TrinketType.TRINKET_POKER_CHIP) then
    else
        player:TryRemoveTrinket(player:GetTrinket(0))
        player:AddTrinket(76,true)
    end

    if player:HasTrinket(TrinketType.TRINKET_NO) then
    else
        player:TryRemoveTrinket(player:GetTrinket(1))
        player:AddTrinket(88,true)
    end

    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_PICKUP and not eevee_uso_el_item and entity.Variant == 100 then
            pickup = entity:ToPickup()
            print(entity.Type, entity.SubType,entity.Variant, pickup.Wait )
            pickup.Wait = 10
        elseif entity.Type == EntityType.ENTITY_PICKUP and eevee_uso_el_item and entity.Variant == 100 then
            pickup = entity:ToPickup()
            print(entity.Type, entity.SubType, pickup.Wait )
            pickup.Wait = 0
        end
    end
    print("fin")
    print("uso item?",eevee_uso_el_item)
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,EBOI_EVENT.analisis_constante)


function EBOI_EVENT:deteccion_de_dropeo_eevee(ent,inp,button)
    if Isaac.GetChallenge() ~= challenge_eevee then return end
    if not ent then return end
    if button == 11 and ent:ToPlayer() and ent:ToPlayer():GetPlayerType() == personaje then
        if inp == 0 then
            return false 
        end
    end
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_INPUT_ACTION, EBOI_EVENT.deteccion_de_dropeo_eevee)



function EBOI_EVENT:regla_de_items()
    if Isaac.GetChallenge() ~= challenge_eevee then return end

    eevee_uso_el_item = true

end

EBOI_EVENT:AddCallback(ModCallbacks.MC_USE_ITEM,EBOI_EVENT.regla_de_items)


function EBOI_EVENT:cambio_de_cuarto_eevee()
    if Isaac.GetChallenge() ~= challenge_eevee then return end

    eevee_uso_el_item = false

end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_ROOM,EBOI_EVENT.cambio_de_cuarto_eevee)


function EBOI_EVENT:inicio_de_juego_eevee()
    if Isaac.GetChallenge() ~= challenge_eevee then return end
    eevee_uso_el_item = false
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT,EBOI_EVENT.inicio_de_juego_eevee)