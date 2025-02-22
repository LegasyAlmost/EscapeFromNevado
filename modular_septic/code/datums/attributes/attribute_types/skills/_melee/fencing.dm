/**
 * FENCING WEAPONS
 *
 * Fencing weapons are light, one-handed weapons, usually hilted blades, optimized for parrying.
 * If you have a fencing weapon, you get an improved retreating bonus when you parry.
 * Furthermore, you have half the usual penalty for parrying more than once with the same hand.
 */
/datum/attribute/skill/rapier
	name = "Рапиры"
	desc = "Любое длинное клинковое оружие (выше одного метра). Лёгкое и пронзающее оружие."
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_LONGSWORD = -4,
		SKILL_SMALLSWORD = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/smallsword
	name = "Маленькие мечи"
	desc = "Любое короткое (до одного метра) оружие. Лёгкие и пронзающие мечи или одноручные посохи."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_LONGSWORD = -4,
		SKILL_SHORTSWORD = -4,
		SKILL_RAPIER = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
