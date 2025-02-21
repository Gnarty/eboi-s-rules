local mod = RegisterMod("smolpr", 1)
local smolPresent = Isaac.GetItemIdByName("Smol's Present")
local rng = RNG()

local items = {
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

function mod:smolPresentUse(item)
    local player = Isaac.GetPlayer(0)
    local pos = Isaac.GetFreeNearPosition(player.Position, 25)
    local r = rng:RandomInt(100)
    
    -- Selección del ítem basado en la probabilidad
    local chosenItem
    local cumulativeWeight = 0
    for _, itemData in ipairs(items) do
        cumulativeWeight = cumulativeWeight + itemData.weight
        if r < cumulativeWeight then
            chosenItem = itemData
            break
        end
    end

    -- Crear el ítem en la posición
    if chosenItem then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, chosenItem.id, pos, player.Velocity, player)
    end

    -- SFX y VFX
    Game():SpawnParticles(pos, EffectVariant.POOF01, 1, 0.2, Color(70, 70, 70, 255, 15, 15, 15), math.random())
    local sound_entity = Isaac.Spawn(EntityType.ENTITY_FLY, 0, 0, Vector(320, 300), Vector(0, 0), nil):ToNPC()
    sound_entity:PlaySound(SoundEffect.SOUND_THUMBSUP, 100, 0, false, 1)
    sound_entity:Remove()

    -- Remover el ítem
    player:RemoveCollectible(smolPresent)

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.smolPresentUse, smolPresent)
