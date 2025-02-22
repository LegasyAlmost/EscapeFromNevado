// Crossbow
/datum/attribute/skill/crossbow
	name = "Арбалет"
	desc = "Способность использовать все виды арбалетов, включая арбалеты-пистолеты, \
			чо-ко-ну и блочные арбалеты."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
