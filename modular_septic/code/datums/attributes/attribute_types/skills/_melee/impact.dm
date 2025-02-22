/**
 * IMPACT WEAPONS
 *
 * An impact weapon is any rigid, unbalanced weapon with most of its mass concentrated in the head.
 * Such a weapon cannot parry if you have already attacked with it on your turn.
 */
/datum/attribute/skill/impact_weapon
	name = "Дробящее"
	desc = "Любое одноручное от маленького и до среднего в длину оружие. Например, топоры и их короткие версии, булавы и палки с гвоздями и т.п."
	icon_state = "axe"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_FLAIL = -4,
		SKILL_IMPACT_WEAPON_TWOHANDED = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/impact_weapon_twohanded
	name = "Двуручное дробящее"
	desc = "Любое длинное и обхатываемое в две руки оружие. Например, бейсбольные биты, боевые топоры, молот люцерна и т.п."
	icon_state = "axe"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_POLEARM = -4,
		SKILL_FLAIL_TWOHANDED = -4,
		SKILL_IMPACT_WEAPON = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
