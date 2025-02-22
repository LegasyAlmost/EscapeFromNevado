/datum/attribute/stat/strength
	name = "Сила"
	shorthand = "ST"
	desc = "Сила определяет вес, который ты способен переносить и на силу твоих ударов. \
		Параметр настоящих викингов."
	icon_state = "strength"

/datum/attribute/stat/dexterity
	name = "Ловкость"
	shorthand = "DX"
	desc = "Ловкость определяет твои рефлексы и равновесие, позволяя точнее наносить удары, а также уклоняться от них. \
		Параметр воров."
	icon_state = "dexterity"

/datum/attribute/stat/endurance
	name = "Выносливость"
	shorthand = "ED"
	desc = "Выносливость определяет твою способность терпеться с болью, болезнями и подобными недугами. \
		Параметр мазохиста."
	icon_state = "endurance"

/datum/attribute/stat/intelligence
	name = "Интеллект"
	shorthand = "IQ"
	desc = "Интеллект определяет твою способность выполнять сложные задачи и запоминать информацию. \
		Параметр студента."
	icon_state = "intelligence"

//i had to
/datum/attribute/stat/intelligence/description_from_level(level)
	switch(CEILING(level, 1))
		if(-INFINITY to 6)
			return "деградирован"
		if(7)
			return "плохо"
		if(8,9)
			return "ниже среднего"
		if(10)
			return "средний"
		if(11,12)
			return "выше среднего"
		if(13,14)
			return "способный"
		if(15,16)
			return "хороший"
		if(17,18)
			return "невероятный"
		if(19,20)
			return "легендарный"
		if(21 to INFINITY)
			return "просвещённый"
		else
			return "недопустимое значение"

/datum/attribute/stat/perception
	name = "Восприятие"
	shorthand = "PR"
	desc = "Восприятие определяет твою общую бдительность. \
		Параметр детективов."
	icon_state = "perception"

/datum/attribute/stat/will
	name = "Воля"
	shorthand = "WL"
	desc = "Воля определяет твою способность противостоять психологическому стрессу и \
		защиту от сверхествественного. \
		Параметр священника."
	icon_state = "willpower"
