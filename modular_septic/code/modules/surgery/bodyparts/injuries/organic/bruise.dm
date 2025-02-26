/** BRUISES **/
/datum/injury/bruise
	bleed_threshold = 20
	autoheal_cutoff = 30
	damage_type = WOUND_BLUNT

/datum/injury/bruise/small
	stages = list(
		"шишка" = 15,
		"синяк" = 10,
		"царапина" = 5,
		"гематома" = 0
		)

/datum/injury/bruise/moderate
	stages = list(
		"шишки" = 25,
		"синяки" = 20,
		"небольшие ушибы" = 15,
		"большой синяк" = 10,
		"царапины" = 5,
		"гематома" = 0
		)
	max_bleeding_stage = 2

/datum/injury/bruise/large
	stages = list(
		"ранка" = 50,
		"кровавый подтёк" = 30,
		"синяки" = 20,
		"небольшие ушибы" = 15,
		"шишки" = 10,
		"множество царапин" = 5,
		"гематомы" = 0
		)
	max_bleeding_stage = 3
	fade_away_time = INFINITY

/datum/injury/bruise/huge
	stages = list(
		"значительные гематомы, синяки и красные подтёки" = 80,
		"несколько кровавых подтёков" = 50,
		"средний кровавый подтёк" = 30,
		"небольшой кровавый подтёк" = 20,
		"множество ушибов" = 15,
		"много синяков" = 10,
		"едва затянувшиеся царапины" = 5,
		"несколько гематом" = 0
		)
	max_bleeding_stage = 4
	fade_away_time = INFINITY

/datum/injury/bruise/monumental
	stages = list(
		"синяки, ссадины, красные подтёки и гематомы" = 80,
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
