/**
 * SWORD WEAPONS
 *
 * A sword is a rigid, hilted blade with a thrusting point, cutting edge, or both.
 * All swords are balanced, and can attack and parry without becoming unready.
 */
/datum/attribute/skill/force_sword
	name = "Force Sword"
	desc = "Any sword with a \"blade\" made of energy, liquid, gas or plasma instead of solid matter. \
			This generally refers to a high-tech weapon that project energy from a powered hilt, \
			but extends to similar effects produced using magic or psionics."
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_SWORD_TWOHANDED = -3,
		SKILL_LONGSWORD = -3,
		SKILL_SHORTSWORD = -3,
		SKILL_KNIFE = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/sword_twohanded
	name = "Двуручный меч"
	desc = "Любый сбалансированный двуручный клинок более 4х футов длинной: двуручные мечи, полуторники, цвайхандеры и т.п. \
		Этот навык также включает в себя посохи, которые подобно мечам и бастардам, катанам и полуторникам используют двумя руками"
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_FORCESWORD = -4,
		SKILL_LONGSWORD = -4,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/longsword
	name = "Длинный меч"
	desc = "Любой сбалансированный меч, длинною от 0,6 до 1,2 метра, и удерживаемый одной рукой – палаш, кавалерийская сабля, \
			скимитар и т.п. Этот навык также включает палки или дубины со схожим размером."
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_SWORD_TWOHANDED = -4,
		SKILL_FORCESWORD = -4,
		SKILL_RAPIER = -4,
		SKILL_SHORTSWORD = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/shortsword
	name = "Короткий меч"
	desc = "Любой сбалансированный меч, хват которого осуществляется одной рукой, а длина оружия от 0,3 до 0,6 метра – \
			Этот навык также включает в себя короткий меч и любую дубинку сопоставимого размера и баланса (например, полицейскую дубинку)."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_FORCESWORD = -4,
		SKILL_RAPIER = -4,
		SKILL_KNIFE = -4,
		SKILL_LONGSWORD = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/knife
	name = "Нож"
	desc = "Любой жесткий клинок с рукоятью длиной менее одного фута, от карманного и до ножа Боуи. \
			Т.к. у ножей очень маленькая поверхность парирования, то парирование получает штраф в -1 к показателю."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_FORCESWORD = -3,
		SKILL_SHORTSWORD = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
