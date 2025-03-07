local challenge = Isaac.GetChallengeIdByName("With love from smol")




function EBOI_EVENT:cambiador_de_items_smol()
    items = {
        { id = 644, weight = 50, name = "Consolation Prize" },
        { id = 118, weight = 1, name = "Brimstone" },
        { id = 182, weight = 1, name = "Sacred Heart" },
        { id = 371, weight = 6, name = "Curse of the Tower" },
        { id = 316, weight = 6, name = "Cursed Eye" },
        { id = 276, weight = 6, name = "Isaac's Heart" },
        { id = 330, weight = 6, name = "Soy Milk" },
        { id = 209, weight = 6, name = "Butt Bombs" },
        { id = 652, weight = 6, name = "Cube Baby" },
        { id = 273, weight = 6, name = "Bob's Brain" },
        { id = 15, weight = 6, name = "<3" },
    }

    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        pickup = entity:ToPickup()
        if entity.Type == EntityType.ENTITY_PICKUP and not eevee_uso_el_item and entity.Variant == 100 then
            
            print(entity.Type, entity.SubType,entity.Variant, pickup.Wait )
           
        elseif entity.Type == EntityType.ENTITY_PICKUP and eevee_uso_el_item and entity.Variant == 100 then
            --print(entity.Type, entity.SubType, pickup.Wait )
            pickup.Wait = 0
            --print(pickup.Timeout)
            if pickup.Timeout < 5 and pickup.Timeout ~= -1  then
                sfxManager:Play(SoundEffect.SOUND_ULTRA_GREED_COIN_DESTROY, 1, 4, false, 1, 0)
            end
            local sprite = entity:GetSprite()
            sprite.Color = Color(1,1,1,pickup.Timeout/100/2)
            
        end
    end
end


EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_NEW_ROOM,EBOI_EVENT.cambiador_de_items_smol)