modifier_random_spell_02_passive = class({})
--LinkLuaModifier( "random_spell_02_passive", "units/random_spell_02_passive", LUA_MODIFIER_MOTION_NONE )

function modifier_random_spell_02_passive:OnCreated( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
	self.armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_random_spell_02_passive:OnRefresh( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
end

-- modifier property
function modifier_random_spell_02_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

-- modifier_antimage_spell_shield_lua.lua
function modifier_random_spell_02_passive:GetModifierMagicalResistanceBonus( params )
	return self.bonus
end

function modifier_random_spell_02_passive:GetModifierPhysicalArmorBonus( params )
	return self.armor
end