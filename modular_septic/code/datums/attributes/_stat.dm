/datum/attribute/stat
	/// Used when space is too valuable to write a full word
	var/shorthand = "FK"

/datum/attribute/stat/description_from_level(level)
	switch(CEILING(level, 1))
		if(-INFINITY to 6)
			return "ужасающе фигово"
		if(7)
			return "плохо"
		if(8,9)
			return "ниже среднего"
		if(10)
			return "среднее"
		if(11,12)
			return "выше среднего"
		if(13,14)
			return "наделённый"
		if(15,16)
			return "замечательный"
		if(17,18)
			return "невероятный"
		if(19,20)
			return "легендарный"
		if(21 to INFINITY)
			return "мифический"
		else
			return "неккоректное значение"
