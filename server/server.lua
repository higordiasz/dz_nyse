-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("dz_nyse",cRP)
vCLIENT = Tunnel.getInterface("dz_nyse")


-----------------------------------------------------------------------------------------------------------------------------------------
-- DB
-----------------------------------------------------------------------------------------------------------------------------------------
function getAcoes()
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_acoes")
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function getMyAcoes(playerId)
    local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user_acoes WHERE player_id = @playerId", { ['@playerId'] = playerId})
	if result[1] ~= nil then
		    return result[1]
	end
	return nil
end

function getMyExtrato(playerId)
    local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_extrato WHERE player_id = @playerId", { ['@playerId'] = playerId})
	if result[1] ~= nil then
		    return result[1]
	end
	return nil
end

function getComprarAcoes()
    local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_venda")
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function updateQtdMyAcoes(idAcao, playerId, cb)
    MySQL.Async.insert("UPDATE dz_nyse_user_acoes SET phone = @myPhoneNumber WHERE id = @identifier",{ ['@myPhoneNumber'] = myPhoneNumber, ['@identifier'] = identifier })
end
