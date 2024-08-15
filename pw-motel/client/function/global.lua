if Config.framework == "newesx" then
    ESX = exports["es_extended"]:getSharedObject()
    Citizen.CreateThread(function()
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        if ESX.IsPlayerLoaded() then

            ESX.PlayerData = ESX.GetPlayerData()

        end
    end)
else
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(10)
        end
        while ESX.GetPlayerData().job == nil do
              Citizen.Wait(10)
        end
        if ESX.IsPlayerLoaded() then
  
            ESX.PlayerData = ESX.GetPlayerData()
  
         end
      end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    ESX.PlayerData = ESX.GetPlayerData()
    Wait(2000)
    TriggerServerEvent('pawal:setidentifiermotel_server')
    TriggerServerEvent('pawal:verifinmotel')
end)


AddEventHandler('onClientResourceStart', function (resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
      return
    end
    TriggerServerEvent('pawal:setidentifiermotel_server')
  end)

playeridentifier = nil

RegisterNetEvent('pawal:setidentifiermotel')
AddEventHandler('pawal:setidentifiermotel', function(identifier)
    playeridentifier = identifier
end)

RegisterNetEvent('pawal:notificationmotel')
AddEventHandler('pawal:notificationmotel', function(title, message, statut)
    notification(title, message, statut)
end)

notification = function(title, message, statut)
    if Config.notification == "ESX" then
        ESX.ShowNotification(message)
    elseif Config.notification == "ox_lib" then
        lib.notify({
            title = title,
            description = message,
            position = 'top',
            type = statut
        })
    elseif Config.notification == "custom" then
        Config.notificationCustom(title, message)
    end
end

progressbar = function(message, time)
    if Config.progressbar == "ox" then
        if lib.progressCircle({
            duration = time,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
        }) 
        then
        end
    elseif Config.progressbar == "custom" then
        Config.progressbarcustom(message, time)
    end
end

function advancednotificationfunction(title, soustitre, message, img, iconright)
    if Config.advancednotif == "ESX" then
        ESX.ShowAdvancedNotification(title, soustitre, message, img, iconright)
    elseif Config.advancednotif == "custom" then
        Config.customadvancednotif(title, soustitre, message, img, iconright)
    end
end

EntryMotel = function(interior, chambre, motel, id)
    position.sortie = vector3(IPL.list[interior].EntreePos.x, IPL.list[interior].EntreePos.y, IPL.list[interior].EntreePos.z)
    position.coffre = vector3(IPL.list[interior].coffrepos.x, IPL.list[interior].coffrepos.y, IPL.list[interior].coffrepos.z) 
    position.vestiaire = vector3(IPL.list[interior].vestiairepos.x, IPL.list[interior].vestiairepos.y, IPL.list[interior].vestiairepos.z)
    
    DoScreenFadeOut(500)
    Citizen.Wait(500) 

    TriggerServerEvent('pawal:entreemotel', tonumber(chambre), motel, id)

    SetEntityCoords(PlayerPedId(), IPL.list[interior].EntreePos.x, IPL.list[interior].EntreePos.y, IPL.list[interior].EntreePos.z - 1.0)
    inMotel = true
    chambreNumber = chambre
    motelName = motel

    TriggerServerEvent('pawal:createinventory_pawal', chambre, motel)

    Citizen.Wait(500) 
    DoScreenFadeIn(500)  
end

RegisterNetEvent('pawal:tpplayerafterdeconnexion_motel')
AddEventHandler('pawal:tpplayerafterdeconnexion_motel', function(position)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), position)
    ESX.ShowNotification(translate["teleport_after_disconnect"])
end)

LeaveMotel = function()
    DoScreenFadeOut(500)
    Citizen.Wait(500) 

    TriggerServerEvent('pawal:leavemotel')

    SetEntityCoords(PlayerPedId(), Config.motel[motelName].point[chambreNumber].pos)
    inMotel = false
    chambreNumber = nil
    motelName = nil

    Citizen.Wait(500) 
    DoScreenFadeIn(500)
end

parkingVehicle = function(plate, vehicle, motel, place) 
    ESX.TriggerServerCallback('pawal:verifplace_motel', function(result)        
        ESX.TriggerServerCallback('pawal:verifownercar', function(resultCar)                                            
            if result == true and resultCar == true then
                local playerPed = GetPlayerPed(-1)
                local vehicledata = vehicle
                local propsProperties = Config.getproperties(vehicledata)
                TaskLeaveVehicle(playerPed, vehicle, 0)	
                Citizen.Wait(2000)
                ESX.Game.DeleteVehicle(vehicle)
            
                TriggerServerEvent('pawal:saveparking', propsProperties, plate, motel, place)
            elseif resultCar == false then
                notification(translate.parking_motel["title"], translate.parking_motel["no_owner"], translate.parking_motel["style"])
            else  
                notification(translate.parking_motel["title"], translate.parking_motel["no_place"], translate.parking_motel["style"])
            end
        end, plate)
    end, motel, place)
end

takevehicle = function(vehicle, coords, plate)
    local playerPed = GetPlayerPed(-1)
    local saveVehicle = Config.getproperties(vehicle)
    
    TriggerServerEvent('pawal:deleteparking', plate)
    Wait(300)

    local car = CreateVehicle(saveVehicle.model, coords.x, coords.y, coords.z , coords.w, true, true)
    ESX.Game.SetVehicleProperties(car, saveVehicle)
    TaskWarpPedIntoVehicle(playerPed, car, -1)
end

resultatVerif = false
verifParking = function(motelName)
    ESX.TriggerServerCallback('pawal:checkchambreforparking', function(result)
        resultatVerif = result
    end, motelName)
end

RegisterNetEvent('pawal:verifParking')
AddEventHandler('pawal:verifParking', function() 
    for k,v in pairs(Config.motel) do
        verifParking(v.label)
    end
end)

RegisterNetEvent('pawal:deletecar_motel')
AddEventHandler('pawal:deletecar_motel', function(plate)  
    for k,v in pairs(Config.motel) do
        for k,parking in pairs(v.parking) do
            local vehicle = Config.getclossetvehicle(parking.pos)
            local vehiclePlate = GetVehicleNumberPlateText(vehicle)
            if ESX.Math.Trim(vehiclePlate) == ESX.Math.Trim(plate) then
                DeleteEntity(vehicle)
            end
        end
    end
end)

tableparking = {}
RegisterNetEvent('pawal:refreshparking')
AddEventHandler('pawal:refreshparking', function()
    tableparking = {}

    ESX.TriggerServerCallback('pawal:getdataparking', function(result)
        tableparking = result
    end)

    Wait(100)

    TriggerEvent('pawal:spawnparking')
end)

RegisterNetEvent('pawal:refreshparkingnodelete')
AddEventHandler('pawal:refreshparkingnodelete', function()
    tableparking = {}

    ESX.TriggerServerCallback('pawal:getdataparking', function(result)
        tableparking = result
    end)
end)

for k,v in pairs(Config.motel) do
    motelblips = AddBlipForCoord(v.blip.pos.x, v.blip.pos.y)

    SetBlipSprite(motelblips, v.blip.type)
    SetBlipColour(motelblips, v.blip.couleur)
    SetBlipScale(motelblips, v.blip.taille)
    SetBlipAsShortRange(motelblips, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(v.blip.name) 
    EndTextCommandSetBlipName(motelblips)
end

all_items = {}
function getInventory()
    ESX.TriggerServerCallback('pawal:playerinventory_motel', function(inventory)                          
        all_items = inventory
    end)
end

local chargementVehicle = false
local deleteVehicle = false
Citizen.CreateThread(function()
   while true do
    for k,v in pairs(Config.motel) do
        for k,parking in pairs(v.parking) do
          TimerChargement = 1500
          local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false) 
          local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, v.blip.pos.x, v.blip.pos.y, v.blip.pos.z)
          if dist3 < v.rayonChargement then
               if chargementVehicle == false then
                   TriggerEvent('pawal:spawnparking')
                   verifParking(v.label)
                   chargementVehicle = true
                   deleteVehicle = false
               end
           else
               if deleteVehicle == false then
                   TriggerEvent('pawal:deletecar')
                   deleteVehicle = true
               end
               chargementVehicle = false
          end
        end
       end
       Citizen.Wait(TimerChargement)
   end
end)

RegisterNetEvent('pawal:spawnparking')
AddEventHandler('pawal:spawnparking', function()  
    ESX.TriggerServerCallback('pawal:getdataparking', function(result)
        tableparking = result
    end)

    Wait(200)

    for k,v in pairs(Config.motel) do
        for k,parking in pairs(v.parking) do
            local vehicle = Config.getclossetvehicle(parking.pos)
            local coordsVehicle = GetEntityCoords(vehicle)
            local dist3 = Vdist(parking.pos.x, parking.pos.y, parking.pos.z, coordsVehicle.x, coordsVehicle.y, coordsVehicle.z)
            for k,v in pairs(tableparking) do 
                if dist3 <= 1.3 and GetVehicleNumberPlateText(vehicle) == v.plate then 
                    DeleteEntity(vehicle)
                end
            end
        end
    end

    Wait(50)
    for k,v in pairs (tableparking) do
        if spawn ~= false then
            RequestModel(v.vehicle.model)
            while not HasModelLoaded(v.vehicle.model) do Wait(10) end
            local car = CreateVehicle(v.vehicle.model, Config.motel[v.labelMotel].parking[tonumber(v.numeroPlace)].pos.x, Config.motel[v.labelMotel].parking[tonumber(v.numeroPlace)].pos.y, Config.motel[v.labelMotel].parking[tonumber(v.numeroPlace)].pos.z , Config.motel[v.labelMotel].parking[tonumber(v.numeroPlace)].pos.w, false, false)
            SetVehicleFixed(car)
            SetVehicleDoorsLocked(car, 2)
            SetEntityInvincible(car, true)
            SetVehicleDirtLevel(car, 0.0)
            SetVehicleOnGroundProperly(car)
            SetVehicleFuelLevel(car, 100.0)
            SetVehRadioStation(car, 0)
            FreezeEntityPosition(car, true)
            Config.setproperties(car, v.vehicle)
            Wait(150)
        end
    end
    charger = true
end)

RegisterNetEvent('pawal:deletecar')
AddEventHandler('pawal:deletecar', function()  
    for k,v in pairs(Config.motel) do
        for k,parking in pairs(v.parking) do
            local vehicle = Config.getclossetvehicle(parking.pos)
            local coordsVehicle = GetEntityCoords(vehicle)
            local dist3 = Vdist(parking.pos.x, parking.pos.y, parking.pos.z, coordsVehicle.x, coordsVehicle.y, coordsVehicle.z)
            for k,v in pairs(tableparking) do   
                if dist3 <= 1.3 and GetVehicleNumberPlateText(vehicle) == v.plate then 
                    DeleteEntity(vehicle)
                end
            end
        end
    end
end)

RegisterNetEvent('pawal:stopdemande')
AddEventHandler('pawal:stopdemande', function()
    waitEnter = false
end)

RegisterNetEvent('pawal:sonettemotel')
AddEventHandler('pawal:sonettemotel', function(identifier, namemotel, numberChambreSonette, interior, identifier)
    advancednotificationfunction(namemotel.." N°"..numberChambreSonette, translate.doorbell["request_description"], translate.doorbell["request_message"], translate.doorbell["char_img"], translate.doorbell["iconright"])
    local waitEnter = false
    Citizen.CreateThread(function()
        waitEnter = true
        Citizen.SetTimeout(7500, function()
            if waitEnter == true then
                TriggerServerEvent('pawal:sendnorespond', identifier, namemotel, numberChambreSonette)
            end
            waitEnter = false
        end)
        while waitEnter do
            Citizen.Wait(0)
            if IsControlJustPressed(0, Config.toucheaccepter) then
               notification(namemotel.." N°"..numberChambreSonette, translate.doorbell["accept_message"], translate.doorbell["accept_style"])
               TriggerServerEvent('pawal:acceptersonette_motel', identifier, numberChambreSonette, namemotel, interior)
               TriggerServerEvent('pawal:stopdemande', numberChambreSonette, namemotel)
               waitEnter = false
            elseif IsControlJustPressed(0, Config.toucherefuser) then
                notification(namemotel.." N°"..numberChambreSonette, translate.doorbell["denied_message"], translate.doorbell["denied_style"])
                waitEnter = false
            end
        end
    end)
end)

RegisterNetEvent('pawal:entryplayer_motel')
AddEventHandler('pawal:entryplayer_motel', function(numberChambreSonette, motelNameSonette, interior)
    position.sortie = vector3(IPL.list[interior].EntreePos.x, IPL.list[interior].EntreePos.y, IPL.list[interior].EntreePos.z)
    position.coffre = vector3(IPL.list[interior].coffrepos.x, IPL.list[interior].coffrepos.y, IPL.list[interior].coffrepos.z) 
    position.vestiaire = vector3(IPL.list[interior].vestiairepos.x, IPL.list[interior].vestiairepos.y, IPL.list[interior].vestiairepos.z)

    DoScreenFadeOut(500)
    Citizen.Wait(500) 
    
    SetEntityCoords(PlayerPedId(), IPL.list[interior].EntreePos.x, IPL.list[interior].EntreePos.y, IPL.list[interior].EntreePos.z - 1.0)
    TriggerServerEvent('pawal:entreemotel', tonumber(numberChambreSonette), motelNameSonette)
    inMotel = true
    chambreNumber = numberChambreSonette
    motelName = motelNameSonette

    Citizen.Wait(500) 
    DoScreenFadeIn(500)  

end)

RegisterCommand("deletecarparking", function (source, args, raw)
    ESX.TriggerServerCallback('pawal:verifperm', function(group)
        for k,v in pairs (Config.staff) do
            if group == v then
                local input = lib.inputDialog(translate["delete_car"], {
                    {type = 'input', label = translate["plaque"], required = true},
                })

                if input[1] ~= nil then
                    TriggerServerEvent("pawal:deleteparking", input[1])
                else
                    notification(translate.staffcommand["title"], translate.staffcommand["message"], translate.staffcommand["style"])
                end
            end
        end
	end)
end)

chestitem = nil
function getStock(nameofthemotel, numberofthemotel)
    ESX.TriggerServerCallback('pawal:récupérationstockitem', function(item)               
                
        chestitem = item
        
    end, nameofthemotel.." N°"..numberofthemotel)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end