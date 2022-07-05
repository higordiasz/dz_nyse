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

function getMyAcoesId(playerId, idAcao)
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_user_acoes WHERE `player_id` = @playerId AND `id_acao` = @idAcao",
		{ ['@playerId'] = playerId, ["@idAcao"] = idAcao })
	if result[1] ~= nil then
		return result[1]
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

function getOuro()
	local result = MySQL.Sync.fetchAll("SELECT * FROM dz_nyse_gold")
	if result[1] ~= nil then
		return result[1]
	end
	return nil
end

function updateOuroValues(value1, value2, value3, value4, value5, value6, value7, value8, value9, value10)
	MySQL.Sync.insert("UPDATE dz_nyse_gold SET `atual` = @value1, `last` = @value2, `cotacao01` = @value1, `cotacao02` = @value2, `cotacao03` = @value3, `cotacao04` = @value4, `cotacao05` = @value5, `cotacao06` = @value6, `cotacao07` = @value7, `cotacao08` = @value8, `cotacao09` = @value9, `cotacao10` = @value10", { ["@qtd"] = qtd, ["@id"] = id, ["@value1"] = value1, ["@value2"] = value2, ["@value3"] = value3, ["@value4"] = value4, ["@value5"] = value5, ["@value6"] = value6, ["@value7"] = value7, ["@value8"] = value8, ["@value9"] = value9, ["@value10"] = value10 })
end

function updateQtdToComprarId(id, qtd)
	MySQL.Sync.insert("UPDATE dz_nyse_venda SET `quantidade` = @qtd WHERE `id` = @id", { ["@qtd"] = qtd, ["@id"] = id })
end

function updateQtdMyAcoes(idAcao, playerId, qtd)
	MySQL.Sync.insert("UPDATE dz_nyse_user_acoes SET `quantidade` = @qtd WHERE `player_id` = @playerId AND `id_acao` = @idAcao"
		, { ['@qtd'] = qtd, ['@playerId'] = playerId, ['@idAcao'] = idAcao })
end

function updateRendMyAcoes(idAcao, playerId, last)
	MySQL.Sync.insert("UPDATE dz_nyse_user_acoes SET `ultimo_rendimento` = @last WHERE `player_id` = @playerId AND `id_acao` = @idAcao"
		, { ['@last'] = last, ['@playerId'] = playerId, ['@idAcao'] = idAcao })
end

function updateUserInfo(playerId, despesas, rendimentos, saldoDisponivel)
	MySQL.Sync.insert("UPDATE dz_nyse_user SET `saldo_disponivel` = @saldoDisponivel, `despesas` = @despesas, `rendimentos` = @rendimentos WHERE `player_id` = @playerId"
		,
		{ ["@saldoDisponivel"] = saldoDisponivel, ["@despesas"] = despesas, ["@rendimentos"] = rendimentos,
			["@playerId"] = playerId })
end

function updateUserInfoDespesas(playerId, despesas)
	MySQL.Sync.insert("UPDATE dz_nyse_user SET `despesas` = @despesas WHERE `player_id` = @playerId",
		{ ["@despesas"] = despesas, ["@playerId"] = playerId })
end

function updateUserInfoRendimentos(playerId, rendimentos)
	MySQL.Sync.insert("UPDATE dz_nyse_user SET `rendimentos` = @rendimentos WHERE `player_id` = @playerId",
		{ ["@rendimentos"] = rendimentos, ["@playerId"] = playerId })
end

function updateUserInfoSaldoDisponivel(playerId, saldoDisponivel)
	MySQL.Sync.insert("UPDATE dz_nyse_user SET `saldo_disponivel` = @saldoDisponivel WHERE `player_id` = @playerId",
		{ ["@saldoDisponivel"] = saldoDisponivel, ["@playerId"] = playerId })
end

function addMyAcoes(idAcao, quantidade, ultimoRendimento, playerId, playerName)
	MySQL.Sync.insert("INSERT INTO dz_nyse_user_acoes (`id_acao`, `quantidade`, `ultimo_rendimento`, `player_id`, `player_name`) VALUES (@idAcao, @quantidade, @ultimoRendimento, @playerId, @playerName)"
		,
		{ ['@idAcao'] = idAcao, ['@quantidade'] = quantidade, ['@ultimoRendimento'] = ultimoRendimento,
			['@playerId'] = playerId, ['@playerName'] = playerName })
end

function addUserInfo(playerId, playerName, despesas)
	MySQL.Sync.insert("INSERT INTO dz_nyse_user (`saldo_disponivel`, `despesas`, `rendimentos`, `ouro`, `player_id`, `player_name`) VALUES ('0', @despesas, '0', '0', @playerId, @playerName)"
		, { ["@despesas"] = despesas, ["@playerId"] = playerId, ["@playerName"] = playerName })
end

function addExtrato(idAcao, tipo, quantidade, valor, descricao, playerId, playerName)
	MySQL.Sync.insert("INSERT INTO dz_nyse_extrato (`id_acao`, `tipo`, `quantidade`, `valor`, `descricao`, `player_id`, `player_name`) VALUES (@idAcao, @tipo, @quantidade, @valor, @descricao, @playerId, @playerName)"
		,
		{ ["@idAcao"] = idAcao, ["@tipo"] = tipo, ["@quantidade"] = quantidade, ["@valor"] = valor, ["@descricao"] = descricao,
			["@playerId"] = playerId, ["@playerName"] = playerName, })
end

function addVendaAcoes(idAcao, qtd, valor, playerId, playerName)
	MySQL.Sync.insert("INSERT INTO dz_nyse_venda (`id_acao`, `vendedor`, `quantidade`, `valor`, `player_id`, `player_name`) VALUES (@idAcao, @playerName, @qtd, @valor, @playerId, @playerName)"
		,{ ["@idAcao"] = idAcao, ["@qtd"] = qtd, ["@valor"] = valor, [" @playerId"] = playerId, ["@playerName"] = playerName })
end

function deleteAllVenderAcoes()
	MySQL.Sync.execute("DELETE FROM dz_nyse_venda WHERE `quantidade` = 0")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-----------------------------------------------------------------------------------------------------------------------------------------

--Atualizar o valor do ouro a cara 30min
Citizen.CreateThread(function()
	while true do
		-- Every 30min functions
		Citizen.Wait(1800000)
		atualizarOuro()
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERACAO
-----------------------------------------------------------------------------------------------------------------------------------------

function atualizarOuro()
	local ouro = getOuro()
	if ouro then
		local min = parseInt(ouro.min)
		local max = parseInt(ouro.max)
		math.randomseed(os.time())
		local newValue = math.floor(math.abs(math.random(min, max)))
		updateOuroValues(newValue, ouro.cotacao01, ouro.cotacao02, ouro.cotacao03, ouro.cotacao04, ouro.cotacao05, ouro.cotacao06, ouro.cotacao07, ouro.cotacao08, ouro.cotacao09)
	end
end

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
					local rendimentos = valor + userInfo.rendimentos
					updateUserInfoRendimentos(user_id, rendimentos)
					updateUserInfoSaldoDisponivel(user_id, saldoAtual)
					addExtrato(idAcao, "Venda", qtd, valor, "Venda de " .. qtd .. " açoes " .. acao.nome .. "", user_id,
						"" .. identity.name .. " " .. identity.name2 .. "")
				end
			end
		end
	end
end

function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function randomNumber()
   math.randomseed(os.time())
   local r = math.random()
   local v = r * 1000
   return math.floor(math.abs(v))
end

function cRP.limpar()
	deleteAllVenderAcoes()
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

function cRP.getOuro()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local ouro = getOuro()
		return ouro
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
					paymentAcao(data.id, data.compra, data.total, data.idAcao)
					addExtrato(data.idAcao, "Compra", data.compra, data.total,
						"Compra de " .. data.compra .. " açoes " .. data.nome .. " do " .. data.vendedor .. "", user_id,
						"" .. identity.name .. " " .. identity.name2 .. "")
					local qtdToSet = parseInt(data.qtd) - parseInt(data.compra)
					updateQtdToComprarId(data.id, qtdToSet)
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
				return false
			end
		else
			return false
		end
	else
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
				return true
			end
		end
	end
	return false
end

function cRP.venderAcoes(data)
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		local acao = getAcoesId(data.id)
		if acao ~= nil then
			local myAcao = getMyAcoesId(user_id, data.id)
			if myAcao ~= nil then
				local dif = parseInt(myAcao.quantidade) - parseInt(data.qtdVenda)
				print(dif)
				if dif > -1 then
					updateQtdMyAcoes(data.id, user_id, dif)
					addVendaAcoes(data.id, data.qtdVenda, data.valor, user_id,
						"" .. identity.name .. " " .. identity.name2 .. "")
					return true
				end
			end
		end
	end
	return false
end

function cRP.checkRendimentos()
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		local userInfo = getUserInfoId(user_id)
		if userInfo ~= nil then
			local myAcoes = getMyAcoes(user_id)
			if myAcoes ~= nil then
				local rendimento = 0
				for key,value in pairs(myAcoes) do
    				local last = value.ultimo_rendimento
					local split = mysplit(last, "/")
					local inicio = os.time{year=split[3], month=split[2], day=split[1]}
					local daysfrom = os.difftime(os.time(), inicio) / (24 * 60 * 60) -- seconds in a day
					local wholedays = math.floor(daysfrom)
					if wholedays > 0 then
						local acao = getAcoesId(value.id_acao)
						if acao ~= nil then
							for i = wholedays, 1, -1 do
    							local r = randomNumber()
								if r < 200 then
									local rend = math.random(acao.r_negativo_min, acao.r_negativo_max)
									rendimento = rendimento + rend
									updateRendMyAcoes(value.id_acao, user_id, os.date('%d/%m/%Y'))
									addExtrato(value.id_acao, "Perca", 1, rend, "Perca de " ..rend.. " da acao "..acao.nome.."", user_id,
									"" .. identity.name .. " " .. identity.name2 .. "")
								else
									if r > 950 then
										local rend = math.random(acao.rendimento_min, acao.rendimento_max) * 2
										rendimento = rendimento + rend
										updateRendMyAcoes(value.id_acao, user_id, os.date('%d/%m/%Y'))
										addExtrato(value.id_acao, "Rendimento", 1, rend, "Rendimento de " ..rend.. " da acao "..acao.nome.."", user_id,
										"" .. identity.name .. " " .. identity.name2 .. "")
									else
										local rend = math.random(acao.rendimento_min, acao.rendimento_max)
										rendimento = rendimento + rend
										updateRendMyAcoes(value.id_acao, user_id, os.date('%d/%m/%Y'))
										addExtrato(value.id_acao, "Rendimento", 1, rend, "Rendimento de " ..rend.. " da acao "..acao.nome.."", user_id,
										"" .. identity.name .. " " .. identity.name2 .. "")
									end
								end
							end
						end
					end
				end
				local disponivel = parseInt(userInfo.saldo_disponivel) + rendimento
				local rendimentosInfo = parseInt(userInfo.rendimentos) + rendimento
				updateUserInfoRendimentos(user_id, rendimentosInfo)
				updateUserInfoSaldoDisponivel(user_id, disponivel)
				return true
			end
		end
	end
	return false
end

function cRP.comprarOuro(data)
	local source = source
	local user_id = getPlayerID(source)
	if user_id then
		local gold = getOuro()
		if gold then

			local userInfo = getUserInfoId(user_id)
			if userInfo then

			else

			end
		end
	end
end

function cRP.venderOuro(data)

end
