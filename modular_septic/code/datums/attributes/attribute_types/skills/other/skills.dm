// General combat skills
/datum/attribute/skill/acrobatics
	name = "Акробатика"
	desc = "Способность к взбиранию на вершины и изнуряющим манёврам."
	icon_state = "acrobatics"
	category = SKILL_CATEGORY_COMBAT
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Skulduggery skills
/datum/attribute/skill/pickpocket
	name = "Воровство"
	desc = "Умение к скрытому хищению средств с карман."
	icon_state = "sneak"
	category = SKILL_CATEGORY_SKULDUGGERY
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/lockpicking
	name = "Взлом"
	desc = "Умение взламывать механизмы."
	icon_state = "lockpicking"
	category = SKILL_CATEGORY_SKULDUGGERY
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/forensics
	name = "Криминалистика"
	desc = "Умение анализировать улики и следы врагов."
	icon_state = "illusion"
	category = SKILL_CATEGORY_SKULDUGGERY
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_PERCEPTION = -6,
	)
	difficulty = SKILL_DIFFICULTY_EASY

// Medical skills
/datum/attribute/skill/medicine
	name = "Врачевание"
	desc = "Умение определять и вылечивать различные физические травмы, а также успешно пользоваться медицинским оборудованием"
	icon_state = "restoration"
	category = SKILL_CATEGORY_MEDICAL
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/surgery
	name = "Хирургия"
	desc = "Знание анатомии и, соответственно, умение пользоваться хирургическими инструментами."
	icon_state = "alteration"
	category = SKILL_CATEGORY_MEDICAL
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		SKILL_MEDICINE = -8,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Engineering skills
/datum/attribute/skill/masonry
	name = "Каменное дело"
	desc = "Способность работать по камню, делать из камня."
	icon_state = "smithing"
	category = SKILL_CATEGORY_ENGINEERING
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/smithing
	name = "Кузнечное дело"
	desc = "Способность ковать из металла: оружие, броню и иные предметы."
	icon_state = "smithing"
	category = SKILL_CATEGORY_ENGINEERING
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/electronics
	name = "Электрическое дело"
	desc = "Способность работать с электрическими приборами: их взлом, починка и проводка."
	icon_state = "smithing"
	category = SKILL_CATEGORY_ENGINEERING
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

// Research skills
/datum/attribute/skill/science
	name = "Научное дело"
	desc = "Способность к комплексной работе со сложными приборами, их исследование и создание новых."
	icon_state = "mysticism"
	category = SKILL_CATEGORY_RESEARCH
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/chemistry
	name = "Химическое дело"
	desc = "Способность к варке различных веществ из таблицы периодической системы химической Д. И. Менделеева."
	icon_state = "alchemy"
	category = SKILL_CATEGORY_RESEARCH
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Domestic skills
/datum/attribute/skill/culinary
	name = "Кулинария"
	desc = "Способность к готовке."
	icon_state = "alchemy"
	category = SKILL_CATEGORY_DOMESTIC
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
		SKILL_CLEANING = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/agriculture
	name = "Сельское хозяйство"
	desc = "Способность к выращиванию растений и сбора их урожая."
	icon_state = "alchemy"
	category = SKILL_CATEGORY_DOMESTIC
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/cleaning
	name = "Уборка"
	desc = "Способность к бытию горничной. Ну то есть поддержание очага: в чистоте - в порядке."
	icon_state = "athletics"
	category = SKILL_CATEGORY_DOMESTIC
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY

// Dumb meme skills
/datum/attribute/skill/gaming
	name = "Гейминг"
	desc = "Способность к игре. Да, играть внутри игры в игру. Как в думе. \
		Применяется как к настольным, так и компьютерным."
	icon_state = "unarmored"
	category = SKILL_CATEGORY_DUMB
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
