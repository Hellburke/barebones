-- modifier_ogre_magi_fireblast_lua.lua
modifier_random_spell_01 = class({})

function modifier_random_spell_01:IsDebuff()
	return true
end

function modifier_random_spell_01:IsStunDebuff()
	return true
end

--------------------------------

function modifier_random_spell_01:CheckState()
	local state = {
	    [MODIFIER_STATE_STUNNED] = true,
	}

	return state
end