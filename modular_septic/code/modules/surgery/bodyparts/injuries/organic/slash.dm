/** SLASHES **/
/datum/injury/slash
	bleed_threshold = 5
	damage_type = WOUND_SLASH

/datum/injury/slash/small
	// link wound descriptions to amounts of damage
	// Minor cuts have max_bleeding_stage set to the stage that bears the wound type's name.
	// The major cut types have the max_bleeding_stage set to the clot stage (which is accordingly given the "blood soaked" descriptor).
	max_bleeding_stage = 3
	stages = list(
		"уродливый рваный порез" = 20,
		"рваный порез" = 10,
		"порез" = 5,
		"заживающий порез" = 2,
		"небольшая корка" = 0
		)

/datum/injury/slash/deep
	max_bleeding_stage = 3
	stages = list(
		"уродливый глубокий рваный порез" = 25,
		"глубокий рваный порез" = 20,
		"глубокий порез" = 15,
		"свернувшийся порез" = 8,
		"корка" = 2,
		"свежий шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/flesh
	max_bleeding_stage = 4
	stages = list(
		"уродливая рваная рана на коже" = 35,
		"уродливая рана на коже" = 30,
		"поверхностная рана" = 25,
		"пропитанный кровью сгусток" = 15,
		"большая короста" = 5,
		"свежий шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/gaping
	max_bleeding_stage = 3
	stages = list(
		"зияющая рана" = 50,
		"большой пропитанный кровью сгусток" = 25,
		"пропитанный кровью сгусток" = 15,
		"маленький рассеченный шрам" = 5,
		"маленький прямой шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/gaping_big
	max_bleeding_stage = 3
	stages = list(
		"большая зияющая рана" = 60,
		"заживающая зияющая рана" = 40,
		"большой пропитанный кровью сгусток" = 25,
		"большой рассеченный шрам" = 10,
		"большой ровный шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/massive
	max_bleeding_stage = 3
	stages = list(
		"обширная рана" = 70,
		"обширная заживающая рана" = 50,
		"массивный, пропитанный кровью сгусток" = 25,
		"огромный рассеченный шрам" = 10,
		"огромный неровный шрам" = 0
		)
	fade_away_time = INFINITY
