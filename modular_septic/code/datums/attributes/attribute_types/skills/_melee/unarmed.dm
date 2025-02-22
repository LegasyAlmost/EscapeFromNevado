/**
 * UNARMED COMBAT
 *
 * GURPS has way different rules for unarmed combat, but i kinda don't like them!
 * So i came up with my own interpretation of unarmed combat skills.
 */
/datum/attribute/skill/brawling
	name = "Задирство"
	desc = "Способность бить и хуярить, неважно какой конечностью и чем именно."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -3,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/wrestling
	name = "Борьба"
	desc = "Способность захватывать в удущающие или сопротивляться им в Ближнем Бою. Словом - любые виды захватов."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
