---@param player EntityPlayer
local personaje = PlayerType.PLAYER_EDEN_B
local challenge_eevee = Isaac.GetChallengeIdByName("Eboi's Addiction")
local eevee_uso_el_item = false
local sfxManager = SFXManager()
local tiempo_sonido = 0
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
            --print(entity.Type, entity.SubType,entity.Variant, pickup.Wait )
            pickup.Wait = 10
            --print(pickup.Timeout)
        elseif entity.Type == EntityType.ENTITY_PICKUP and eevee_uso_el_item and entity.Variant == 100 then
            pickup = entity:ToPickup()
            --print(entity.Type, entity.SubType, pickup.Wait )
            pickup.Wait = 0
            --print(pickup.Timeout)
        end
    end
    --print("fin")
   --print("uso item?",eevee_uso_el_item)

    print(tiempo_sonido)
   if tiempo_sonido >= 1 then
    tiempo_sonido = tiempo_sonido + 1
    if sfxManager:IsPlaying(SoundEffect.SOUND_EDEN_GLITCH) then
        sfxManager:Stop(SoundEffect.SOUND_EDEN_GLITCH)
    end
   end

   if tiempo_sonido == 32 then
    sfxManager:Play(SoundEffect.SOUND_ULTRA_GREED_SLOT_WIN_LOOP_END, 1, 2, false, 1, 0)
    tiempo_sonido = 0
   end

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
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_PICKUP and eevee_uso_el_item and entity.Variant == 100 then
            pickup = entity:ToPickup()
            --print(entity.Type, entity.SubType, pickup.Wait, entity:GetEntityFlags() )
            pickup.Timeout = 200

            if entity:GetEntityFlags() & EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE == EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE then
                --print("Este item se duplicara")
                entity:ClearEntityFlags(EntityFlag.FLAG_ITEM_SHOULD_DUPLICATE)
                -- ya no XD
            end
        end
    end
    

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

function EBOI_EVENT:recibir_damage_eevee(ent)
    if Isaac.GetChallenge() ~= challenge_eevee then return end

    if ent:ToPlayer():GetPlayerType() == personaje then
        sfxManager:Play(SoundEffect.SOUND_ULTRA_GREED_SLOT_SPIN_LOOP, 1, 2, false, 1, 0)
        tiempo_sonido = 1
        
    end
    
    

end

EBOI_EVENT:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG,EBOI_EVENT.recibir_damage_eevee)