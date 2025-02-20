local room = Game():GetRoom()
local challenge = Isaac.GetChallengeIdByName("With love from smol")
local player = Isaac.GetPlayer()
local personaje1 = PlayerType.PLAYER_JACOB_B
-- Spawn de los 3 esau
function EBOI_EVENT:iniciador_smol()
    if Isaac.GetChallenge() ~= challenge then return end
    Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, 1, Vector(520,280), Vector(0,0),player)
    Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, 1, Vector(100,280), Vector(0,0),player)
    Isaac.Spawn(EntityType.ENTITY_DARK_ESAU, 0, 1, Vector(320,180), Vector(0,0),Isaac.GetPlayer(0))
    print("funciona, personaje: ", player:GetPlayerType())
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        print(entity.Type, entity.Variant, entity.SubType)
    end
    
    
end


EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_GAME_STARTED,EBOI_EVENT.iniciador_smol)


-- testeos para ver si era un problema con el personaje lo de los esaus
function EBOI_EVENT:test()
    if Isaac.GetChallenge() ~= challenge then return end
    Player:ChangePlayerType(PlayerType.PLAYER_JACOB)
end

EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT,EBOI_EVENT.test)