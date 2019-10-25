modifier_random_spell_04a = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_random_spell_04a:IsHidden()
	return false
end

function modifier_random_spell_04a:IsDebuff()
	return true
end

function modifier_random_spell_04a:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_random_spell_04a:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_slow" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" ) -- special value
end

function modifier_random_spell_04a:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_slow" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" ) -- special value	
end

function modifier_random_spell_04a:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_random_spell_04a:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_random_spell_04a:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_random_spell_04a:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_random_spell_04a:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_random_spell_04a:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end