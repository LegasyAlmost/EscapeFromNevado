// Nice examine stuff
/obj/item/examine_chaser(mob/user)
	. = list()
	var/p_They = p_they(TRUE)
	var/p_they = p_they()
	var/p_Theyre = p_theyre(TRUE)
	var/p_are = p_are()
	var/p_s = p_s()

	switch(germ_level)
		if(0 to GERM_LEVEL_DIRTY)
			. += "[p_They] чист."
		if(GERM_LEVEL_DIRTY to GERM_LEVEL_FILTHY)
			. += "[p_They] покрыт слоем слякоти."
		if(GERM_LEVEL_FILTHY to GERM_LEVEL_SMASHPLAYER)
			. += span_warning("[p_They] [p_are] грязный.")
		if(GERM_LEVEL_SMASHPLAYER to INFINITY)
			. += span_warning("[p_They] весь в <b>грязище</b>!")

	var/weight_text = weight_class_to_text(w_class)
	. += "[p_Theyre] [prefix_a_or_an(weight_text)] [weight_text] item."
	if(isobserver(user))
		. += "[p_They] weigh[p_s] exactly <b>[get_carry_weight()]kg</b>."
	else if(user.is_holding(src))
		. += "[p_They] вес ощущается примерно на <b>[round_to_nearest(get_carry_weight(), 1)] килограмм</b>."

	if(resistance_flags & INDESTRUCTIBLE)
		. += "[p_They] кажется достаточно неубиваемым! Выдержит любую хуйню и хуергу!"
	else
		if(resistance_flags & LAVA_PROOF)
			. += "[p_They] сделан из жаростойких материалов, [p_they] уж точно выдержит даже лаву!"
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += "[p_They] сделан из устойчивых к кислотам материалов, [p_they] скорее всего выдержит едкие вещества!"
		if(resistance_flags & FREEZE_PROOF)
			. += "[p_They] сделан из морозостойких материалов."
		if(resistance_flags & FIRE_PROOF)
			. += "[p_They] сделан из огнестойких материалов."

	. += ..()
