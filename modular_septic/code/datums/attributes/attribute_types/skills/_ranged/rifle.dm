// Rifle
/datum/attribute/skill/rifle
	name = "Ружья"
	desc = "Любое длинноствольное ружейное оружие: штурмовые винтовки, охотничие ружья, снайперские винтовки, словом – всё, что выпускает снаряд."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_GRENADE_LAUNCHER = -4,
		SKILL_GYROC = -4,
		SKILL_LAW = -4,
		SKILL_LMG = -2,
		SKILL_MUSKET = -2,
		SKILL_PISTOL = -2,
		SKILL_SHOTGUN = -2,
		SKILL_SMG = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY
