// Grenade launcher
/datum/attribute/skill/grenade_launcher
	name = "Гранатомёт"
	desc = "Любое крупнокалиберное маломощное стрелковое оружие, стреляющее разрывными снарядами. \
			Навык, включает в себя подствольные гранатомёты и сигнальные пистолеты."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_GYROC = -4,
		SKILL_LAW = -4,
		SKILL_LMG = -4,
		SKILL_MUSKET = -4,
		SKILL_PISTOL = -4,
		SKILL_RIFLE = -4,
		SKILL_SHOTGUN = -4,
		SKILL_SMG = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
