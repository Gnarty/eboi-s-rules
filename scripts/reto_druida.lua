local challenge = Isaac.GetChallengeIdByName("Druida's Funhouse")
local tiempo = 0
local myRNG = RNG()

function EBOI_EVENT:movimiento_constante()
    local player = Isaac.GetPlayer()
    tiempo = tiempo + 1
    --print(tiempo)
    if Isaac.GetChallenge() ~= challenge then return end

    if Input.IsActionPressed(ButtonAction.ACTION_UP,0) or Input.IsActionPressed(ButtonAction.ACTION_DOWN,0) or Input.IsActionPressed(ButtonAction.ACTION_LEFT,0) or Input.IsActionPressed(ButtonAction.ACTION_RIGHT,0) then
        tiempo = 0
        return
    elseif tiempo > 15 then
        player:TakeDamage(1,DamageFlag.DAMAGE_NOKILL,EntityRef(player),-1)
    end



end
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_UPDATE,EBOI_EVENT.movimiento_constante)




function EBOI_EVENT:inicio_de_challenge()
    tiempo = 0
end
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_GAME_STARTED,EBOI_EVENT.inicio_de_challenge)



function EBOI_EVENT:dados()
    local player = Isaac.GetPlayer()
    local room = Game():GetRoom()
    local level = Game():GetLevel()
    local primera_vez_en_sala = room:IsFirstVisit()
    local dados = {
        CollectibleType.COLLECTIBLE_D1,
        CollectibleType.COLLECTIBLE_D4,
        CollectibleType.COLLECTIBLE_D6,
        CollectibleType.COLLECTIBLE_D7,
        CollectibleType.COLLECTIBLE_D8,
        CollectibleType.COLLECTIBLE_D10,
        CollectibleType.COLLECTIBLE_D12,
        CollectibleType.COLLECTIBLE_D20,
        CollectibleType.COLLECTIBLE_D100,
        CollectibleType.COLLECTIBLE_SPINDOWN_DICE
    }
    local tags = {
        UseFlag.USE_NOHUD,
        UseFlag.USE_REMOVEACTIVE,
        UseFlag.USE_NOHUD,
        UseFlag.USE_NOHUD,
        UseFlag.USE_NOHUD,
        UseFlag.USE_NOHUD,
        UseFlag.USE_NOHUD,
        UseFlag.USE_NOHUD,
        UseFlag.USE_REMOVEACTIVE,
        UseFlag.USE_NOHUD,
    }
    local numero_random_de_dado = myRNG:RandomInt(#dados) +1
    local sin_data = 0
    local Sin_slot = -1
    if primera_vez_en_sala then

---@diagnostic disable-next-line: param-type-mismatch
        player:UseActiveItem(dados[numero_random_de_dado],tags[numero_random_de_dado],Sin_slot,sin_data)

        
    end
    --print("numero random",numero_random_de_dado, "dado random",dados[numero_random_de_dado],  "tags",tags[numero_random_de_dado]
  

end
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_ROOM,EBOI_EVENT.dados)


function EBOI_EVENT:deteccion_de_salas()
    
    local rooms = Game():GetLevel():GetRooms()
    local salas_sin_limpiar = 0
    local player = Isaac.GetPlayer()
    local salas = {
        [RoomType.ROOM_NULL] = false,
        [RoomType.ROOM_DEFAULT] = true,
        [RoomType.ROOM_SHOP] = true,
        [RoomType.ROOM_ERROR] = false,
        [RoomType.ROOM_TREASURE] = true,
        [RoomType.ROOM_BOSS] = true,
        [RoomType.ROOM_MINIBOSS] = true,
        [RoomType.ROOM_SECRET] = false,
        [RoomType.ROOM_SUPERSECRET] = false,
        [RoomType.ROOM_ARCADE] = true,
        [RoomType.ROOM_CURSE] = true,
        [RoomType.ROOM_CHALLENGE] = false,
        [RoomType.ROOM_LIBRARY] = true,
        [RoomType.ROOM_DEVIL] = false,
        [RoomType.ROOM_ANGEL] = false,
        [RoomType.ROOM_DUNGEON] = true,
        [RoomType.ROOM_BOSSRUSH] = false,
        [RoomType.ROOM_ISAACS] = true,
        [RoomType.ROOM_BARREN] = true,
        [RoomType.ROOM_CHEST] = true,
        [RoomType.ROOM_DICE] = true,
        [RoomType.ROOM_DICE] = true,
        [RoomType.ROOM_BLACK_MARKET] = false,
        [RoomType.ROOM_GREED_EXIT] = true,
        [RoomType.ROOM_PLANETARIUM] = true,
        [RoomType.ROOM_TELEPORTER] = false,
        [RoomType.ROOM_TELEPORTER_EXIT] = false,
        [RoomType.ROOM_SECRET_EXIT] = false,
        [RoomType.ROOM_BLUE] = false,
        [RoomType.ROOM_ULTRASECRET] = false,
        [RoomType.NUM_ROOMTYPES] = false
    }


    for i = 0, rooms.Size-1 do
        local room = rooms:Get(i)
        
        --print("cuarto",i,":",room.Clear, "sala:", room.Data.Type)
        if salas[room.Data.Type] and not room.Clear then
            salas_sin_limpiar = salas_sin_limpiar + 1
        end


    end

    if salas_sin_limpiar == 0 then
        se_limpio_el_piso = true
        
    end
    --print("salas sin limpiar: ", salas_sin_limpiar)
    --print("se limpio el piso?: ", se_limpio_el_piso)
    local juego = Game()
    juego:Darken(1600,1000)

end
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_UPDATE,EBOI_EVENT.deteccion_de_salas)

function EBOI_EVENT:depresion()
    
if se_limpio_el_piso then
 print("se limpio el piso")
end

end


EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL,EBOI_EVENT.depresion)


function EBOI_EVENT:inicio_de_run_druida()
    local se_limpio_el_piso = false
    
    print("se reinicio el piso")
    
end    
EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_GAME_STARTED,EBOI_EVENT.inicio_de_run_druida)