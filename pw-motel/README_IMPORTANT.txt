3) Refresh esx_addoninventory
   esx_addoninventory -> server -> main.lua

RegisterNetEvent('esx_addoninventory:refreshAddonInventory')
AddEventHandler('esx_addoninventory:refreshAddonInventory', function() 
    local items = MySQL.Sync.fetchAll('SELECT * FROM items')
    for i=1, #items, 1 do
        Items[items[i].name] = items[i].label
    end
    local result = MySQL.Sync.fetchAll('SELECT * FROM addon_inventory')
    for i=1, #result, 1 do
        local name   = result[i].name
        local label  = result[i].label
        local shared = result[i].shared
        local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_inventory_items WHERE inventory_name = @inventory_name', {
            ['@inventory_name'] = name
        })        if shared == 0 then
            table.insert(InventoriesIndex, name)
            Inventories[name] = {}
            local items       = {}
            for j=1, #result2, 1 do
                local itemName  = result2[j].name
                local itemCount = result2[j].count
                local itemOwner = result2[j].owner
                if items[itemOwner] == nil then
                    items[itemOwner] = {}
                end
                table.insert(items[itemOwner], {
                    name  = itemName,
                    count = itemCount,
                    label = Items[itemName]
                })
            end
            for k,v in pairs(items) do
                local addonInventory = CreateAddonInventory(name, k, v)
                table.insert(Inventories[name], addonInventory)
            end
        else
            local items = {}
            for j=1, #result2, 1 do
                table.insert(items, {
                    name  = result2[j].name,
                    count = result2[j].count,
                    label = Items[result2[j].name]
                })
            end
            local addonInventory    = CreateAddonInventory(name, nil, items)
            SharedInventories[name] = addonInventory
        end
    end
end)