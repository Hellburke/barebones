    
--[[Author: YOLOSPAGHETTI
	Date: July 15, 2016
	Puts all the targets offset in front of the caster, and stuns them]]
function random_spell_01(keys)
	local caster = keys.caster
	local target = keys.target
	local point = self:GetCursorPosition()
	local ability = keys.ability
	local ability_level = ability:GetLevel()
	if target then
		point = target:GetOrigin()
	end

	--dragonslave spell2 data
	local projectile_name = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf"
	local projectile_distance = 600
	local projectile_speed = 1200
	local projectile_start_radius = 275
	local projectile_end_radius = 200
	--end
	
	local hero_stun_duration = ability:GetLevelSpecialValueFor("hero_stun_duration", ability:GetLevel() - 1)
	local creep_stun_duration = ability:GetLevelSpecialValueFor("creep_stun_duration", ability:GetLevel() - 1)
	local pull_offset = 150 --ability:GetLevelSpecialValueFor("pull_offset", ability:GetLevel() - 1)
	
	-- The angle the caster is facing
	local caster_angle = caster:GetForwardVector()
	-- The caster's position
	local caster_origin = caster:GetAbsOrigin()
	-- The vector from the caster to the target position
	local offset_vector = caster_angle * pull_offset
	-- The target's new position
	local new_location = caster_origin + offset_vector
	
	-- Moves all the targets to the position
	--target:SetAbsOrigin(new_location)
	--FindClearSpaceForUnit(target, new_location, true)
	
	-- Applies the stun modifier based on the unit's type
	--if target:IsHero() == true then
		--target:AddNewModifier(caster, ability, "modifier_stunned", {Duration = 0.00})
	--else
		--target:AddNewModifier(caster, ability, "modifier_stunned", {Duration = creep_stun_duration})
	--end

	if ability_level == 1 then
	-- Moves all the targets to the position
	target:SetAbsOrigin(new_location)
	FindClearSpaceForUnit(target, new_location, true)
	target:AddNewModifier(caster, ability, "modifier_stunned", {Duration = 0.00})

	else

	--spell2 block start
	local direction = point-caster:GetOrigin()
	direction.z = 0
	local projectile_direction = direction:Normalized()

	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_start_radius,
	    fEndRadius = projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bProvidesVision = false,
	}

	ProjectileManager:CreateLinearProjectile(info)

	-- Play effects
	local sound_cast = "Hero_Lina.DragonSlave.Cast"
	local sound_projectile = "Hero_Lina.DragonSlave"
	EmitSoundOn( sound_cast, caster )
	EmitSoundOn( sound_projectile, caster )

	function random_spell_01:OnProjectileHitHandle( target, location, projectile )
	if not target then return end

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = 99999,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- get direction
	local direction = ProjectileManager:GetLinearProjectileVelocity( projectile )
	direction.z = 0
	direction = direction:Normalized()

	-- play effects
	self:PlayEffects( target, direction )
	end

	function random_spell_01:PlayEffects( target, direction )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lina/lina_spell_dragon_slave_impact.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlForward( effect_cast, 1, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	end

	--spell2 block end

	end

end