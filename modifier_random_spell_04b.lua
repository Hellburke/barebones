modifier_random_spell_04b = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_random_spell_04b:IsHidden()
	return false
end

function modifier_random_spell_04b:IsDebuff()
	return true
end

function modifier_random_spell_04b:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_random_spell_04b:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_fast" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_fast" ) -- special value
end

function modifier_random_spell_04b:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_fast" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_fast" ) -- special value	
end

function modifier_random_spell_04b:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_random_spell_04b:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_random_spell_04b:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_random_spell_04b:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_random_spell_04b:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf"
end

function modifier_random_spell_04b:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end