-- random_spell_03.lua
random_spell_03 = class({})
LinkLuaModifier( "modifier_random_spell_03", "units/modifier_random_spell_03", LUA_MODIFIER_MOTION_NONE )

function random_spell_03:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local bolt_lua_speed = self:GetSpecialValueFor("chaos_bolt_speed")
	local projectile = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf"

	-- Create Tracking Projectile
	local info = {
		Source = self:GetCaster(),
		Target = target,
		Ability = self,
		iMoveSpeed = bolt_lua_speed,
		EffectName = projectile,
		bDodgeable = true,
	}
	ProjectileManager:CreateTrackingProjectile( info )

end

function random_spell_03:OnProjectileHit( hTarget, vLocation )
	-- get references
	local damage_min = self:GetSpecialValueFor("damage_min")
	local damage_max = self:GetSpecialValueFor("damage_max")
	local stun_min = self:GetSpecialValueFor("stun_min")
	local stun_max = self:GetSpecialValueFor("stun_max")

	-- throw a random number
	local x = RandomFloat(0,1)
	local y = 1-x

	-- calculate damage and stun values
	local damage_act = self:Expand(x,damage_min,damage_max)
	local stun_act = self:Expand(y,stun_min,stun_max)

	-- Apply damage
	local damage = {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = damage_act,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damage )

	-- Add stun modifier
	hTarget:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_random_spell_03",
		{ duration = stun_act }
	)
end

function random_spell_03:Expand( value, min, max )
	return (max-min)*value + min
end