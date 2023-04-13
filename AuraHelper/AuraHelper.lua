--
--	AuraHelper
--	by Dancher
--

function AuraHelper_OnLoad(self)
	local version = GetAddOnMetadata("AuraHelper", "Version");
	local greetings_message = "AuraHelper %s loaded! Get the latest version here: |cff0076ffhttps://github.com/dancher743/aura-helper|r"
	AuraHelper_Log((greetings_message):format(version));	
end

function AuraHelper_GameTooltip_OnLoad(self)	
	GameTooltip:HookScript("OnTooltipSetSpell", OnTooltipSetSpell)
end

function AuraHelper_Log(message)
	DEFAULT_CHAT_FRAME:AddMessage(tostring(message));
end

function OnTooltipSetSpell(tooltip)
	local spellName, spellRank, spellId = tooltip:GetSpell()
	if paladinAuraIDs[spellId] then
		AddSpellUnitsInTooltip(spellName, tooltip)
	end
end

function AddSpellUnitsInTooltip(spellName, tooltip)
	local units = {}
	
	GetUnitBySpell("player", spellName, units)
	
	if IsInGroup() then
		GetUnitsBySpell("party", 4, spellName, units)
	end
	
	if IsInRaid() then
		GetUnitsBySpell("raid", 40, spellName, units)
	end
	
	if IsActiveBattlefieldArena() then
		GetUnitsBySpell("arena", 5, spellName, units)
	end
	
	local unit_names={}	
	for name,spellId in pairs(units) do
		unit_names[#unit_names+1]=name
	end
	
	if #unit_names == 0 then
		return
	end
	
	local r,g,b = 1,1,1 -- white color
	if #unit_names > 1 then
		r,g,b = 1,0.2,0.2 -- red color
	end
	
	unit_names = table.concat(unit_names, ", ")
	tooltip:AddLine(unit_names, r, g, b, true);
end

function GetUnitBySpell(unitId, spellName, units)
	local spellSource = select(8,UnitAura(unitId, spellName))
	if spellSource then
		local unitName = UnitName(spellSource)
		if units[unitName] == nil then
			units[unitName] = spellName
		end
	end
end

function GetUnitsBySpell(unitId, count, spellName, units)
	for i = 1, count do
		GetUnitBySpell(unitId..i, spellName, units)
	end
end

function IsInGroup()
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end

function IsInRaid()
	return GetNumRaidMembers() > 0
end
