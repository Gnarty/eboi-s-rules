local challenge = Isaac.GetChallengeIdByName("With love from smol")




function EBOI_EVENT:cambiador_de_items_smol(player)

end


EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_ROOM,EBOI_EVENT.cambiador_de_items_smol)