/obj/item/organ/heart/inborn
	name = "putrid heart"
	desc = "A disgusting, barely recognizable mockery of a heart."
	food_reagents = list(
		/datum/reagent/drug/methylenedioxymethamphetamine = 30,
		/datum/reagent/drug/lean = 20,
	)
	reagent_vol = 50

// inborn hearts are just that good
/obj/item/organ/heart/inborn/can_stop()
	return FALSE
