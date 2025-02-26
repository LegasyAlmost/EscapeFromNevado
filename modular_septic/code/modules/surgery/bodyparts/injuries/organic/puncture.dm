/** PUNCTURES **/
/datum/injury/puncture
	bleed_threshold = 10
	damage_type = WOUND_PIERCE

/datum/injury/puncture/can_worsen(damage_type, damage)
	return FALSE //cannot be enlargened

/datum/injury/puncture/small
	max_bleeding_stage = 2
	stages = list(
		"прокол" = 5,
		"заживающий прокол" = 2,
		"маленький круглый струп" = 0
		)

/datum/injury/puncture/flesh
	max_bleeding_stage = 2
	stages = list(
		"колотая рана" = 15,
		"круглый сгусток, пропитанный кровью" = 5,
		"большой шрам" = 2,
		"маленький круглый шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/gaping
	max_bleeding_stage = 3
	stages = list(
		"зияющая дыра" = 30,
		"большой круглый сгусток, пропитанный кровью" = 15,
		"круглый сгусток, пропитанный кровью" = 10,
		"маленький круглый рассеченный шрам" = 5,
		"маленький круглый шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/gaping_big
	max_bleeding_stage = 3
	stages = list(
		"большая зияющая дыра" = 50,
		"заживающая зияющая дыра" = 20,
		"большой круглый сгусток, пропитанный кровью" = 15,
		"круглый рассеченный сгусток, пропитанный кровью" = 10,
		"крупный круглый шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/massive
	max_bleeding_stage = 3
	stages = list(
		"огромная дыра" = 60,
		"огромная заживающая дыра" = 30,
		"огромный круглый сгусток, пропитанный кровью" = 25,
		"огромный круглый рассеченный шрам" = 10,
		"огромный круглый зазубренный шрам" = 0
		)
	fade_away_time = INFINITY
