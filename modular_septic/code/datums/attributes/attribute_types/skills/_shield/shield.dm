/**
 * SHIELD
 *
 *
 * This is the ability to use a shield, both to block and to attack.
 * Your active defense with any kind of shield – your Block score – is (skill/2) + 3, rounded down.
 */
/datum/attribute/skill/shield
	name = "Щиты"
	desc = "Каждый щит привязан плотно к владельцу. \
			Преимущество таких щитов в том, что в руке, которой вы пользуетесь, можно что-то держать (но не владеть), \
			но недостаток в том, что их трудно надевать и снимать."
	icon_state = "block"
	category = SKILL_CATEGORY_BLOCKING
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_BUCKLER = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/buckler
	name = "Баклеры"
	desc = "Любой тип щита, который необходимо удерживать в свободной руке. \
			Занимает одну руку, следовательно легко надевать и снимать. А ещё они лёгкие."
	icon_state = "block"
	category = SKILL_CATEGORY_BLOCKING
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_SHIELD = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/force_shield
	name = "Силовой щит"
	desc = "Любой щит с блокирующей \"поверхностью\", образованной из жидкости, газа или плазмы, а не из твердого вещества."
	icon_state = "block"
	category = SKILL_CATEGORY_BLOCKING
	default_attributes = list(
		STAT_DEXTERITY = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
