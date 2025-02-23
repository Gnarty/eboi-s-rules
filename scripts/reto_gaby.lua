--:BombTearflagEffects(Position, Radius, TearFlags, Source, RadiusMult)
-- TearFlags.TEAR_GHOST_BOMB
local challenge_gaby = Isaac.GetChallengeIdByName("Gaby's Nightmare")
local holy_anterior = 0
local tiempo = 0
local holy_rota = false
function EBOI_EVENT:deteccion_de_fantasmas(player)
    if Isaac.GetChallenge() ~= challenge_gaby then return end
    local efectos_jugador = player:GetEffects()
    if holy_rota then
        tiempo = tiempo + 1
        if tiempo > 30 then
            player:TakeDamage(1,DamageFlag.DAMAGE_NOKILL,EntityRef(player),-1)
            holy_rota = false
            tiempo = 0
        end

    end
    --print("tiempo",tiempo)

    

    if efectos_jugador:GetCollectibleEffectNum(313) < holy_anterior then
        if efectos_jugador:GetCollectibleEffectNum(313) <= 1 then
            player:UseCard(Card.CARD_TOWER,UseFlag.USE_NOANIM)
        end
        if efectos_jugador:GetCollectibleEffectNum(313) == 0 then
            holy_rota = true
        end
        
        

    end

    holy_anterior = efectos_jugador:GetCollectibleEffectNum(313)
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,EBOI_EVENT.deteccion_de_fantasmas)



function EBOI_EVENT:reinicio_de_contador_al_iniciar()
    if Isaac.GetChallenge() ~= challenge_gaby then return end
    holy_rota = false
    tiempo = 0
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT,EBOI_EVENT.reinicio_de_contador_al_iniciar)

function EBOI_EVENT:reinicio_de_contador_al_cambiar_de_cuarto()
    if Isaac.GetChallenge() ~= challenge_gaby then return end
    holy_rota = false
    tiempo = 0
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_ROOM,EBOI_EVENT.reinicio_de_contador_al_iniciar)
