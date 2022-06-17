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
	if result ~= nil then
		return result
	end
	return nil
end

function getMyAcoes(playerId)
    local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user_acoes WHERE player_id = @playerId", { ['@playerId'] = playerId})
	if result ~= nil then
		    return result
	end
	return nil
end

function getMyExtrato(playerId)
    local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_extrato WHERE player_id = @playerId", { ['@playerId'] = playerId})
	if result ~= nil then
		    return result
	end
	return nil
end

function getComprarAcoes()
    local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_venda")
	if result ~= nil then
		return result
	end
	return nil
end

function getUserInfo(playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user WHERE player_id = @playerId", { ['@playerId'] = playerId })
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function updateQtdMyAcoes(idAcao, playerId, qtd)
    MySQL.Async.insert("UPDATE dz_nyse_user_acoes SET quantidade = @qtd WHERE player_id = @playerId AND id_acao = @idAcao",{ ['@qtd'] = qtd, ['@playerId'] = playerId, ['@idAcao'] = idAcao })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERACAO
-----------------------------------------------------------------------------------------------------------------------------------------

function getPlayerID(source)
	local player = vRP.getUserId(source)
	return player
end

function cRP.getAcoes()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local acoes = getAcoes()
		return acoes
	end
	return nil
end

function cRP.getMyAcoes()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local acoes = getMyAcoes(user_id)
		return acoes
	end
	return nil
end

function cRP.getMyExtrato()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local acoes = getMyExtrato(user_id)
		return acoes
	end
	return nil
end

function cRP.getComprarAcoes()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local acoes = getComprarAcoes()
		return acoes
	end
	return nil
end

function cRP.getUserInfo()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local userInfo = getUserInfo(user_id)
		return userInfo
	end
	return nil
end
