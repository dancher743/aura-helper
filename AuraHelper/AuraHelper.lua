--
--	AuraHelper
--	by Dancher
--

function AuraHelper_OnLoad(self)
	local version = GetAddOnMetadata("AuraHelper", "Version");
	local greetings_message = "AuraHelper %s loaded! Get the latest version here: |cff0076ffhttps://github.com/dancher743/aura-helper|r"
	AuraHelper_Log((greetings_message):format(version));	
end

function AuraHelper_Log(message)
	DEFAULT_CHAT_FRAME:AddMessage(message);
end

function AuraHelper_GameTooltip_OnLoad(self)	
	GameTooltip:HookScript("OnTooltipSetSpell", function(self)
		local spellName, spellRank, spellId = self:GetSpell()
		if IsPaladinAura(spellId) then
			ShowSpellSources(spellName)
		end
    end)
end

function ShowSpellSources(spellName)
	local players = {}
	
	-- Player only
	local spellSource = select(8,UnitAura("player", spellName));
	local unitName = UnitName(spellSource)
	players[unitName] = spellName
	
	if IsInGroup() then
		-- Group
		for i = 1, 4 do
			local spellSource = select(8,UnitAura("party"..i, spellName));
			if spellSource then
				local unitName = UnitName(spellSource)
				if players[unitName] == nil then
					players[unitName] = spellName
				end
			end
		end
	end
	
	if IsInRaid() then
		-- Raid
		for i = 1, 40 do
			local spellSource = select(8,UnitAura("raid"..i, spellName));
			if spellSource then
				local unitName = UnitName(spellSource)
				if players[unitName] == nil then
					players[unitName] = spellName
				end
			end
		end
	end
	
	if IsActiveBattlefieldArena() then
		-- Arena
		for i = 1, 5 do
			local spellSource = select(8,UnitAura("arena"..i, spellName));
			if spellSource then
				local unitName = UnitName(spellSource)
				if players[unitName] == nil then
					players[unitName] = spellName
				end
			end
		end
	end
	
	-- Print
	local keyset={}
	local n=0
	for k,v in pairs(players) do
		n=n+1
		keyset[n]=k
	end
	local r,g,b = 1,1,1
	if #keyset > 1 then
		r,g,b = 1,0.15,0.15
	end
	local player_names = table.concat(keyset, ", ")
	GameTooltip:AddLine(player_names, r, g, b, true);
end

function IsInGroup()
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end

function IsInRaid()
	return GetNumRaidMembers() > 0
end
