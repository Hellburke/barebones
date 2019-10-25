random_spell_04 = class({})
LinkLuaModifier( "modifier_random_spell_01", "units/modifier_random_spell_01", LUA_MODIFIER_MOTION_NONE )

function random_spell_01:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	local damage = 200 --self:GetAbilityDamage()
	local duration = self:GetSpecialValueFor("stun_duration")
	local ability = self.ability
	local ability_level = self:GetLevel()
	local level_set = 1


	-- ability level switcher : To toggle levels on cast
	local ability = caster:FindAbilityByName("random_spell_01")
	if ability_level == 1 then 
		ability:SetLevel(2)
	else
		if ability_level == 2 then 
		ability:SetLevel(1)
	end
	end

	if ability_level == 1 then
		-- spell 1 block : AOE Damage
		local radius = 300

		-- find affected units
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		-- for each caught enemies
		for _,enemy in pairs(enemies) do
		-- Apply Damage
		local damage = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage( damage )
		end
		-- Play effects
		self:PlayEffects()
	else
	if ability_level == 2 then
	-- spell 2 block : Single Damage Target
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damageTable )


	end
end
end

function random_spell_01:PlayEffects()
	-- get particles
	local particle_cast = "particles/units/heroes/hero_slardar/slardar_crush.vpcf"
	local sound_cast = "Hero_Slardar.Slithereen_Crush"

	-- get data
	local radius = 300


	local nFXIndex = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector(radius, radius, radius) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
end