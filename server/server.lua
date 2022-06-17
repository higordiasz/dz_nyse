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

function getMyAcaoId(idAcao, playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user_acoes WHERE id_acao = @idAcao AND player_id = @playerId", { ['@idAcao'] = idAcao, ['@playerId'] = playerId})
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function getUserInfoId(playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user WHERE player_id = @playerId", { ['@playerId'] = playerId})
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function updateQtdMyAcoes(idAcao, playerId, qtd)
    MySQL.Async.insert("UPDATE dz_nyse_user_acoes SET quantidade = @qtd WHERE player_id = @playerId AND id_acao = @idAcao",{ ['@qtd'] = qtd, ['@playerId'] = playerId, ['@idAcao'] = idAcao })
end

function updateUserInfo(playerId, despesas, rendimentos, saldoDisponivel)
	MySQL.Async.insert("UPDATE dz_nyse_user SET despesas = @despesas, rendimentos = @rendimentos, saldo_disponivel = @saldoDisponivel WHERE player_id = @playerId", { ["@depesas"] = depesas, ["@saldoDisponivel"] = saldoDisponivel, ["@playerId"] = playerId })
end

function addMyAcoes(idAcao, quantidade, ultimoRendimento, playerId, playerName)
	MySQL.Async.insert("INSERT INTO dz_nyse_user_acoes (`id_acao`, `quantidade`, `ultimo_rendimento`, `player_id`, `player_name`) VALUES (@idAcao, @quantidade, @ultimoRendimento, @playerId, @playerName)", { ['@idAcao'] = idAcao, ['@quantidade'] = quantidade, ['@ultimoRendimento'] = ultimoRendimento, ['@playerId'] = playerId, ['@playerName'] = playerName })
end

function addUserInfo(playerId, playerName, despesas)
	MySQL.Async.insert("INSER INTO dz_nyse_user (`saldo_disponivel`, `despesas`, `rendimentos`, `player_id`, `player_name`) VALUE ('0', @despesas, '0', @playerId, @playerName)", { ["@despesas"] = despesas, ["@playerId"] = playerId, ["@playerName"] = playerName })
end

function addComprarAcoes()

end

function updateQtdMyAcoes()

end

function updateAllLastRendimentos()

end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERACAO
-----------------------------------------------------------------------------------------------------------------------------------------

function checkUserInfo(playerId)
	local result = getUserInfoId(playerId)
	if result ~= nil then
		return true
	else
		return false
	end
end

function checkHaveAcao(idAcao, playerID)
	local result = getMyAcaoId(idAcao, playerID)
	if result ~= nil then
		return true
	end
	return false
end

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

function cRP.comprarAcoes(data)
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		if vRP.paymentBank(user_id,parseInt(data.total)) then
			if checkHaveAcao(data.idAcao, user_id) then
				local acao = getMyAcaoId(data.idAcao, user_id)
				if (acao ~= nil) then
					local qtd = paserInt(data.qtd) + parseInt(acao.quantidade)
					updateQtdMyAcoes(data.idAcao, user_id, qtd)
					if checkUserInfo(user_id) then
						local userInfo = getUserInfo(user_id)
						if userInfo != nil then
							local despesas = parseInt(userInfo.despesas) + parseInt(data.total)
							updateUserInfo(user_id, despesas, userInfo.rendimentos, userInfo.saldo_disponivel)
						else
							addUserInfo(user_id, ""..identity.name.." "..identity.name2.."", parseInt(data.total))
						end
					else
						addUserInfo(user_id, ""..identity.name.." "..identity.name2.."", parseInt(data.total))
					end
				else
					local identity = vRP.getUserIdentity(user_id)
					addMyAcoes(data.idAcao, data.qtd,os.date('%d/%m/%Y'), user_id, ""..identity.name.." "..identity.name2.."");
					if checkUserInfo(user_id) then
						local userInfo = getUserInfo(user_id)
						if userInfo != nil then
							local despesas = parseInt(userInfo.despesas) + parseInt(data.total)
							updateUserInfo(user_id, despesas, userInfo.rendimentos, userInfo.saldo_disponivel)
						else
							addUserInfo(user_id, ""..identity.name.." "..identity.name2.."", parseInt(data.total))
						end
					else
						addUserInfo(user_id, ""..identity.name.." "..identity.name2.."", parseInt(data.total))
					end
				end
			else
				local identity = vRP.getUserIdentity(user_id)
				addMyAcoes(data.idAcao, data.qtd,os.date('%d/%m/%Y'), user_id, ""..identity.name.." "..identity.name2.."");
				if checkUserInfo(user_id) then
					local userInfo = getUserInfo(user_id)
					if userInfo != nil then
						local despesas = parseInt(userInfo.despesas) + parseInt(data.total)
						updateUserInfo(user_id, despesas, userInfo.rendimentos, userInfo.saldo_disponivel)
					else
						addUserInfo(user_id, ""..identity.name.." "..identity.name2.."", parseInt(data.total))
					end
				else
					addUserInfo(user_id, ""..identity.name.." "..identity.name2.."", parseInt(data.total))
				end
			end
		else
			print("erro 2")
			return nil
		end
	else
		print("erro 3")
		return nil
	end
end
