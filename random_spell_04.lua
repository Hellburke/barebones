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
	
	---------------------------------------
	local point1 = caster:GetAbsOrigin()
	local point2 = caster:GetAbsOrigin()
	local delay = 1.7
	local radius2 = 2222

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(), 
		caster:GetAbsOrigin(), 
		nil, 
		radius2, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		0, 
		0, 
		false
	) 
local closest = radius2

	for i,unit in ipairs(units) do
		local unit_location = unit:GetAbsOrigin()
		local vector_distance = point1 - unit_location
		local distance = (vector_distance):Length2D()

		if distance < closest and units ~= nil then
			closest = distance
			point2 = unit:GetAbsOrigin()
		--else
		--if units == nil then
		--	point2 = caster:GetAbsOrigin()
		end
		
	end

	CreateModifierThinker(
		caster, 
		self, 
		"modifier_random_spell_04c", 
		{ duration = delay}, 
		point2, 
		--caster:GetAbsOrigin(),
		caster:GetTeamNumber(), 
		false
	)




-------------------------------------------------
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

