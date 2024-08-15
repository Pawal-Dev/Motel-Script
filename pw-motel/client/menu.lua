--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝    

 inMotel = false
 motelName = nil
 chambreNumber = nil
 interioname = nil
 outfit = {}
 position = {
    sortie = nil,
    coffre = nil,
    vestiaire = nil
 }
 tableKey = {}


 function motelEntry(label, prix, nombreChambre, interior, owner, id, openhouse)
    RequestAnimDict("anim@heists@keycard@")
    local elements = {}
    if owner == true or openhouse == "1" then
        elements = {
            {
                title = translate["enter_motel"],
                icon = 'fa-solid fa-house', 
                arrow = true, 
                iconColor = "rgba(255, 218, 72, 1)",
                onSelect = function(args)
                    ped = GetPlayerPed(-1)
                    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 8.0, 8.0, -1, 16, 0, 0, 0, 0)
                    Wait(800)
                    EntryMotel(interior, nombreChambre, label, id)
                end
            },
        }
    elseif owner == "different" then
        elements = {
            {
                title = translate["doorbell_button"],
                icon = 'fa-solid fa-bell', 
                description = translate["bouton_bell_description"],
                arrow = true, 
                iconColor = "rgba(255, 218, 72, 1)",
                onSelect = function(args)
                    TaskPlayAnim(PlayerPedId(), "anim@apt_trans@buzzer", "buzz_reg", 8.0, 1.0, 1500, 49, 0, false, false, false)

                    TriggerServerEvent('pawal:sonnermotel', nombreChambre, label, interior)
                end
            },
        }
        for k,v in pairs (Config.policejobname) do
            if ESX.PlayerData.job.name == v then
                table.insert(elements, {
                    title = translate["raid"],
                    icon = 'fa-solid fa-shield',
                    iconColor = "rgba(255, 218, 72, 1)",
                    arrow = true, 
                    iconColor = "rgba(255, 218, 72, 1)",
                    onSelect = function(args)
                        ESX.TriggerServerCallback('pawal:checkitempolice_motel', function(item)
                            if item >= 1 then
                                RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
                                while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
                                    Citizen.Wait(0)
                                end
                                TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' , 'machinic_loop_mechandplayer' ,8.0, -8.0, -1, 1, 0, false, false, false )           
    
                                progressbar(translate["raid_launch"], 5000)
                                
                                TriggerServerEvent('pawal:startraid_motel', label, nombreChambre)
                                notification(translate["raid_title"], translate["police_open"], translate["raid_style_success"])
                                ClearPedTasks(GetPlayerPed(-1))
                            else
                                notification(translate["raid_title"], translate["police_error"], translate["raid_style_error"])
                            end
                        end, Config.itemForOpenHouse)
                    end
                })
            end
        end
    elseif owner == false then
        elements = {
            {
                title = translate["bouton_buy"],
                icon = 'fa-solid fa-money-bill', 
                description = translate["bouton_buy_description"],
                arrow = true, 
                iconColor = "rgba(255, 218, 72, 1)", 
                onSelect = function(args) 
                    local inputtime = lib.inputDialog(translate["contrat"], {
                        {type = 'number', label = 'Nombre de jour de location', icon = 'fa-solid fa-clock', min = 1, max = Config.maxlocationtime, required = true},
                    })
    
                    local input = lib.inputDialog(translate["contrat"], {
                        { type = 'select', label = translate["payement_method"], required = true, options = {
                            { value = 'liquide', label = translate.method["cash"]},
                            { value = 'banque', label = translate.method["bank"] },
                        }},
    
                        {type = 'checkbox', label = translate["accept_contrat"]..' '..prix*inputtime[1].." "..Config.Devise, required = true},
                    })
    
                    if math.round(inputtime[1]) <= 50 then
                        TriggerServerEvent('pawal:buychambre', label, prix*inputtime[1], nombreChambre, inputtime[1], input[1])
                    else
                        notification(translate.error_time["title"], translate.error_time["message"], translate.error_time["style"])
                    end
                end
            },
        }
    end
    lib.registerContext({
        id = 'motel_entry',
        title = label.." N°"..nombreChambre,
        options = elements
    })
    lib.showContext('motel_entry')
end

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(Config.motel) do
            for k,point in pairs(v.point) do
                local Timer = 800
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, point.pos.x, point.pos.y, point.pos.z)
                if dist3 <= Config.drawdistance then
                    if Config.interact == "esx" then
                        DrawMarker(Config.MarkerType, point.pos.x, point.pos.y, point.pos.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                    end
                    Timer = 0
                    if dist3 <= 1.3 then 
                        Timer = 0
                        if Config.interact == "esx" then
                            ESX.ShowHelpNotification(translate["interact_entry"])
                        else
                            DrawText3D(point.pos.x, point.pos.y, point.pos.z, "[E] - "..v.label.." N°"..point.numberChambre)
                        end
                        if IsControlJustPressed(1,51) then  
                            RequestAnimDict("anim@apt_trans@buzzer")

                            ESX.TriggerServerCallback('pawal:checkmotel', function(owned)
                                owner = owned
                            end, v.label, point.numberChambre)

                            ESX.TriggerServerCallback('pawal:checkopenhouse', function(openhousepolice)
                                openhouse = openhousepolice
                            end, v.label, point.numberChambre)

                            if Config.Coffre == "ox_inventory" then
                                TriggerServerEvent('pawal:createchest', v.label, point.numberChambre, IPL.list[point.interior].poid, IPL.list[point.interior].slots)
                            end 

                            Wait(200)

                            interioname = point.interior

                            motelEntry(v.label, v.prix, point.numberChambre, point.interior, owner, nil, openhouse)
                        end
                    end
                end 
            end
        end
        Citizen.Wait(Timer)
    end
end)

function inMotelInteract()

    ESX.TriggerServerCallback('pawal:checkmotel', function(owned)
        owner = owned
    end, motelName, chambreNumber)

    if owner == true then
        elements = {
            {
                title = translate["exit_motel"],
                icon = 'fa-solid fa-house', 
                arrow = true, 
                iconColor = "rgba(255, 218, 72, 1)",
                onSelect = function(args) 
                    ped = GetPlayerPed(-1)
                    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 8.0, 8.0, -1, 16, 0, 0, 0, 0)
                    Wait(800)
                    LeaveMotel()
                end
            },

            {
                title = translate["gestion_key"],
                icon = 'fa-solid fa-key', 
                description = translate["gestion_key_description"],
                arrow = true, 
                iconColor = "rgba(255, 218, 72, 1)",
                onSelect = function(args) 
                    keygestion()
                end
            },
        }
    else
        elements = {
            {
                title = translate["exit_motel"],
                icon = 'fa-solid fa-house', 
                arrow = true, 
                iconColor = "rgba(255, 218, 72, 1)",
                onSelect = function(args) 
                    ped = GetPlayerPed(-1)
                    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 8.0, 8.0, -1, 16, 0, 0, 0, 0)
                    Wait(800)
                    LeaveMotel()
                end
            }
        }
    end
    
    lib.registerContext({
        id = 'motel_exit',
        title = motelName.." N°"..chambreNumber,
        options = elements
    })
    lib.showContext('motel_exit')
end

function keygestion()
    
    local elements = {}
    local listing = {}
    local optionStandard = {
            title = translate["add_player"],
            icon = 'fa-solid fa-plus',
            description = translate["add_player_description"],
            arrow = true, 
            iconColor = "rgba(0, 218, 0, 1)",
            onSelect = function(args)
                local players = {}
                local ptable = GetActivePlayers()
                local source =  GetEntityCoords(GetPlayerPed(-1), false)
                for _, i in ipairs(ptable) do
                    local ped = GetPlayerPed(i) 
                    local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
                    if (Vdist(GetEntityCoords(ped), source.x, source.y, source.z) < 4.0) then
                        ESX.TriggerServerCallback('pawal:getname_motel', function(result)
                            table.insert(listing, {
                                value = id,
                                label = result,
                            })
                        end, id)
                    end
                end

                Wait(200)

                if #listing >= 1 then
                    local inputsecond = lib.inputDialog(translate["label_input_add_player"], {
                        {type = 'select', label = translate["proximity_player"], required = true, options = listing},
                    })

                    TriggerServerEvent('pawal:addkey', inputsecond[1], chambreNumber, motelName)

                    Wait(250)

                    ESX.TriggerServerCallback('pawal:getkey', function(key)
                        tableKey = key
                    end, motelName, chambreNumber)
                    Wait(100)
                    
                    keygestion()
                else
                    notification(translate.noplayer_proximity["title"], translate.noplayer_proximity["message"], translate.noplayer_proximity["style"])
                end
            end 
    }
    table.insert(elements, optionStandard)

    for k,v in pairs(tableKey) do
        local option = {
            title = v.name,
            arrow = true, 
            iconColor = "rgba(255, 218, 72, 1)",
            onSelect = function(args)
                local input = lib.inputDialog(translate["delete_coproprio"], {
                    {type = 'checkbox', label = translate["confirm_coproprio"]..' '..v.name, required = true},
                })

                if input[1] == true then
                    TriggerServerEvent('pawal:deletekey_motel', chambreNumber, motelName, v.name, v.identifier)

                    Wait(250)

                    ESX.TriggerServerCallback('pawal:getkey', function(key)
                        tableKey = key
                    end, motelName, chambreNumber)
                    Wait(100)
                    
                    keygestion()
                end
            end
        }
        table.insert(elements, option)
    end 

    lib.registerContext({
        id = 'motel_entry',
        title = motelName.." N°"..chambreNumber,
        options = elements,
        menu = "motel_exit"
    })
    lib.showContext('motel_entry')
end

Citizen.CreateThread(function()
    while true do
        if inMotel == true then
            boolSortie = false
            local Timer = 800
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, position.sortie)
            if dist3 <= Config.drawdistance then
                if Config.interact == "esx" then
                    DrawMarker(Config.MarkerType, position.sortie, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
                Timer = 0
                if dist3 <= 1.3 then 
                    Timer = 0
                    if Config.interact == "esx" then
                        ESX.ShowHelpNotification(translate["interact_exit"])
                    else
                        DrawText3D(position.sortie.x, position.sortie.y, position.sortie.z, "[E] - "..motelName.." N°"..chambreNumber)
                    end
                    if IsControlJustPressed(1,51) then  

                        ESX.TriggerServerCallback('pawal:getkey', function(key)
                            tableKey = key
                        end, motelName, chambreNumber)

                        Wait(150)
                        
                        inMotelInteract()
                    end
                end
            end
        end
         Citizen.Wait(Timer)
    end
end)

Citizen.CreateThread(function()
    while true do
        if inMotel == true then
            bool = false
            local Timer = 800
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, position.coffre)
            if dist3 <= Config.drawdistance then
                if Config.interact == "esx" then
                    DrawMarker(Config.MarkerType, position.coffre, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
                Timer = 0
                if dist3 <= 1.2 then 
                    Timer = 0
                    if Config.interact == "esx" then
                        ESX.ShowHelpNotification(translate["interact_coffre"])
                    else
                        DrawText3D(position.coffre.x, position.coffre.y, position.coffre.z, "[E] - "..translate["interact_coffre_text3d"])
                    end
                    if IsControlJustPressed(1,51) then 
                        if Config.Coffre == "pw-motel" then
                            Coffre()
                        elseif Config.Coffre == "ox_inventory" then
                            exports.ox_inventory:openInventory('stash', motelName.." N°"..chambreNumber)
                        else
                            print(IPL.list[interioname].poid)
                            Config.customcoffre(motelName, chambreNumber, IPL.list[interioname].poid, IPL.list[interioname].slots)
                        end 
                    end
                end
            end
        end
         Citizen.Wait(Timer)
    end
end)

function Coffre()
    elements = {
        {
            title = translate["deposit_item"],
            icon = 'fa-solid fa-box', 
            arrow = true, 
            iconColor = "rgba(255, 218, 72, 1)",
            onSelect = function(args) 
                getInventory()
                Wait(100)
                deposerItem()
            end
        },
        {
            title = translate["take_item"],
            icon = 'fa-solid fa-box', 
            arrow = true, 
            iconColor = "rgba(255, 218, 72, 1)",
            onSelect = function(args) 
                getStock(motelName, chambreNumber)
                Wait(150)
                retirerItem()
            end
        },
    }
    lib.registerContext({
        id = 'coffre_menu',
        title = translate["coffre"],
        options = elements
    })
    lib.showContext('coffre_menu')
end

function deposerItem()
    local item_list = {}
    if #all_items == 0 then
        item_list = {
            {
                title = translate["no_item_player"],
                icon = 'fa-solid fa-circle-xmark', 
                iconColor = "rgba(255, 0, 0, 1)",
                onSelect = function(args) 
                end
            },
        }
     else
        for k,v in pairs(all_items) do     
            table.insert(item_list, {
                title = v.label,
                description = "x"..math.round(v.nb),
                onSelect = function(args)
                    local input = lib.inputDialog(translate["deposit"]..' '..v.label, {
                        {type = 'number', label = translate["count"], required = true},
                    })
                    count = tonumber(input[1])
                    TriggerServerEvent("pawal:depotcoffre_motel",v.item, count, motelName, chambreNumber)
                    getInventory()
                end
            })
        end
     end
    lib.registerContext({ 
        id = 'inventory_perso',
        title = translate["coffre"],
        menu = "coffre_menu",
        options = item_list
    })
    lib.showContext('inventory_perso')
end

function retirerItem()
    local item_list = {}
    if #chestitem == 0 then
        item_list = {
            {
                title = translate["no_item_coffre"],
                icon = 'fa-solid fa-circle-xmark', 
                iconColor = "rgba(255, 0, 0, 1)",
                onSelect = function(args) 
                end
            },
        }
     else
        for k,v in pairs(chestitem) do     
            table.insert(item_list, {
                title = v.label,
                description = "x"..math.round(v.nb),
                onSelect = function(args)
                    local input = lib.inputDialog(translate["take"]..' '..v.label, {
                        {type = 'number', label = translate["count"], required = true},
                    })
                    count = tonumber(input[1])
                    if count <= v.nb then
                        TriggerServerEvent("pawal:retraitcoffre_motel", v.item, count, motelName, chambreNumber)
                        getStock(motelName, chambreNumber)
                    else
                        notification(translate["coffre"], translate.nostock["thirdpart"].." "..v.label.." "..translate.nostock["secondpart"], translate.nostock["style"])
                    end
                end
            })
        end
     end
    lib.registerContext({ 
        id = 'inventory_perso',
        title = translate["coffre"],
        menu = "coffre_menu",
        options = item_list
    })
    lib.showContext('inventory_perso')
end

function Vestiaire()
    while not HasAnimDictLoaded("clothingtie") do RequestAnimDict("clothingtie") Wait(100) end         

    elements = {
        {
            title = translate["save_outfit"],
            icon = 'fa-solid fa-plus', 
            iconColor = "rgba(0, 255, 2, 1)",
            onSelect = function(args) 
                local input = lib.inputDialog(translate["save_outfit_input"], {
                    {type = 'input', label = translate["save_input"], required = true},
                  })
                if input[1] ~= nil and input[1] ~= "" then
                    local model = GetEntityModel(GetPlayerPed(-1))
                    TriggerEvent("skinchanger:getSkin", function(skin)
                        TriggerServerEvent("pawal:sauvegardetenue_motel", input[1], skin, motelName.." N°"..chambreNumber, model)
                    end)
                else
                    notification(translate.clothes_error["title"], translate["errorinput"], translate.clothes_error["style"])
                end 
            end
        }
    }

    for k,v in pairs(outfit) do
        table.insert(elements, {
            title = v.tenuename,
            arrow = true,  
            onSelect = function(args) 
                local input = lib.inputDialog(v.tenuename, {
                    { type = 'select', label = translate.clothes["action"], required = true, options = {
                        { value = 'take', label = translate.clothes["take"]},
                        { value = 'rename', label = translate.clothes["rename"]},
                        { value = 'delete', label = translate.clothes["delete"]},
                    }},
                })

                if input[1] == "take" then
                    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 3.0, 3.0, 3200, 0, 0, false, false, false)
                    progressbar(translate["load_outfit"], 3200)
                    notification(translate.takeclothes["title"], translate.takeclothes["take_notification"]..' '..v.tenuename, translate.takeclothes["style"])
                    TriggerEvent("skinchanger:getSkin", function(skin)
                        TriggerEvent("skinchanger:loadClothes", skin, v.skin)
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerServerEvent("pawal:applicationskin_motel", skin)
                        end)
                    end)
                elseif input[1] == "rename" then
                    local renameOutfit = lib.inputDialog('Renommer une Tenue', {
                        {type = 'input', label = translate["save_input"], required = true},
                      })
                    if renameOutfit[1] ~= nil and renameOutfit[1] ~= "" then
                        local model = GetEntityModel(GetPlayerPed(-1))
                        TriggerServerEvent("pawal:renameoutfit_motel", renameOutfit[1], motelName.." N°"..chambreNumber, v.id)
                        notification(translate.editclothes["title"], translate.editclothes["edit_notification"]..' '..v.tenuename, translate.editclothes["style"])

                    else
                        notification(translate.editclothes["error_title"], translate["errorinput"], translate.editclothes["error_style"])
                    end
                elseif input[1] == "delete" then
                    local input = lib.inputDialog(translate["valid_delete"], {
                        {type = 'checkbox', label = translate["valid_delete_input"].." "..v.tenuename, required = true},
                    })
                    if input[1] == true then
                        TriggerServerEvent('pawal:deleteoutfit_motel', v.id)
                        notification(translate.deleteclothes["title"], translate.deleteclothes["delete_notification"]..' '..v.tenuename, translate.deleteclothes["style"])
                    else
                        notification(translate.deleteclothes["error_title"], translate["errorinput"], translate.deleteclothes["error_style"])
                    end
                end
            end
        })
    end
    lib.registerContext({
        id = 'vestiaire_menu',
        title = translate["vestiaire"],
        options = elements
    })
    lib.showContext('vestiaire_menu')
end

Citizen.CreateThread(function()
    while true do
        if inMotel == true then
            bool = false
            local Timer = 800
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, position.vestiaire)
            if dist3 <= Config.drawdistance then
                if Config.interact == "esx" then
                    DrawMarker(Config.MarkerType, position.vestiaire, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
                Timer = 0
                if dist3 <= 1.3 then 
                    Timer = 0
                    if Config.interact == "esx" then
                        ESX.ShowHelpNotification(translate["interact_vestiaire"])
                    else
                        DrawText3D(position.vestiaire.x, position.vestiaire.y, position.vestiaire.z, "[E] - "..translate["vestiaire"])
                    end
                    if IsControlJustPressed(1,51) then 

                        ESX.TriggerServerCallback('pawal:getclothes_motel', function(clothescallback)   
                            outfit = clothescallback                     
                        end, motelName.." N°"..chambreNumber)

                        Wait(200)

                        if Config.Vestiaire == "pw-motel" then
                            Vestiaire()
                        else
                            Config.customvestiaire(motelName, chambreNumber)
                        end 
                    end
                end
            end
        end
         Citizen.Wait(Timer)
    end
end)
