Citizen.CreateThread(function()
    while true do
        for k,v in pairs(Config.motel) do
            for k,parking in pairs(v.parking) do
                if resultatVerif == true then
                    local Timer = 800
                    local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, parking.pos.x, parking.pos.y, parking.pos.z)

                    local vehicle, distance = Config.getclossetvehicle(parking.pos)
                    local coordsVehicle = GetEntityCoords(vehicle)
                    local distVehicle = Vdist(parking.pos.x, parking.pos.y, parking.pos.z, coordsVehicle.x, coordsVehicle.y, coordsVehicle.z)
                    if dist3 <= Config.drawdistance and IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsEntityPositionFrozen(GetVehiclePedIsIn(PlayerPedId())) then
                        if Config.interact == "esx" then
                            DrawMarker(6, parking.pos.x, parking.pos.y, parking.pos.z, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, false)  
                        end
                        Timer = 0
                        if dist3 <= 1.3 then 
                            Timer = 0
                            if Config.interact == "esx" then
                                ESX.ShowHelpNotification(translate["park_vehicle"])
                            else
                                DrawText3D(parking.pos.x, parking.pos.y, parking.pos.z + 1.0, "[E] - "..translate["park_vehicle_text3D"])
                            end
                            if IsControlJustPressed(1,51) then  
                                parkingVehicle(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()), v.label, parking.numeroPlace)
                            end
                        end
                    end 
                end
             end
        end
        Citizen.Wait(Timer)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(Config.motel) do
            for k,parking in pairs(v.parking) do
                local Timer = 800
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, parking.pos.x, parking.pos.y, parking.pos.z)
                if dist3 <= Config.drawdistance and IsPedInAnyVehicle(GetPlayerPed(-1)) and IsEntityPositionFrozen(GetVehiclePedIsIn(PlayerPedId())) then
                    Timer = 0
                    if dist3 <= 1.3 then 
                        Timer = 0
                        if Config.interact == "esx" then
                            ESX.ShowHelpNotification(translate["take_vehicle"])
                        else
                            DrawText3D(parking.pos.x, parking.pos.y, parking.pos.z + 1.0, "[E] - "..translate["take_vehicle_text3D"])
                        end
                        if IsControlJustPressed(1,51) then  
                            takevehicle(GetVehiclePedIsIn(PlayerPedId()), parking.pos, GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))
                        end
                    end
                end 
            end
        end
        Citizen.Wait(Timer)
    end
end)