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
			ShowSpellSource(spellName)
		end
    end)
end

function ShowSpellSource(spellName)
	local spellSource = select(8,UnitBuff("player", spellName));
	local unitName = UnitName(spellSource)
	AuraHelper_Log(spellName..": "..unitName);
end
