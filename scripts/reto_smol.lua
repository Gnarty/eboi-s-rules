local challenge = Isaac.GetChallengeIdByName("With love from smol")




function EBOI_EVENT:cambiador_de_items_smol()
    local regalo_smol = Isaac.GetItemIdByName("Smol's Present")
    local items_regalo = {
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
        { id = regalo_smol, weight = 6, name = "Smol's Present" },
    }

    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        pickup = entity:ToPickup()
        
        
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == 100 then
            local esta_en_la_lista = false
            if entity.Type == EntityType.ENTITY_PICKUP then
                local esta_en_la_lista = false
    
                for _, j in ipairs(items_regalo) do
                    if j.id == entity.SubType then
                        esta_en_la_lista = true
                        break
                    end
                end
                
                if not esta_en_la_lista then
                    print(entity.Type, entity.SubType,entity.Variant, pickup.Wait, "item no encontrado")
                    pickup:Morph(entity.Type, entity.Variant, regalo_smol, KeepPrice, false, true)
                    print(entity.Type, entity.SubType,entity.Variant, pickup.Wait, "nuevo item smol")
                end
            end
        end
            
           
            
        
    end
end


EBOI_EVENT:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,EBOI_EVENT.cambiador_de_items_smol)