Config = {

-- ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗     
--██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║     
--██║  ███╗██║     ██║   ██║██████╔╝███████║██║     
--██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║     
--╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗
-- ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

framework = "newesx", -- esx ou newesx (newesx = nouveau export)        
jobname = "mechanic",
Banniere =  { -- Changer la bannière des différents menu RageUI
    ytdname = "mechanicmenu",
    nameimage = "mechanic_banner"
},
Devise = "$",
staff = {"admin", "superadmin"}, -- Grade staff pour commande
interact = "3dtext", -- 3dtext, esx
notification = "ESX", -- ESX, ox_lib, custom
notificationCustom = function(title, message, statut)
end,
customservernotif = function(source, message, statut)
    TriggerClientEvent('esx:showNotification', source, message)
end,

progressbar = "ox", -- ox, custom
progressbarcustom = function(message, time)
end, 

getproperties = function(vehicle) -- Edit if you use other function
    return ESX.Game.GetVehicleProperties(vehicle)
end,

setproperties = function(vehicle, props) -- Edit if you use other function
    return ESX.Game.SetVehicleProperties(vehicle, props)
end,

getclossetvehicle = function(coords) -- Edit if you use other function
    return ESX.Game.GetClosestVehicle(coords)
end,

advancednotif = "ESX", -- ESX or custom
customadvancednotif = function(title, soustitre, message, img, iconright)
    -- Custom code
end,

--██████╗  ██████╗ ██╗     ██╗ ██████╗███████╗
--██╔══██╗██╔═══██╗██║     ██║██╔════╝██╔════╝
--██████╔╝██║   ██║██║     ██║██║     █████╗  
--██╔═══╝ ██║   ██║██║     ██║██║     ██╔══╝  
--██║     ╚██████╔╝███████╗██║╚██████╗███████╗
--╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝╚══════╝
                   
policejobname = {"police"},
itemForOpenHouse = "police_stormram",
TimeForRaid = 1, -- Temps en minute pour le RAID police

--	███╗   ███╗ █████╗ ██████╗ ██╗  ██╗███████╗██████╗     ██████╗  ██████╗ ██╗███╗   ██╗████████╗
--	████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝
--	██╔████╔██║███████║██████╔╝█████╔╝ █████╗  ██████╔╝    ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   
--	██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗ ██╔══╝  ██╔══██╗    ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   
--	██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗███████╗██║  ██║    ██║     ╚██████╔╝██║██║ ╚████║   ██║   
--	╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝   
		
drawdistance = 3.0, -- Distance d'affichage des markers
MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
MarkerSizeLargeur = 0.2, -- Largeur du marker
MarkerSizeEpaisseur = 0.2, -- Épaisseur du marker
MarkerSizeHauteur = 0.2, -- Hauteur du marker
MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorG = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
MarkerSaute = false, -- Si le marker saute (true = oui, false = non)
MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)

--██████╗ ██████╗ ███████╗███████╗██████╗ ███████╗
--██╔════╝██╔═══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
--██║     ██║   ██║█████╗  █████╗  ██████╔╝█████╗  
--██║     ██║   ██║██╔══╝  ██╔══╝  ██╔══██╗██╔══╝  
--╚██████╗╚██████╔╝██║     ██║     ██║  ██║███████╗
-- ╚═════╝ ╚═════╝ ╚═╝     ╚═╝     ╚═╝  ╚═╝╚══════╝
Coffre = "ox_inventory", -- pw-motel, ox_inventory, custom                                             
customcoffre = function(motelName, chambreNumber, poid, slots)
end,

--██╗   ██╗███████╗███████╗████████╗██╗ █████╗ ██╗██████╗ ███████╗
--██║   ██║██╔════╝██╔════╝╚══██╔══╝██║██╔══██╗██║██╔══██╗██╔════╝
--██║   ██║█████╗  ███████╗   ██║   ██║███████║██║██████╔╝█████╗  
--╚██╗ ██╔╝██╔══╝  ╚════██║   ██║   ██║██╔══██║██║██╔══██╗██╔══╝  
-- ╚████╔╝ ███████╗███████║   ██║   ██║██║  ██║██║██║  ██║███████╗
--  ╚═══╝  ╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝                                                         
Vestiaire = "pw-motel", -- pw-motel, custom     
customvestiaire = function(motelName, chambreNumber)
end,

--██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
--██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
--██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
--██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
--███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
--╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                
location = {heure = 01, minute = 15}, -- Heure et minute pour la location (si locationtype = jour : Tout les jours à 01h15, si par semaine alors Lundi 01h15)

--███████╗ ██████╗ ███╗   ██╗███████╗████████╗████████╗███████╗
--██╔════╝██╔═══██╗████╗  ██║██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝
--███████╗██║   ██║██╔██╗ ██║█████╗     ██║      ██║   █████╗  
--╚════██║██║   ██║██║╚██╗██║██╔══╝     ██║      ██║   ██╔══╝  
--███████║╚██████╔╝██║ ╚████║███████╗   ██║      ██║   ███████╗
--╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝      ╚═╝   ╚══════╝
                                                             
toucheaccepter = 246, -- https://docs.fivem.net/docs/game-references/controls/
toucherefuser = 73, -- https://docs.fivem.net/docs/game-references/controls/

--███╗   ███╗ ██████╗ ████████╗███████╗██╗     
--████╗ ████║██╔═══██╗╚══██╔══╝██╔════╝██║     
--██╔████╔██║██║   ██║   ██║   █████╗  ██║     
--██║╚██╔╝██║██║   ██║   ██║   ██╔══╝  ██║     
--██║ ╚═╝ ██║╚██████╔╝   ██║   ███████╗███████╗
--╚═╝     ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚══════╝

maxlocationtime = 50, -- Temps maximum de location (en jour)
motel = {
    ["Perrera Beach"] = {
        label = "Perrera Beach",
        prix = 500, -- Prix (pour 1 jour)
        rayonChargement = 30.0, -- chargement véhicule

        point = {
            {numberChambre = 1, pos = vector3(-1493.7526855469, -668.36608886719, 29.025087356567), interior = "motel_interior_gta"},
            {numberChambre = 2, pos = vector3(-1498.1838378906, -664.70208740234, 29.025077819824), interior = "motel_interior_gta"},
            {numberChambre = 3, pos = vector3(-1495.3568115234, -661.59478759766, 29.025077819824), interior = "motel_interior_gta"},
            {numberChambre = 4, pos = vector3(-1490.7685546875, -658.23822021484, 29.025102615356), interior = "motel_interior_gta"},
            {numberChambre = 5, pos = vector3(-1486.7805175781, -655.37036132812, 29.583099365234), interior = "motel_interior_gta"},
            {numberChambre = 6, pos = vector3(-1482.1818847656, -652.00628662109, 29.583070755005), interior = "motel_interior_gta"},
            {numberChambre = 7, pos = vector3(-1478.2158203125, -649.14489746094, 29.583065032959), interior = "motel_interior_gta"},
            {numberChambre = 8, pos = vector3(-1473.6524658203, -645.80444335938, 29.583061218262), interior = "motel_interior_gta"},
            {numberChambre = 9, pos = vector3(-1469.6517333984, -642.91931152344, 29.583051681519), interior = "motel_interior_gta"},
            {numberChambre = 10, pos = vector3(-1465.0821533203, -639.57836914062, 29.583057403564), interior = "motel_interior_gta"},
            {numberChambre = 11, pos = vector3(-1461.2578125, -640.85162353516, 29.583116531372), interior = "motel_interior_gta"},
            {numberChambre = 12, pos = vector3(-1452.3636474609, -653.24078369141, 29.583162307739), interior = "motel_interior_gta"},
            {numberChambre = 13, pos = vector3(-1454.3596191406, -655.97192382812, 29.583068847656), interior = "motel_interior_gta"},
            {numberChambre = 14, pos = vector3(-1458.9783935547, -659.32116699219, 29.583072662354), interior = "motel_interior_gta"},
            {numberChambre = 15, pos = vector3(-1462.9605712891, -662.18121337891, 29.58304977417), interior = "motel_interior_gta"},
            {numberChambre = 16, pos = vector3(-1467.5443115234, -665.56091308594, 29.583068847656), interior = "motel_interior_gta"},
            {numberChambre = 17, pos = vector3(-1471.5440673828, -668.43188476562, 29.58310508728), interior = "motel_interior_gta"},
            {numberChambre = 18, pos = vector3(-1461.4466552734, -641.04138183594, 33.381278991699), interior = "motel_interior_gta"},
            {numberChambre = 19, pos = vector3(-1457.9169921875, -645.51135253906, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 20, pos = vector3(-1455.7144775391, -648.61907958984, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 21, pos = vector3(-1452.4758300781, -653.28991699219, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 22, pos = vector3(-1454.3957519531, -655.94274902344, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 23, pos = vector3(-1458.9349365234, -659.306640625, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 24, pos = vector3(-1462.9197998047, -662.19567871094, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 25, pos = vector3(-1467.4963378906, -665.52661132812, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 26, pos = vector3(-1471.5496826172, -668.35791015625, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 27, pos = vector3(-1476.1104736328, -671.78741455078, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 28, pos = vector3(-1465.0225830078, -639.6279296875, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 29, pos = vector3(-1469.6844482422, -642.98028564453, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 30, pos = vector3(-1473.6087646484, -645.89428710938, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 31, pos = vector3(-1478.1693115234, -649.13256835938, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 32, pos = vector3(-1482.1856689453, -652.02593994141, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 33, pos = vector3(-1486.7845458984, -655.33978271484, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 34, pos = vector3(-1490.7691650391, -658.24621582031, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 35, pos = vector3(-1495.3035888672, -661.55456542969, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 36, pos = vector3(-1498.09765625, -664.70208740234, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 37, pos = vector3(-1493.7482910156, -668.29449462891, 33.381233215332), interior = "motel_interior_gta"},
            {numberChambre = 38, pos = vector3(-1489.8967285156, -671.46429443359, 33.381233215332), interior = "motel_interior_gta"},

        },

        parking = {
            [1] = {numeroPlace = 1, pos = vector4(-1465.8736572266, -648.57299804688, 28.502359390259, 35.465637207031)},
            [2] = {numeroPlace = 2, pos = vector4(-1468.5673828125, -650.68310546875, 28.502359390259, 35.365280151367)},
            [3] = {numeroPlace = 3, pos = vector4(-1471.4069824219, -652.77709960938, 28.502359390259, 33.284191131592)},
            [4] = {numeroPlace = 4, pos = vector4(-1480.69140625, -659.38067626953, 27.943101882935, 34.877182006836)},
            [5] = {numeroPlace = 5, pos = vector4(-1483.3583984375, -661.61444091797, 27.943101882935, 33.911701202393)},
            [6] = {numeroPlace = 6, pos = vector4(-1486.0798339844, -663.67919921875, 27.943101882935, 35.971187591553)},
            [7] = {numeroPlace = 7, pos = vector4(-1478.0093994141, -657.19848632812, 27.943103790283, 35.641357421875)}
        },

        blip = {
            name = "Perrera Beach",
            pos = vector3(-1472.8034667969, -658.85137939453, 29.10848236084), -- permet également de définir la zone radius pour le check distance 
            taille = 0.7,
            couleur = 47,
            type = 475, -- https://docs.fivem.net/docs/game-references/blips/
        }
    },
    ["The Pink Cage"] = {
        label = "The Pink Cage",
        prix = 500, -- Prix (pour 1 jour)
        rayonChargement = 30.0, -- chargement véhicule

        point = {
            {numberChambre = 1, pos = vector3(312.8542175293, -218.85621643066, 54.221752166748), interior = "motel_interior_gta"},
            {numberChambre = 2, pos = vector3(311.01126098633, -218.04365539551, 54.221752166748), interior = "motel_interior_gta"},
            {numberChambre = 3, pos = vector3(307.44882202148, -216.67936706543, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 4, pos = vector3(307.4748840332, -213.26870727539, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 5.1, pos = vector3(309.50350952148, -207.97537231445, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 5.2, pos = vector3(311.31414794922, -203.45286560059, 54.221752166748), interior = "motel_interior_gta"},
            {numberChambre = 6, pos = vector3(313.33901977539, -198.13711547852, 54.221755981445), interior = "motel_interior_gta"},
            {numberChambre = 7, pos = vector3(315.74713134766, -194.9027557373, 54.226421356201), interior = "motel_interior_gta"},
            {numberChambre = 8, pos = vector3(319.40469360352, -196.30694580078, 54.226425170898), interior = "motel_interior_gta"},
            {numberChambre = 9, pos = vector3(321.36053466797, -197.09225463867, 54.226417541504), interior = "motel_interior_gta"},
            {numberChambre = 11, pos = vector3(312.89727783203, -218.8134765625, 58.019268035889), interior = "motel_interior_gta"},
            {numberChambre = 12, pos = vector3(310.86157226562, -218.08692932129, 58.019268035889), interior = "motel_interior_gta"},
            {numberChambre = 13, pos = vector3(307.29446411133, -216.74952697754, 58.019268035889), interior = "motel_interior_gta"},
            {numberChambre = 14, pos = vector3(307.57760620117, -213.29580688477, 58.019260406494), interior = "motel_interior_gta"},
            {numberChambre = 15, pos = vector3(309.50927734375, -207.96493530273, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 16, pos = vector3(311.26324462891, -203.36865234375, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 17, pos = vector3(313.33209228516, -198.0694732666, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 18, pos = vector3(315.84268188477, -194.87648010254, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 19, pos = vector3(319.39114379883, -196.13488769531, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 20, pos = vector3(321.44808959961, -196.9326171875, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 21, pos = vector3(329.38946533203, -225.16186523438, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 22, pos = vector3(331.32427978516, -225.97328186035, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 23, pos = vector3(334.89584350586, -227.36682128906, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 24, pos = vector3(337.17706298828, -224.78677368164, 54.221759796143), interior = "motel_interior_gta"},
            {numberChambre = 25, pos = vector3(339.18350219727, -219.46426391602, 54.22176361084), interior = "motel_interior_gta"},
            {numberChambre = 26, pos = vector3(340.98565673828, -214.91131591797, 54.22176361084), interior = "motel_interior_gta"},
            {numberChambre = 27, pos = vector3(343.00738525391, -209.57469177246, 54.22176361084), interior = "motel_interior_gta"},
            {numberChambre = 28, pos = vector3(344.73870849609, -205.03163146973, 54.22184753418), interior = "motel_interior_gta"},
            {numberChambre = 29, pos = vector3(346.80453491211, -199.72778320312, 54.221836090088), interior = "motel_interior_gta"},

            {numberChambre = 30, pos = vector3(329.37466430664, -225.18692016602, 58.019268035889), interior = "motel_interior_gta"},
            {numberChambre = 31, pos = vector3(331.34185791016, -225.9400177002, 58.019264221191), interior = "motel_interior_gta"},
            {numberChambre = 32, pos = vector3(334.97061157227, -227.33673095703, 58.019264221191), interior = "motel_interior_gta"},
            {numberChambre = 33, pos = vector3(337.15234375, -224.84590148926, 58.019264221191), interior = "motel_interior_gta"},
            {numberChambre = 34, pos = vector3(339.21002197266, -219.50506591797, 58.019264221191), interior = "motel_interior_gta"},
            {numberChambre = 35, pos = vector3(340.98132324219, -214.92094421387, 58.019264221191), interior = "motel_interior_gta"},
            {numberChambre = 36, pos = vector3(342.99273681641, -209.67478942871, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 37, pos = vector3(344.75100708008, -205.0415802002, 58.019256591797), interior = "motel_interior_gta"},
            {numberChambre = 39, pos = vector3(346.81372070312, -199.72566223145, 58.019256591797), interior = "motel_interior_gta"},

        },

        parking = {
            [1] = {numeroPlace = 1, pos = vector4(337.47750854492, -207.39077758789, 53.086334228516, 250.30918884277344)},
            [2] = {numeroPlace = 2, pos = vector4(336.36251831055,-210.6570892334,53.086334228516, 250.30918884277344)},
            [3] = {numeroPlace = 3, pos = vector4(335.21588134766,-213.88352966309,53.086334228516, 250.30918884277344)},
            [4] = {numeroPlace = 4, pos = vector4(334.04739379883,-217.04737854004,53.086334228516, 250.30918884277344)},

            [5] = {numeroPlace = 5, pos = vector4(314.92712402344,-209.41325378418,53.086326599121, 67.58566284179688)},
            [6] = {numeroPlace = 6, pos = vector4(316.08392333984,-206.15226745605,53.086326599121, 67.58566284179688)},
            [7] = {numeroPlace = 7, pos = vector4(317.50619506836,-203.015625,53.086326599121, 67.58566284179688)},
            [8] = {numeroPlace = 8, pos = vector4(318.55587768555,-199.68998718262,53.086326599121, 67.58566284179688)},

        },

        blip = {
            name = "The Pink Cage",
            pos = vector3(325.99954223633, -211.15147399902, 54.086315155029), -- permet également de définir la zone radius pour le check distance 
            taille = 0.7,
            couleur = 47,
            type = 475, -- https://docs.fivem.net/docs/game-references/blips/
        }
    },
    ["Bilingsgate"] = {
        label = "Bilingsgate",
        prix = 500, -- Prix (pour 1 jour)
        rayonChargement = 30.0, -- chargement véhicule

        point = {
            {numberChambre = 1, pos = vector3(566.17938232422, -1778.1641845703, 29.352727890015), interior = "motel_interior_gta"},
            {numberChambre = 2, pos = vector3(550.31408691406, -1775.5224609375, 29.312168121338), interior = "motel_interior_gta"},
            {numberChambre = 3, pos = vector3(552.20208740234, -1771.5200195312, 29.312152862549), interior = "motel_interior_gta"},
            {numberChambre = 4, pos = vector3(554.64996337891, -1766.2596435547, 29.312213897705), interior = "motel_interior_gta"},
            {numberChambre = 5, pos = vector3(557.70245361328, -1759.6428222656, 29.312959671021), interior = "motel_interior_gta"},
            {numberChambre = 6, pos = vector3(561.38104248047, -1751.7921142578, 29.279989242554), interior = "motel_interior_gta"},
            {numberChambre = 7, pos = vector3(560.14617919922, -1777.1748046875, 33.442649841309), interior = "motel_interior_gta"},
            {numberChambre = 8, pos = vector3(559.09484863281, -1777.3505859375, 33.442642211914), interior = "motel_interior_gta"},
            {numberChambre = 10, pos = vector3(550.09429931641, -1770.5540771484, 33.442638397217), interior = "motel_interior_gta"},
            {numberChambre = 11, pos = vector3(552.59997558594, -1765.2429199219, 33.442638397217), interior = "motel_interior_gta"},
            {numberChambre = 12, pos = vector3(555.59649658203, -1758.6385498047, 33.442638397217), interior = "motel_interior_gta"},
            {numberChambre = 14, pos = vector3(559.30419921875, -1750.8056640625, 33.44263458252), interior = "motel_interior_gta"},
            {numberChambre = 15, pos = vector3(561.74822998047, -1747.3820800781, 33.442626953125), interior = "motel_interior_gta"},
        },

        parking = {
            [1] = {numeroPlace = 1, pos = vector4(567.46063232422,-1799.1456298828,28.19141960144, 170.94927978515625)},
            [2] = {numeroPlace = 2, pos = vector4(564.3515625,-1798.9758300781,28.197021484375, 170.55581665039065)},
            [3] = {numeroPlace = 3, pos = vector4(561.38159179688,-1798.51953125,28.197008132935, 170.13568115234375)},
            [4] = {numeroPlace = 4, pos = vector4(558.32775878906,-1798.2392578125,28.197008132935, 173.0900115966797)},
            [5] = {numeroPlace = 5, pos = vector4(555.26495361328,-1797.7358398438,28.197008132935, 171.69129943847656)},
            [6] = {numeroPlace = 6, pos = vector4(552.26300048828,-1797.2619628906,28.197008132935, 169.94747924804688)},
            [7] = {numeroPlace = 7, pos = vector4(549.18328857422,-1796.6613769531,28.197008132935, 171.4668426513672)},
            [8] = {numeroPlace = 8, pos = vector4(545.06909179688,-1794.8894042969,28.197008132935, 171.4668426513672)},
            [9] = {numeroPlace = 9, pos = vector4(561.22625732422,-1789.0035400391,28.19701385498, 334.08636474609375)},
            [10] = {numeroPlace = 10, pos = vector4(558.44738769531,-1787.9197998047,28.197010040283, 335.0255126953125)},
            [11] = {numeroPlace = 11, pos = vector4(555.55810546875,-1786.83203125,28.197008132935, 335.1949462890625)},
            [12] = {numeroPlace = 12, pos = vector4(545.01702880859,-1781.7662353516,28.116483688354, 334.5682373046875)},
            [13] = {numeroPlace = 12, pos = vector4(542.09252929688,-1780.5863037109,27.972156524658, 334.2138366699219)},
        },

        blip = {
            name = "Bilingsgate",
            pos = vector3(565.72650146484, -1762.9282226562, 29.168972015381), -- permet également de définir la zone radius pour le check distance 
            taille = 0.7,
            couleur = 47,
            type = 475, -- https://docs.fivem.net/docs/game-references/blips/
        }
    },
    ["The Motor"] = {
        label = "The Motor",
        prix = 500, -- Prix (pour 1 jour)
        rayonChargement = 30.0, -- chargement véhicule

        point = {
            {numberChambre = 1, pos = vector3(1142.4030761719, 2654.6909179688, 38.150638580322), interior = "motel_interior_gta"},
            {numberChambre = 2, pos = vector3(1142.4219970703, 2651.1166992188, 38.140922546387), interior = "motel_interior_gta"},
            {numberChambre = 3, pos = vector3(1142.3243408203, 2643.5805664062, 38.143692016602), interior = "motel_interior_gta"},
            {numberChambre = 4, pos = vector3(1141.1501464844, 2641.6774902344, 38.143707275391), interior = "motel_interior_gta"},
            {numberChambre = 5, pos = vector3(1136.34375, 2641.6362304688, 38.143707275391), interior = "motel_interior_gta"},
            {numberChambre = 6, pos = vector3(1132.7521972656, 2641.6391601562, 38.143726348877), interior = "motel_interior_gta"},
            {numberChambre = 7, pos = vector3(1125.2224121094, 2641.6391601562, 38.143753051758), interior = "motel_interior_gta"},
            {numberChambre = 8, pos = vector3(1121.3514404297, 2641.7368164062, 38.143753051758), interior = "motel_interior_gta"},
            {numberChambre = 9, pos = vector3(1114.6650390625, 2641.7395019531, 38.143753051758), interior = "motel_interior_gta"},
            {numberChambre = 10, pos = vector3(1107.1577148438, 2641.6394042969, 38.143753051758), interior = "motel_interior_gta"},
            {numberChambre = 11, pos = vector3(1106.0084228516, 2649.0434570312, 38.140926361084), interior = "motel_interior_gta"},
            {numberChambre = 12, pos = vector3(1106.1420898438, 2652.9040527344, 38.140914916992), interior = "motel_interior_gta"},
        },

        parking = {
            [1] = {numeroPlace = 1, pos = vector4(1097.9709472656,2663.2822265625,36.960983276367, 179.7612762451172)},
            [2] = {numeroPlace = 2, pos = vector4(1101.5447998047,2663.26171875,36.969966888428, 180.5982666015625)},
            [3] = {numeroPlace = 3, pos = vector4(1105.2672119141,2663.2416992188,36.966720581055, 178.4501953125)},
            [4] = {numeroPlace = 4, pos = vector4(1111.7982177734,2657.9353027344,36.99486541748, 89.36115264892578)},
            [5] = {numeroPlace = 5, pos = vector4(1111.6722412109,2654.3146972656,36.996395111084, 88.73555755615234)},
            [6] = {numeroPlace = 6, pos = vector4(1116.5297851562,2648.0437011719,36.996349334717, 179.21824645996097)},
            [7] = {numeroPlace = 7, pos = vector4(1120.2595214844,2647.5419921875,36.996387481689, 178.72207641601565)},
            [8] = {numeroPlace = 8, pos = vector4(1123.8820800781,2647.6530761719,36.996383666992, 179.34518432617188)},
            [9] = {numeroPlace = 9, pos = vector4(1127.5285644531,2647.943359375,36.996421813965, 179.93638610839844)},
            [10] = {numeroPlace = 10, pos = vector4(1131.2570800781,2647.7163085938,36.996444702148, 177.4997711181641)},
            [11] = {numeroPlace = 11, pos = vector4(1135.2293701172,2647.6052246094,36.996391296387, 178.4384765625)},
        },

        blip = {
            name = "The Motor",
            pos = vector3(1125.8946533203, 2653.3044433594, 37.996906280518), -- permet également de définir la zone radius pour le check distance 
            taille = 0.7,
            couleur = 47,
            type = 475, -- https://docs.fivem.net/docs/game-references/blips/
        }
    },
    ["Eastern"] = {
        label = "Eastern",
        prix = 500, -- Prix (pour 1 jour)
        rayonChargement = 30.0, -- chargement véhicule

        point = {
            {numberChambre = 1, pos = vector3(341.6877746582, 2614.919921875, 44.672077178955), interior = "motel_interior_gta"},
            {numberChambre = 2, pos = vector3(346.92822265625, 2618.2136230469, 44.675434112549), interior = "motel_interior_gta"},
            {numberChambre = 3, pos = vector3(354.29507446289, 2619.8327636719, 44.671844482422), interior = "motel_interior_gta"},
            {numberChambre = 4, pos = vector3(359.81686401367, 2622.8063964844, 44.67333984375), interior = "motel_interior_gta"},
            {numberChambre = 5, pos = vector3(367.19830322266, 2624.5341796875, 44.672416687012), interior = "motel_interior_gta"},
            {numberChambre = 6, pos = vector3(372.53765869141, 2627.5649414062, 44.671981811523), interior = "motel_interior_gta"},
            {numberChambre = 7, pos = vector3(379.88580322266, 2629.2534179688, 44.672233581543), interior = "motel_interior_gta"},
            {numberChambre = 8, pos = vector3(385.27224731445, 2632.3374023438, 44.671398162842), interior = "motel_interior_gta"},
            {numberChambre = 9, pos = vector3(392.62899780273, 2634.0051269531, 44.671970367432), interior = "motel_interior_gta"},
            {numberChambre = 10, pos = vector3(397.99899291992, 2637.2241210938, 44.673461914062), interior = "motel_interior_gta"},

        },

        parking = {
            [1] = {numeroPlace = 1, pos = vector4(336.83404541016,2619.056640625,43.497089385986, 207.68309020996097)},
            [2] = {numeroPlace = 2, pos = vector4(341.77429199219,2622.2858886719,43.508281707764, 210.1177673339844)},
            [3] = {numeroPlace = 3, pos = vector4(348.35601806641,2624.7080078125,43.500133514404, 209.53277587890625)},
            [4] = {numeroPlace = 4, pos = vector4(353.96704101562,2627.8020019531,43.497882843018, 210.82408142089844)},
            [5] = {numeroPlace = 5, pos = vector4(360.87603759766,2629.5749511719,43.497905731201, 210.82220458984375)},
            [6] = {numeroPlace = 6, pos = vector4(366.47805786133,2631.8415527344,43.498058319092, 214.33250427246097)},
            [7] = {numeroPlace = 7, pos = vector4(373.85589599609,2634.0717773438,43.498455047607, 210.5923004150391)},
            [8] = {numeroPlace = 8, pos = vector4(378.99774169922,2637.0007324219,43.496292114258, 211.50828552246097)},
            [9] = {numeroPlace = 9, pos = vector4(386.36749267578,2638.5124511719,43.496864318848, 212.29229736328128)},
            [10] = {numeroPlace = 10, pos = vector4(391.85690307617,2641.6538085938,43.492774963379, 209.5410919189453)},

        },

        blip = {
            name = "Eastern",
            pos = vector3(366.33752441406, 2635.4221191406, 44.496585845947), -- permet également de définir la zone radius pour le check distance 
            taille = 0.7,
            couleur = 47,
            type = 475, -- https://docs.fivem.net/docs/game-references/blips/
        }
    },
    ["Dream View"] = {
        label = "Dream View",
        prix = 500, -- Prix (pour 1 jour)
        rayonChargement = 30.0, -- chargement véhicule

        point = {
            {numberChambre = 1, pos = vector3(-111.16394805908, 6322.779296875, 31.576131820679), interior = "motel_interior_gta"},
            {numberChambre = 2, pos = vector3(-114.32813262939,6326.0756835938,31.576122283936), interior = "motel_interior_gta"},
            {numberChambre = 3, pos = vector3(-120.1579208374,6327.203125,31.575149536133), interior = "motel_interior_gta"},
            {numberChambre = 4, pos = vector3(-111.06367492676,6322.73046875,35.500995635986), interior = "motel_interior_gta"},
            {numberChambre = 5, pos = vector3(-114.34205627441,6326.0786132812,35.500995635986), interior = "motel_interior_gta"},
            {numberChambre = 6, pos = vector3(-120.23119354248, 6327.2700195312, 35.501007080078), interior = "motel_interior_gta"},
            {numberChambre = 7, pos = vector3(-103.45212554932, 6330.7309570312, 31.57618522644), interior = "motel_interior_gta"},
            {numberChambre = 8, pos = vector3(-106.70774841309, 6333.9296875, 31.57618522644), interior = "motel_interior_gta"},
            {numberChambre = 9, pos = vector3(-107.5774307251, 6339.7802734375, 31.575889587402), interior = "motel_interior_gta"},
            {numberChambre = 11, pos = vector3(-99.007949829102, 6348.4887695312, 31.575849533081), interior = "motel_interior_gta"},
            {numberChambre = 12, pos = vector3(-93.523147583008, 6353.966796875, 31.575881958008), interior = "motel_interior_gta"},
            {numberChambre = 13, pos = vector3(-90.220420837402, 6357.2338867188, 31.575887680054), interior = "motel_interior_gta"},
            {numberChambre = 14, pos = vector3(-84.87442779541, 6362.6030273438, 31.575889587402), interior = "motel_interior_gta"},
            {numberChambre = 15, pos = vector3(-103.42388153076, 6330.6494140625, 35.500793457031), interior = "motel_interior_gta"},
            {numberChambre = 16, pos = vector3(-106.73738098145, 6333.9624023438, 35.500793457031), interior = "motel_interior_gta"},

            {numberChambre = 17, pos = vector3(-107.52242279053, 6339.8193359375, 35.500793457031), interior = "motel_interior_gta"},
            {numberChambre = 18, pos = vector3(-102.24628448486, 6345.2495117188, 35.500793457031), interior = "motel_interior_gta"},
            {numberChambre = 19, pos = vector3(-98.926116943359, 6348.4340820312, 35.500793457031), interior = "motel_interior_gta"},
            {numberChambre = 20, pos = vector3(-93.544509887695, 6353.9497070312, 35.500793457031), interior = "motel_interior_gta"},
            {numberChambre = 21, pos = vector3(-90.195259094238, 6357.158203125, 35.500793457031), interior = "motel_interior_gta"},
            {numberChambre = 22, pos = vector3(-84.833717346191, 6362.6694335938, 35.500793457031), interior = "motel_interior_gta"},

        },

        parking = {
            [1] = {numeroPlace = 1, pos = vector4(-100.84146118164,6339.2680664062,30.490365982056, 44.01383972167969)},
            [2] = {numeroPlace = 2, pos = vector4(-98.219505310059,6341.9970703125,30.490365982056, 44.17812347412109)},
            [3] = {numeroPlace = 3, pos = vector4(-95.548538208008,6344.58203125,30.490365982056, 43.43165969848633)},
            [4] = {numeroPlace = 4, pos = vector4(-92.918464660645,6347.1625976562,30.490365982056, 44.46805953979492)},
            [5] = {numeroPlace = 5, pos = vector4(-90.333915710449,6349.888671875,30.490365982056, 44.84961700439453)},
            [6] = {numeroPlace = 6, pos = vector4(-87.409103393555,6352.396484375,30.490365982056, 46.06447601318359)},
            [7] = {numeroPlace = 7, pos = vector4(-84.476783752441,6355.1635742188,30.490365982056, 46.06447601318359)},
            [8] = {numeroPlace = 8, pos = vector4(-81.785789489746,6358.0502929688,30.490365982056, 46.06447601318359)},
            [9] = {numeroPlace = 9, pos = vector4(-72.335372924805,6358.3569335938,30.490377426147, 314.2713012695313)},
            [10] = {numeroPlace = 10, pos = vector4(-69.688056945801,6355.4155273438,30.490377426147, 313.4600219726563)},
            [11] = {numeroPlace = 11, pos = vector4(-66.72917175293,6352.75,30.490377426147, 313.9655456542969)},
            [12] = {numeroPlace = 12, pos = vector4(-64.010635375977,6349.9291992188,30.490383148193, 313.1434326171875)},
            [13] = {numeroPlace = 13, pos = vector4(-61.329620361328,6347.2221679688,30.490379333496, 313.7327575683594)},
            [14] = {numeroPlace = 14, pos = vector4(-58.591007232666,6344.580078125,30.490379333496, 313.8440856933594)},
            [15] = {numeroPlace = 15, pos = vector4(-72.028205871582,6342.0815429688,30.490375518799, 44.35123443603515)},
            [16] = {numeroPlace = 16, pos = vector4(-74.66722869873,6339.1176757812,30.490375518799, 43.51618576049805)},
            [17] = {numeroPlace = 17, pos = vector4(-77.234359741211,6336.388671875,30.490371704102, 43.49134826660156)},
            [18] = {numeroPlace = 18, pos = vector4(-79.856315612793,6333.6303710938,30.490367889404, 43.49241638183594)},
            [19] = {numeroPlace = 19, pos = vector4(-85.36888885498,6338.8686523438,30.490385055542, 223.0527801513672)},
            [20] = {numeroPlace = 20, pos = vector4(-82.883926391602,6341.7368164062,30.490385055542, 222.97914123535156)},
            [21] = {numeroPlace = 21, pos = vector4(-80.17854309082,6344.49609375,30.490377426147, 223.19656372070312)},
            [22] = {numeroPlace = 22, pos = vector4(-77.42342376709,6347.1064453125,30.49037361145, 223.01080322265625)},

        },

        blip = {
            name = "Dream View",
            pos = vector3(-81.109115600586, 6340.18359375, 31.490417480469), -- permet également de définir la zone radius pour le check distance 
            taille = 0.7,
            couleur = 47,
            type = 475, -- https://docs.fivem.net/docs/game-references/blips/
        }
    },
}
                                             
}