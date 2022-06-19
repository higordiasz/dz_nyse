-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("dz_nyse", cRP)
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

function getAcoesId(idAcao)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_acoes WHERE `id` = @idAcao", { ["@idAcao"] = idAcao })
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function getMyAcoes(playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user_acoes WHERE `player_id` = @playerId",
		{ ['@playerId'] = playerId })
	if result ~= nil then
		return result
	end
	return nil
end

function getMyExtrato(playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_extrato WHERE `player_id` = @playerId",
		{ ['@playerId'] = playerId })
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

function getComprarAcoesById(id)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_venda WHERE `id` = @id", { ["@id"] = id })
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function getUserInfo(playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user WHERE `player_id` = @playerId",
		{ ['@playerId'] = playerId })
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function getMyAcaoId(idAcao, playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user_acoes WHERE `id_acao` = @idAcao AND `player_id` = @playerId"
		, { ['@idAcao'] = idAcao, ['@playerId'] = playerId })
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function getUserInfoId(playerId)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user WHERE `player_id` = @playerId",
		{ ['@playerId'] = playerId })
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function updateQtdToComprarId(id, qtd)
	MySQL.Async.insert("UPDATE dz_nyse_venda SET `quantidade` = @qtd WHERE `id` = @id", { ["@qtd"] = qtd, ["@id"] = id })
end

function updateQtdMyAcoes(idAcao, playerId, qtd)
	MySQL.Async.insert("UPDATE dz_nyse_user_acoes SET `quantidade` = @qtd WHERE `player_id` = @playerId AND `id_acao` = @idAcao"
		, { ['@qtd'] = qtd, ['@playerId'] = playerId, ['@idAcao'] = idAcao })
end

function updateUserInfo(playerId, despesas, rendimentos, saldoDisponivel)
	MySQL.Async.insert("UPDATE dz_nyse_user SET `saldo_disponivel` = @saldoDisponivel, `despesas` = @despesas, `rendimentos` = @rendimentos WHERE `player_id` = @playerId"
		,
		{ ["@saldoDisponivel"] = saldoDisponivel, ["@despesas"] = despesas, ["@rendimentos"] = rendimentos,
			["@playerId"] = playerId })
end

function updateUserInfoDespesas(playerId, despesas)
	MySQL.Async.insert("UPDATE dz_nyse_user SET `despesas` = @despesas WHERE `player_id` = @playerId",
		{ ["@despesas"] = despesas, ["@playerId"] = playerId })
end

function updateUserInfoRendimentos(playerId, rendimentos)
	MySQL.Async.insert("UPDATE dz_nyse_user SET `rendimentos` = @rendimentos WHERE `player_id` = @playerId",
		{ ["@rendimentos"] = rendimentos, ["@playerId"] = playerId })
end

function updateUserInfoSaldoDisponivel(playerId, saldoDisponivel)
	MySQL.Async.insert("UPDATE dz_nyse_user SET `saldo_disponivel` = @saldoDisponivel WHERE `player_id` = @playerId",
		{ ["@saldoDisponivel"] = saldoDisponivel, ["@playerId"] = playerId })
end

function addMyAcoes(idAcao, quantidade, ultimoRendimento, playerId, playerName)
	MySQL.Async.insert("INSERT INTO dz_nyse_user_acoes (`id_acao`, `quantidade`, `ultimo_rendimento`, `player_id`, `player_name`) VALUES (@idAcao, @quantidade, @ultimoRendimento, @playerId, @playerName)"
		,
		{ ['@idAcao'] = idAcao, ['@quantidade'] = quantidade, ['@ultimoRendimento'] = ultimoRendimento,
			['@playerId'] = playerId, ['@playerName'] = playerName })
end

function addUserInfo(playerId, playerName, despesas)
	MySQL.Async.insert("INSERT INTO dz_nyse_user (`saldo_disponivel`, `despesas`, `rendimentos`, `player_id`, `player_name`) VALUES ('0', @despesas, '0', @playerId, @playerName)"
		, { ["@despesas"] = despesas, ["@playerId"] = playerId, ["@playerName"] = playerName })
end

function addExtrato(idAcao, tipo, quantidade, valor, descricao, playerId, playerName)
	MySQL.Async.insert("INSERT INTO dz_nyse_extrato (`id_acao`, `tipo`, `quantidade`, `valor`, `descricao`, `player_id`, `player_name`) VALUES (@idAcao, @tipo, @quantidade, @valor, @descricao, @playerId, @playerName)"
		,
		{ ["@idAcao"] = idAcao, ["@tipo"] = tipo, ["@quantidade"] = quantidade, ["@valor"] = valor, ["@descricao"] = descricao,
			["@playerId"] = playerId, ["@playerName"] = playerName, })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERACAO
-----------------------------------------------------------------------------------------------------------------------------------------

function checkHaveQtdToBuy(idVenda, qtd)
	local result = getComprarAcoesById(idVenda)
	if result ~= nil then
		if parseInt(result.quantidade) >= parseInt(qtd) then
			return true
		end
	end
	return false
end

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

function paymentAcao(id, qtd, valor, idAcao)
	local venda = getComprarAcoesById(id)
	if venda ~= nil then
		local user_id = venda.player_id
		if parseInt(user_id) > 0 then
			local userInfo = getUserInfo(user_id)
			local identity = vRP.getUserIdentity(user_id)
			local acao = getAcoesId(idAcao)
			if acao ~= nil then
				if userInfo ~= nil then
					local saldoAtual = valor + userInfo.saldo_disponivel
					updateUserInfoSaldoDisponivel(user_id, saldoAtual)
					addExtrato(idAcao, "Venda", qtd, valor, "Venda de " .. qtd .. " açoes " .. acao.nome .. "", user_id,
						"" .. identity.name .. " " .. identity.name2 .. "")
				end
			end
		end
	end
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
		local identity = vRP.getUserIdentity(user_id)
		if checkHaveQtdToBuy(data.id, data.compra) then
			if vRP.paymentBank(user_id, parseInt(data.total)) then
				if checkHaveAcao(data.idAcao, user_id) then
					paymentAcao(data.id, data.compra, data.total, data.idAcao)
					addExtrato(data.idAcao, "Compra", data.compra, data.total,
						"Compra de " .. data.compra .. " açoes " .. data.nome .. " do " .. data.vendedor .. "", user_id,
						"" .. identity.name .. " " .. identity.name2 .. "")
					local qtdToSet = parseInt(data.qtd) - parseInt(data.compra)
					updateQtdToComprarId(data.id, qtdToSet)
					local acao = getMyAcaoId(data.idAcao, user_id)
					if (acao ~= nil) then
						local qtd = parseInt(data.compra) + parseInt(acao.quantidade)
						updateQtdMyAcoes(data.idAcao, user_id, qtd)
						if checkUserInfo(user_id) then
							local userInfo = getUserInfo(user_id)
							if userInfo ~= nil then
								local despesas = parseInt(userInfo.despesas) + parseInt(data.total)
								updateUserInfo(user_id, despesas, userInfo.rendimentos, userInfo.saldo_disponivel)
								return true
							else
								addUserInfo(user_id, "" .. identity.name .. " " .. identity.name2 .. "", parseInt(data.total))
								return true
							end
						else
							addUserInfo(user_id, "" .. identity.name .. " " .. identity.name2 .. "", parseInt(data.total))
							return true
						end
					else
						addMyAcoes(data.idAcao, data.compra, os.date('%d/%m/%Y'), user_id, "" .. identity.name .. " " .. identity.name2 ..
							"");
						if checkUserInfo(user_id) then
							local userInfo = getUserInfo(user_id)
							if userInfo ~= nil then
								local despesas = parseInt(userInfo.despesas) + parseInt(data.total)
								updateUserInfo(user_id, despesas, userInfo.rendimentos, userInfo.saldo_disponivel)
								return true
							else
								addUserInfo(user_id, "" .. identity.name .. " " .. identity.name2 .. "", parseInt(data.total))
								return true
							end
						else
							addUserInfo(user_id, "" .. identity.name .. " " .. identity.name2 .. "", parseInt(data.total))
							return true
						end
					end
				else
					addMyAcoes(data.idAcao, data.compra, os.date('%d/%m/%Y'), user_id, "" .. identity.name .. " " .. identity.name2 ..
						"");
					if checkUserInfo(user_id) then
						local userInfo = getUserInfo(user_id)
						if userInfo ~= nil then
							local despesas = parseInt(userInfo.despesas) + parseInt(data.total)
							updateUserInfo(user_id, despesas, userInfo.rendimentos, userInfo.saldo_disponivel)
							return true
						else
							addUserInfo(user_id, "" .. identity.name .. " " .. identity.name2 .. "", parseInt(data.total))
							return true
						end
					else
						addUserInfo(user_id, "" .. identity.name .. " " .. identity.name2 .. "", parseInt(data.total))
						return true
					end
				end
			else
				print("erro 2")
				return false
			end
		else
			print("erro 3")
			return false
		end
	else
		print("erro 4")
		return false
	end
end

function cRP.sacarRendimento(data)
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		local userInfo = getUserInfoId(user_id)
		if userInfo ~= nil then
			local dif = parseInt(userInfo.saldo_disponivel) - parseInt(data.valor)
			if dif > -1 then
				vRP.addBank(user_id,parseInt(data.valor))
				addExtrato("saque", "Saque", 1, data.valor, "Saque de " .. data.valor .. "", user_id,
						"" .. identity.name .. " " .. identity.name2 .. "")
				updateUserInfoSaldoDisponivel(user_id, dif)
			end
		end
	end
	return false
end
