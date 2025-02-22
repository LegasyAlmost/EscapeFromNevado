/datum/attribute/skill
	/// Skill category we fall under - DO NOT FORGET TO SET THIS, IT BREAKS SHIT
	var/category = SKILL_CATEGORY_GENERAL
	/**
	 * This is the attribute that governs us.
	 * A person's effective skill will always be primary attribute default value + skill value
	 * The only exception is when we have null (not 0) skill, then we will use a skill default (check holder.dm)
	 */
	var/governing_attribute
	/*
	 * Most skills have a related attribute which gets used on dicerolls when you don't know the skill
	 * This is an associative list of all possible attributes to get a default in return_effective_skill()
	 * Attribute - Modifier to be added to attribute
	 * Remember - Double defaults are not possible!
	 */
	var/list/default_attributes
	/// Difficulty of a skill, mostly a simple indicator for players of how good the defaults are
	var/difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/description_from_level(level)
	if(isnull(level))
		return "не имеет какого-либо опыта"
	switch(CEILING(level, 1))
		if(-INFINITY to 2)
			return "знающий слухи"
		if(3,4)
			return "отдалённо слышающий"
		if(5,6)
			return "теоретик"
		if(7,8)
			return "новичок"
		if(9,10)
			return "начинающий"
		if(11,12)
			return "компетентный"
		if(13,14)
			return "с опытом"
		if(15,16)
			return "средне"
		if(17,18)
			return "эксперт"
		if(19,20)
			return "мастер"
		if(21,22)
			return "легенда"
		if(23 to INFINITY)
			return "мифический"
		else
			return "неккоректное значение"
