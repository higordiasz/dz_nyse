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
        local acoes = vSERVER.getAcoes()
        local myAcoes = vSERVER.getMyAcoes()
        local myExtrato = vSERVER.getMyExtrato()
        local comprarAcoes = vSERVER.getComprarAcoes()
        local userInfo = vSERVER.getUserInfo()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showMenu",
            acoes = acoes,
            myAcoes = myAcoes,
            myExtrato = myExtrato,
            comprarAcoes = comprarAcoes,
            userInfo = userInfo
        })
        if vSERVER.checkRendimentos() then
            AtualizarNui()
        end
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "hideMenu"
        })
    end
end

function AtualizarNui()
    local acoes = vSERVER.getAcoes()
        local myAcoes = vSERVER.getMyAcoes()
        local myExtrato = vSERVER.getMyExtrato()
        local comprarAcoes = vSERVER.getComprarAcoes()
        local userInfo = vSERVER.getUserInfo()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "atualizar",
            acoes = acoes,
            myAcoes = myAcoes,
            myExtrato = myExtrato,
            comprarAcoes = comprarAcoes,
            userInfo = userInfo
        })
end

RegisterNUICallback("Close",function(data,cb)
	if data == "fechar" then
		NuiAction();
	end
end)

RegisterNUICallback("Atualizar",function()
    AtualizarNui();
end)

RegisterNUICallback("Comprar",function(data)
    if vSERVER.comprarAcoes(data) then
        AtualizarNui()
    end
end)

RegisterNUICallback("Vender", function(data)
    if vSERVER.venderAcoes(data) then
        AtualizarNui()
    end
end)

RegisterNUICallback("Sacar", function(data)
    if vSERVER.sacarRendimento(data) then
        AtualizarNui()
    end
end)

RegisterCommand('nyse', function()
    NuiAction();
end)

RegisterNetEvent("dz_nyse:Update")
AddEventHandler("dz_nyse:Update",function()
	AtualizarNui()
end)
