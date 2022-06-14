-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("dz_nyse",cRP)
vSERVER = Tunnel.getInterface("dz_nyse")


local nui = false;

function NuiAction()
    nui = not nui
    if nui then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showMenu"
        })
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "hideMenu"
        })
    end
end

RegisterNUICallback("Close",function(data,cb)
	if data == "fechar" then
		NuiAction();
	end
end)

RegisterCommand('nyse', function()
    NuiAction();
end)
