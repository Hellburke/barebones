random_spell_04 = class({})
LinkLuaModifier( "modifier_random_spell_04a", "units/modifier_random_spell_04a", LUA_MODIFIER_MOTION_NONE ) --ability1, slow debuff
LinkLuaModifier( "modifier_random_spell_04c", "units/modifier_random_spell_04c", LUA_MODIFIER_MOTION_NONE ) --ability2, timed froststrike
LinkLuaModifier( "modifier_random_spell_04b", "units/modifier_random_spell_04b", LUA_MODIFIER_MOTION_NONE ) --ability3, attack speed buff

function random_spell_04:OnSpellStart()
	-- get references
	local caster = self:GetCaster()
	local ability = self.ability
	local ability_level = self:GetLevel()
	local level_set = 1


	-- ability level switcher : To toggle levels on cast
	local ability = caster:FindAbilityByName("random_spell_04")
	if ability_level == 1 then 
		ability:SetLevel(2)
	else
		if ability_level == 2 then 
		ability:SetLevel(3)
	else
		if ability_level == 3 then 
		ability:SetLevel(1)	
	end
	end
	end

		
	


	if ability_level == 1 then ---------------------------------------------------------------Spell1 Slardar Slithereen Crush
		-- spell 1 block : AOE Damage
		local radius = 300
		local slow_duration = self:GetSpecialValueFor("duration")

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

		-- Apply slow debuff
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_random_spell_04a", { duration = slow_duration }		)
		--enemy:AddNewModifier( self:GetCaster(), self, "modifier_random_spell_04b", { duration = debuffDuration }	)

		-- Apply Damage
		local damage = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = 200,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage( damage )
	end
		-- Play effects
		self:PlayEffects1()
	else

	if ability_level == 2 then ---------------------------------------------------------------Spell2
	
	function random_spell_04:GetAOERadius()
			return self:GetSpecialValueFor( "radius" )
	end

	function random_spell_04:OnSpellStart()
	-- unit identifier
			local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			9000,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		local target = nil
		for _,enemy in pairs(enemies) do
			if enemy~=self:GetParent() then
				target = enemy
				break
			end
		end
		local point = enemy:GetOrigin()
		--local point = self:GetCursorPosition()

	-- get values
		local delay = 1.5
		--local vision_distance = self:GetSpecialValueFor("vision_distance")
		--local vision_duration = self:GetSpecialValueFor("vision_duration")

	-- create modifier thinker
	CreateModifierThinker(
		caster,
		self,
		"random_spell_04",
		{ duration = delay },
		point,
		caster:GetTeamNumber(),
		false
		)

	-- create vision
	--AddFOWViewer( caster:GetTeamNumber(), point, vision_distance, vision_duration, false )
	end





	end

	if ability_level == 3 then ---------------------------------------------------------------Spell3 AOE Attack Speed Buff

		local radius = 150
		local debuffDuration = self:GetSpecialValueFor("duration")

		-- find affected units
		local friendly = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		-- for each selected friendly
		for _,friend in pairs(friendly) do
		-- Apply Damage
			friend:AddNewModifier( self:GetCaster(), self, "modifier_random_spell_04b", { duration = debuffDuration }	)
		-- Play effects
		self:PlayEffects3()
	end
end
end
end

function random_spell_04:PlayEffects1()
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

-----------------------------------------------------------------------------------------------------------------------

function random_spell_04:PlayEffects3()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf"
	local sound_cast = "Hero_OgreMagi.Bloodlust.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

