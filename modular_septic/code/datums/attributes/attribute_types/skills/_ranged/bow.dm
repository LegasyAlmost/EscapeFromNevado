// Bow
/datum/attribute/skill/bow
	name = "Лук"
	desc = "Способность использовать длинные/короткие луки и их похожие. \
			Также этот навык включает себя блочный лук."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
