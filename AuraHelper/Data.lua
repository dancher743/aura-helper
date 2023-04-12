paladinAuraIDs = {
	48942,	-- Devotion Aura (Rank 10)
	54043,	-- Retribution Aura (Rank 7)
	19746, 	-- Concentration Aura
	48943,	-- Shadow Resistance Aura (Rank 5)
	48945,	-- Frost Resistance Aura (Rank 5)
	48947,	-- Fire Resistance Aura (Rank 5)
	32223 	-- Crusader Aura
}

function IsPaladinAura(spellId)
	local result = false

	for i,v in pairs(paladinAuraIDs) do
		if spellId == paladinAuraIDs[i] then
			result = true
			break
		end
	end
	
	return result
end
