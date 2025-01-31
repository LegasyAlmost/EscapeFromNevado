/** BRUISES **/
/datum/injury/bruise
	bleed_threshold = 20
	autoheal_cutoff = 30
	damage_type = WOUND_BLUNT

/datum/injury/bruise/small
	stages = list(
		"малая рана" = 15,
		"синяки" = 10,
		"царапина" = 5,
		"гематома" = 0
		)

/datum/injury/bruise/moderate
	stages = list(
		"рана" = 25,
		"малая рана" = 20,
		"небольшие ушибы" = 15,
		"множество синяков" = 10,
		"зажившие царапины" = 5,
		"гематома" = 0
		)
	max_bleeding_stage = 2

/datum/injury/bruise/large
	stages = list(
		"множество ран" = 50,
		"рана" = 30,
		"малая рана" = 20,
		"небольшие ушибы" = 15,
		"множество синяков" = 10,
		"зажившие царапины" = 5,
		"гематома" = 0
		)
	max_bleeding_stage = 3
	fade_away_time = INFINITY

/datum/injury/bruise/huge
	stages = list(
		"огромные раны" = 80,
		"множество ран" = 50,
		"рана" = 30,
		"малая рана" = 20,
		"большие ушибы" = 15,
		"множество синяков" = 10,
		"едва зажившие царапины" = 5,
		"несколько гематом" = 0
		)
	max_bleeding_stage = 4
	fade_away_time = INFINITY

/datum/injury/bruise/monumental
	stages = list(
		"раны, ссадины и порезы" = 80,
		"огромные раны" = 50,
		"множество ран" = 30,
		"большой ушиб" = 20,
		"множество синяков" = 15,
		"множество ушибов" = 10,
		"царапины" = 5,
		"большая гематома" = 0
		)
	max_bleeding_stage = 4
	fade_away_time = INFINITY
