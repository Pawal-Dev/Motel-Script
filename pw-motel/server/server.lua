if Config.framework == "newesx" then
	ESX = exports["es_extended"]:getSharedObject()
else
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

--██████╗ ██████╗ ██████╗ ███████╗
--██╔════╝██╔═══██╗██╔══██╗██╔════╝
--██║     ██║   ██║██║  ██║█████╗  
--██║     ██║   ██║██║  ██║██╔══╝  
--╚██████╗╚██████╔╝██████╔╝███████╗
-- ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
                                 
RegisterNetEvent('pawal:buychambre')
AddEventHandler('pawal:buychambre', function(label, prix, numberChambre, day, typeAchat)
	local xPlayer = ESX.GetPlayerFromId(source)
	local locationCount = 0
	MySQL.Async.fetchAll('SELECT * FROM motel WHERE owner = @owner AND labelMotel = @labelMotel', {
		['@owner'] = xPlayer.identifier,
		["@labelMotel"] = label
	}, function(result)
		for k,v in pairs(result) do
			locationCount = locationCount + 1
		end
    end)

	Wait(150)

	if tonumber(locationCount) <= 0 then
		if typeAchat == "liquide" then
			account = xPlayer.getMoney()
		else
			account = xPlayer.getAccount('bank').money
		end
	
		
		if account >= prix then
			MySQL.Async.execute("INSERT INTO motel (owner, labelMotel, numberChambre, day) VALUES (@owner, @labelMotel, @numberChambre, @day)", 	
			{
				["@owner"] = xPlayer.identifier,
				["@labelMotel"] = label,
				["@numberChambre"] = numberChambre,
				["@day"] = day,
			})
			TriggerClientEvent("pawal:notificationmotel", xPlayer.source, translate.buysuccess["title"], translate.buysuccess["message"].." "..prix.." "..Config.Devise, translate.buysuccess["style"])
			
			if typeAchat == "liquide" then
				xPlayer.removeMoney(prix)
			else
				xPlayer.removeAccountMoney('bank', prix)
			end
		else
			if typeAchat == "liquide" then
				TriggerClientEvent('pawal:notificationmotel', xPlayer.source, translate.buyerror_cash["title"], translate.buyerror_cash["message"], translate.buyerror_cash["style"] )
			else
				TriggerClientEvent('pawal:notificationmotel', xPlayer.source, translate.buyerror_bank["title"], translate.buyerror_bank["message"], translate.buyerror_bank["style"] )
			end
		end
	else
		TriggerClientEvent('pawal:notificationmotel', xPlayer.source, translate.limit_motel["title"], translate.limit_motel["message"], translate.limit_motel["style"])
	end

	TriggerClientEvent('pawal:verifParking', source)
end)

RegisterNetEvent('pawal:createchest')
AddEventHandler('pawal:createchest', function(motel, chambre, poid, slots)
	local name = motel.." N°"..chambre
	local stash = {
		id = name,
		label = name,
		slots = tonumber(slots),
		weight = tonumber(poid),
	}
	exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, true, false)
end)

ESX.RegisterServerCallback("pawal:checkchambreforparking", function(source, cb, nameMotel)
    local xPlayer = ESX.GetPlayerFromId(source)
	local verif = false
	MySQL.Async.fetchAll('SELECT * FROM motel WHERE labelMotel = @labelMotel and owner = @owner', {
		['@labelMotel'] = nameMotel,
		['@owner'] = xPlayer.identifier
	}, function(result)
		if result[1].owner == xPlayer.identifier then
			verif = true
		else
			MySQL.Async.fetchAll('SELECT * FROM motel_key WHERE labelMotel = @labelMotel and owner = @owner', {
				['@labelMotel'] = nameMotel,
				['@owner'] = xPlayer.identifier
			}, function(resultcoowner)
				if resultcoowner[1] then
					verif = true
				end
			end)
        end

		Wait(200)
		cb(verif)
    end)
end)

ESX.RegisterServerCallback("pawal:checkmotel", function(source, cb, nameMotel, numberChambre)
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM motel WHERE labelMotel = @labelMotel AND numberChambre = @numberChambre', {
		['@labelMotel'] = nameMotel,
        ["@numberChambre"] = numberChambre
	}, function(result)
        if result[1] ~= nil then
			if result[1].owner == xPlayer.identifier then
				cb(true)
			else
				MySQL.Async.fetchAll('SELECT * FROM motel_key WHERE labelMotel = @labelMotel AND numberChambre = @numberChambre', {
					["@identifier"] = xPlayer.identifier,
					['@labelMotel'] = nameMotel,
					['@numberChambre'] = numberChambre,
				}, function(result)
					if result[1] ~= nil then
						cb(true)
					else
						cb("different")
					end
				end)
			end
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('pawal:checkitempolice_motel', function(source, cb, itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	cb(item_in_inventory)
end)

ESX.RegisterServerCallback("pawal:checkopenhouse", function(source, cb, nameMotel, numberChambre)
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM motel WHERE labelMotel = @labelMotel AND numberChambre = @numberChambre', {
		['@labelMotel'] = nameMotel,
        ["@numberChambre"] = numberChambre
	}, function(result)
		cb(result[1].openhouse)
    end)
end)

RegisterNetEvent('pawal:setidentifiermotel_server')
AddEventHandler('pawal:setidentifiermotel_server', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		TriggerClientEvent("setidentifiermotel", source, xPlayer.identifier)
	end
end)

RegisterNetEvent('pawal:entreemotel')
AddEventHandler('pawal:entreemotel', function(idmotel, nameMotel)
	xPlayer = ESX.GetPlayerFromId(source)
	id = source + 3

	MySQL.Async.fetchAll('SELECT * FROM motel WHERE labelMotel = @labelMotel AND numberChambre = @numberChambre', {
		["@identifier"] = xPlayer.identifier,
		['@labelMotel'] = nameMotel,
		['@numberChambre'] = numberChambre,
	}, function(result)
		SetPlayerRoutingBucket(xPlayer.source, id)
	end)

	MySQL.Async.execute("UPDATE users SET chambreNumero = @chambreNumero, motelName = @motelName WHERE identifier = @identifier", {
		["@identifier"] = xPlayer.identifier,
		["@chambreNumero"] = idmotel,
		["@motelName"] = nameMotel
	})
end)

RegisterNetEvent('pawal:leavemotel')
AddEventHandler('pawal:leavemotel', function()
	SetPlayerRoutingBucket(source, 0)
	MySQL.Async.execute("UPDATE users SET chambreNumero = @chambreNumero, motelName = @motelName WHERE identifier = @identifier", {
		["@identifier"] = xPlayer.identifier,
		["@chambreNumero"] = -1,
		["@motelName"] = nil
	})
end)

RegisterNetEvent('pawal:saveparking')
AddEventHandler('pawal:saveparking', function(vehicle, plate, labelMotel, numeroPlace)
	local xPlayer = ESX.GetPlayerFromId(source)
	local numeroChambre = nil
	MySQL.Async.fetchAll('SELECT * FROM motel WHERE labelMotel = @labelMotel and owner = @owner', {
		['@owner'] = xPlayer.identifier,
		['@labelMotel'] = labelMotel
	}, function(result)
		if result[1] ~= nil then
			numeroChambre = result[1].numberChambre
		else
			MySQL.Async.fetchAll('SELECT * FROM motel_key WHERE labelMotel = @labelMotel and owner = @owner', {
				['@owner'] = xPlayer.identifier,
				['@labelMotel'] = labelMotel
			}, function(resultcoproprio)
				numeroChambre = resultcoproprio[1].numberChambre
			end)
		end
	end)

	while numeroChambre == nil do
		Wait(0)
	end

	MySQL.Async.execute("INSERT INTO motel_parking (owner, labelMotel, vehicle, plate, numeroPlace, numeroChambre) VALUES (@owner, @labelMotel, @vehicle, @plate, @numeroPlace, @numeroChambre)", 	
	{
		["@owner"] = xPlayer.identifier,
		["@labelMotel"] = labelMotel,
		["@plate"] = plate,
		["@vehicle"] = json.encode(vehicle),
		["@numeroPlace"] = numeroPlace,
		["@numeroChambre"] = numeroChambre,
	})

	Wait(100)

	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:refreshparking', playerId)
	end
end)

RegisterNetEvent('pawal:deleteparking')
AddEventHandler('pawal:deleteparking', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute("DELETE from motel_parking WHERE plate = @plate", 	
	{
		["@plate"] = plate,
	})

	Wait(100)

	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('pawal:deletecar_motel', playerId, plate)
		TriggerClientEvent('pawal:refreshparkingnodelete', playerId)
	end
end)

ESX.RegisterServerCallback("pawal:verifplace_motel", function(source, cb, labelMotel, numeroPlace)
	local xPlayer = ESX.GetPlayerFromId(source)
	local numeroChambre = nil
	MySQL.Async.fetchAll('SELECT * FROM motel WHERE labelMotel = @labelMotel and owner = @owner', {
		['@owner'] = xPlayer.identifier,
		['@labelMotel'] = labelMotel
	}, function(result)
		if result[1] then
			if result[1].owner == xPlayer.identifier then
				numeroChambre = result[1].numberChambre
			else
				MySQL.Async.fetchAll('SELECT * FROM motel_key WHERE labelMotel = @labelMotel and owner = @owner', {
					['@labelMotel'] = labelMotel,
					["@owner"] = xPlayer.identifier
				}, function(resultcoowner)
					numeroChambre = resultcoowner[1].numberChambre
				end)
			end
		end
	end)

	while numeroChambre == nil do 
		Wait(1)
	end

	MySQL.Async.fetchAll('SELECT * FROM motel_parking WHERE labelMotel = @labelMotel and numeroChambre = @numeroChambre', {
		['@labelMotel'] = labelMotel,
		["@numeroChambre"] = numeroChambre
	}, function(parkingresult)
		if parkingresult[1] == nil then
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback("pawal:verifownercar", function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner and plate = @plate', {
		["@owner"] = xPlayer.identifier,
		["@plate"] = plate
	}, function(result)
		if result[1] ~= nil then
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback("pawal:getdataparking", function(source, cb, nameMotel, numberChambre)
    local xPlayer = ESX.GetPlayerFromId(source)
	local tableCar = {}
	MySQL.Async.fetchAll('SELECT * FROM motel_parking', {
	}, function(result)
		for k, v in pairs(result) do
			local vehicles = json.decode(v.vehicle)
			table.insert(tableCar, {vehicle = vehicles, owner = v.owner, plate = v.plate, id = v.id, numeroPlace = v.numeroPlace, labelMotel = v.labelMotel})
		end
        cb(tableCar)
    end)
end)

RegisterServerEvent('pawal:depotcoffre_motel')
AddEventHandler('pawal:depotcoffre_motel', function(itemName, count, motelName, chambreNumber)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	TriggerEvent('esx_addoninventory:getSharedInventory', motelName.." N°"..chambreNumber, function(inventory)
        local inventoryItem = inventory.getItem(itemName)

		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			Config.customservernotif(xPlayer.source, translate["success_deposit_item"]..""..count.." "..inventoryItem.label..' '..translate["success_deposit_weapon_property"])
		else
			Config.customservernotif(xPlayer.source, translate["no_require_item"])
		end
	end)
end)

RegisterServerEvent('pawal:retraitcoffre_motel')
AddEventHandler('pawal:retraitcoffre_motel', function(itemName, count, motelName, chambreNumber)
	local xPlayer = ESX.GetPlayerFromId(source)
	local date = os.date('*t')

	TriggerEvent('esx_addoninventory:getSharedInventory', motelName.." N°"..chambreNumber, function(inventory)
        local inventoryItem = inventory.getItem(itemName)

			xPlayer.addInventoryItem(itemName, count)
			inventory.removeItem(itemName, count)
			Config.customservernotif(xPlayer.source, translate["success_take_item"]..""..count.." "..inventoryItem.label.." "..translate["success_take_item_property"])

	end)
end)


ESX.RegisterServerCallback('pawal:playerinventory_motel', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)
end)

RegisterServerEvent('pawal:verifinmotel')
AddEventHandler('pawal:verifinmotel', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(data)
			if data[1].chambreNumero ~= -1 then
				TriggerClientEvent('pawal:tpplayerafterdeconnexion_motel', xPlayer.source, vector3(Config.motel[data[1].motelName].point[tonumber(data[1].chambreNumero)].pos.x, Config.motel[data[1].motelName].point[tonumber(data[1].chambreNumero)].pos.y, Config.motel[data[1].motelName].point[tonumber(data[1].chambreNumero)].pos.z))
				MySQL.Async.execute("UPDATE users SET chambreNumero = @chambreNumero, motelName = @motelName WHERE identifier = @identifier", {
					["@identifier"] = xPlayer.identifier,
					["@chambreNumero"] = -1,
					["@motelName"] = nil
				})
			end
		end)
	end
end)

RegisterServerEvent("pawal:sonnermotel")
AddEventHandler("pawal:sonnermotel", function(numeroChambre, motelLabel, interior)
	xPlayer = ESX.GetPlayerFromId(source)
	minimumReponse = 0
	MySQL.Async.fetchAll("SELECT * FROM motel WHERE numberChambre = @numberChambre AND labelMotel = @labelMotel", {
		["@numberChambre"] = numeroChambre,
		["@labelMotel"] = motelLabel,
	}, function(sonette)
		xTarget = ESX.GetPlayerFromIdentifier(sonette[1].owner)
		
		if xTarget ~= nil then
			TriggerClientEvent('pawal:notificationmotel', xPlayer.source, motelLabel.." N°"..numeroChambre, translate.doorbell_response["wait_response"], translate.doorbell_response["wait_response_style"])
			TriggerClientEvent('pawal:sonettemotel', xTarget.source, xPlayer.identifier, motelLabel, numeroChambre, interior, xPlayer.identifier)

			if minimumReponse == 0 then
				minimumReponse = 1
			end
		end
	end)

	MySQL.Async.fetchAll("SELECT * FROM motel WHERE numberChambre = @numberChambre AND labelMotel = @labelMotel", {
		["@numberChambre"] = numeroChambre,
		["@labelMotel"] = motelLabel,
	}, function(sonette)
		for k,v in pairs(sonette) do
			xTarget = ESX.GetPlayerFromIdentifier(v.identifier)
			if xTarget ~= nil then
				TriggerClientEvent('pawal:notificationmotel', xPlayer.source, motelLabel.." N°"..numeroChambre, translate.doorbell_response["wait_response"], translate.doorbell_response["wait_response_style"])
				TriggerClientEvent('pawal:sonettemotel', xTarget.source, xPlayer.identifier, motelLabel, numeroChambre, interior, xPlayer.identifier)

				if minimumReponse == 0 then
					minimumReponse = 1
				end
			end
		end
	end)

	Wait(100)

	if minimumReponse == 0 then
		TriggerClientEvent('pawal:notificationmotel', xPlayer.source, motelLabel.." N°"..numeroChambre, translate.doorbell_response["no_proprio"], translate.doorbell_response["no_proprio_style"])
	end
end)

RegisterServerEvent("pawal:sendnorespond")
AddEventHandler("pawal:sendnorespond", function(identifier, motel, chambre)
	xTarget = ESX.GetPlayerFromIdentifier(identifier)

	TriggerClientEvent('pawal:notificationmotel', xTarget.source, motel.." N°"..chambre, translate.doorbell_response["message"], translate.doorbell_response["style"])
end)

RegisterServerEvent("pawal:stopdemande")
AddEventHandler("pawal:stopdemande", function(motelLabel, numeroChambre)
	xTarget = ESX.GetPlayerFromIdentifier(identifier)

	MySQL.Async.fetchAll("SELECT * FROM motel WHERE numberChambre = @numberChambre AND labelMotel = @labelMotel", {
		["@numberChambre"] = numeroChambre,
		["@labelMotel"] = motelLabel,
	}, function(sonette)
		for k,v in pairs(sonette) do
			xTarget = ESX.GetPlayerFromIdentifier(v.identifier)
			if xTarget ~= nil then
				TriggerClientEvent('pawal:stopdemande', xTarget.source)
			end
		end 
	end)
end)


RegisterServerEvent("pawal:acceptersonette_motel")
AddEventHandler("pawal:acceptersonette_motel", function(identifier, numberChambreSonette, nameMotel, interior)
	xTarget = ESX.GetPlayerFromIdentifier(identifier)
	TriggerClientEvent('pawal:entryplayer_motel', xTarget.source, numberChambreSonette, nameMotel, interior)
end)

ESX.RegisterServerCallback("pawal:getkey", function(source, cb, nameMotel, numberChambre)
	local tableKey = {}
	MySQL.Async.fetchAll('SELECT * FROM motel_key WHERE labelMotel = @labelMotel AND numberChambre = @numberChambre', {
		['@labelMotel'] = nameMotel,
		['@numberChambre'] = numberChambre,
	}, function(result)
		for k,v in pairs(result) do
			table.insert(tableKey, {identifier = v.identifier, labelMotel = v.labelMotel, numberChambre = v.numberChambre, name = v.playerName})
		end
		cb(tableKey)
	end)
end)

ESX.RegisterServerCallback('pawal:getname_motel', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(id)
	local identifier = xPlayer.getIdentifier()
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM `users` WHERE identifier = @identifier', {
		['@identifier'] = identifier
	})

	local string = result[1].firstname.." "..result[1].lastname

	cb(string)
end)

RegisterServerEvent("pawal:addkey")
AddEventHandler("pawal:addkey", function(id, numberChambre, nameMotel)
	local xTarget = ESX.GetPlayerFromId(id)
	local nametarget = ""
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['identifier'] = xTarget.identifier
	}, function(data)
		for _,v in pairs(data) do
		   nametarget = v.firstname.." "..v.lastname
		end
	end)

	Wait(150)

	MySQL.Async.execute("INSERT INTO motel_key (identifier, labelMotel, numberChambre, playerName) VALUES (@identifier, @labelMotel, @numberChambre, @playerName)", 	
	{
		["@identifier"] = xTarget.identifier,
		["@labelMotel"] = nameMotel,
		["@numberChambre"] = numberChambre,
		["@playerName"] = nametarget,
	})

	TriggerClientEvent("pawal:notificationmotel", xTarget.source, nameMotel.." N°"..numberChambre, translate.add_key_target["message"], translate.add_key_target["style"])
end)

RegisterNetEvent('pawal:deletekey_motel')
AddEventHandler('pawal:deletekey_motel', function(chambre, motel, name, identifier)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)

	MySQL.Async.execute("DELETE from motel_key WHERE labelMotel = @labelMotel AND numberChambre = @numberChambre AND playerName = @playerName", 	
	{
		["@labelMotel"] = motel,
		["@numberChambre"] = chambre,
		["@playerName"] = name
	})

	Wait(100)

	TriggerClientEvent("pawal:notificationmotel", xTarget.source, translate.delete_key["title"], translate.delete_key["message_1"]..""..chambre.." "..translate.delete_key["message_2"].." "..motel, translate.delete_key["style"])
end) 

ESX.RegisterServerCallback('pawal:récupérationstockitemmotel', function(source, cb, society)
	local motelitem = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(motelitem, {label = v.label, item = v.name, nb = v.count})
			end
		end

	end)
	cb(motelitem)
end)

RegisterNetEvent('pawal:createinventory_pawal')
AddEventHandler('pawal:createinventory_pawal', function(chambre, motel)
	MySQL.Async.fetchAll("SELECT * FROM addon_inventory WHERE name = @name", {['name'] = motel.." N°"..chambre}, function(data)
		if data[1] == nil then
			MySQL.Async.execute("INSERT INTO addon_inventory (name, label, shared) VALUES (@name, @label, @shared)", 	
			{
				['@name'] = motel.." N°"..chambre,
				['@label'] = "motel", 
				['@shared'] = 1
			})

			Wait(200)

			TriggerEvent("esx_addoninventory:refreshAddonInventory")
		end
	end)
end)

RegisterServerEvent("pawal:sauvegardetenue_motel")
AddEventHandler("pawal:sauvegardetenue_motel", function(tenuelabel, skinsave, motelname, sexe)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM motel_outfit WHERE `tenuename` = @tenuename AND `motelname` = @motelname ", {
        ["@tenuename"] = tenuelabel,
		["@identifier"] = xPlayer.identifier,
		["@motelname"] = motelname,
    }, function(data)
        if data[1] == nil then
		MySQL.Async.execute("INSERT INTO motel_outfit (tenuename, skin, sexe, motelname) VALUES (@tenuename, @skin, @sexe, @motelname)", 	
		{
			['@tenuename'] = tenuelabel,
			['@skin'] = json.encode(skinsave), 
			['@sexe'] = sexe,
			['@motelname'] = motelname,
		}, function()
			Config.customservernotif(source, translate["save_outfit_notif"])
			Wait(100)

			for _, playerId in ipairs(GetPlayers()) do
				TriggerClientEvent('pawal:refreshoutfit', playerId)
			end
        end)
    else
		Config.customservernotif(source, translate["name_already_save"])
	end
 end)
end)

ESX.RegisterServerCallback("pawal:getclothes_motel", function(source, cb, namemotelchambre)
	local tableclothes = {}
	MySQL.Async.fetchAll("SELECT * FROM motel_outfit WHERE motelname = @motelname", {
		["@motelname"] = namemotelchambre,
	}, function(data)
		for k,v in pairs(data) do
			table.insert(tableclothes, {tenuename = v.tenuename, id = v.id, skin = json.decode(v.skin), sexe = v.sexe})
		end
		cb(tableclothes)
	end)
end)

RegisterNetEvent('pawal:renameoutfit_motel')
AddEventHandler('pawal:renameoutfit_motel', function(rename, idoutfit, idforchange)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()

	MySQL.Async.execute("UPDATE motel_outfit SET tenuename = @tenuename WHERE motelName = @motelName AND id = @id", {
		["@tenuename"] = rename,
		["@motelName"] = idoutfit,
		["@id"] = idforchange
	})
end)

RegisterNetEvent('pawal:deleteoutfit_motel')
AddEventHandler('pawal:deleteoutfit_motel', function(idoutfit)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('DELETE from motel_outfit WHERE id = @id', {
		['@id'] = idoutfit,
	})  
end)

RegisterServerEvent("pawal:applicationskin_motel")
AddEventHandler("pawal:applicationskin_motel", function(skinselection)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute("UPDATE users SET `skin`= @skin WHERE identifier = @identifier", {
		["@skin"] = json.encode(skinselection),
		["@identifier"] = xPlayer.identifier
	}, function()
    end)
end)

RegisterServerEvent('pawal:startraid_motel')
AddEventHandler('pawal:startraid_motel', function(label, chambre)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute("UPDATE motel SET `openhouse` = @openhouse WHERE labelMotel = @labelMotel and numberChambre = @numberChambre", {
		["@labelMotel"] = label,
		["@numberChambre"] = chambre,
		["@openhouse"] = true,
	})

	Wait(110)

	Wait(Config.TimeForRaid*1000*60)

	MySQL.Async.execute("UPDATE motel SET `openhouse` = @openhouse WHERE labelMotel = @labelMotel and numberChambre = @numberChambre", {
		["@labelMotel"] = label,
		["@numberChambre"] = chambre,
		["@openhouse"] = false,
	})
end)

RegisterServerEvent('pawal:checkrent')
AddEventHandler('pawal:checkrent', function()
	MySQL.Async.fetchAll('SELECT * FROM motel', {
	}, function(result)
		for k,v in pairs(result) do
			if v.day >= 1 then
				MySQL.Async.execute("UPDATE motel SET `day` = @day WHERE id = @id", {
					["@id"] = v.id,
					["@numberChambre"] = day - 1,
					["@openhouse"] = false,
				})
			else
				MySQL.Async.execute('DELETE from motel WHERE id = @id', {
					['@id'] = v.id,
				})  
				MySQL.Async.execute('DELETE from motel_outfit WHERE motelname = @motelname', {
					['@motelname'] = v.labelMotel.." N°"..v.numberChambre,
				})  
				MySQL.Async.execute('DELETE from motel_outfit WHERE motelname = @motelname', {
					['@motelname'] = v.labelMotel.." N°"..v.numberChambre,
				})  
				MySQL.Async.execute('DELETE from motel_parking WHERE motelname = @motelname', {
					['@labelMotel'] = v.labelMotel,
					['@numeroChambre'] = v.numberChambre
				})  
			end
		end
    end)
end)

function CronTask(d, h, m)	
	TriggerEvent('pawal:checkrent')
end
  
TriggerEvent('cron:runAt', Config.location.heure, Config.location.minute, CronTask)