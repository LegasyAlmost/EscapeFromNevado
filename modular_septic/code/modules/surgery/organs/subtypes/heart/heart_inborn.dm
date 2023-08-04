/obj/item/organ/heart/inborn
	name = "putrid heart"
	desc = "A disgusting, barely recognizable mockery of a heart."
	icon_state = "heart-inborn"
	food_reagents = list( //STIMMING
		/datum/reagent/drug/methylenedioxymethamphetamine = 30,
		/datum/reagent/drug/carbonylmethamphetamine = 10,
		/datum/reagent/drug/lean = 20,
	)
	reagent_vol = 60

// inborn hearts are just that good
/obj/item/organ/heart/inborn/can_stop()
	return FALSE
