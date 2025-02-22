/**
 * POLE WEAPONS
 *
 * Pole weapons are long (usually wooden) shafts, often adorned with striking heads. All require two hands.
 */
/datum/attribute/skill/polearm
	name = "Древковое"
	desc = "Любое очень длинное (более 2 метров) несбалансированное древковое оружие с тяжелой ударной головкой, включая глефу, алебарду, секиру и бесчисленное множество других. \
			Чтоб ударить древковым повторно после атаки, нужно подождать, но не при парировании."
	icon_state = "spear"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_IMPACT_WEAPON_TWOHANDED = -4,
		SKILL_SPEAR = -4,
		SKILL_STAFF = -4,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/spear
	name = "Копья"
	desc = "Любое длинное, но сбалансированное древковое оружие и пронзающее. \
		Этот навык включает в себя копья, метательные копья, трезубцы и установленные штыки."
	icon_state = "spear"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_POLEARM = -4,
		SKILL_STAFF = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/staff
	name = "Посохи"
	desc = "Любое длинное, полностью сбалансированное оружие без конкретных точек для нанесения увечий. \
			Этот навык позволяет эффективно использовать обширную поверхность посоха для защиты, давая +2 к показателю парирования."
	icon_state = "blunt"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_POLEARM = -4,
		SKILL_STAFF = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
