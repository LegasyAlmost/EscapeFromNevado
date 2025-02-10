/obj/item/organ/stomach
	name = "желудок"
	icon_state = "stomach"
	desc = "Желудок, переваривает пищу."
	attack_verb_continuous = list("gores", "squishes", "slaps", "digests")
	attack_verb_simple = list("gore", "squish", "slap", "digest")

	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_PRECISE_VITALS
	organ_efficiency = list(ORGAN_SLOT_STOMACH = 100)

	healing_factor = STANDARD_ORGAN_HEALING

	low_threshold_passed = span_info("В животе вспыхивает боль, прежде чем утихнуть. Еду лучше не есть, пока что.")
	high_threshold_passed = span_warning("Мой желудок резко заболел! Нахер пищу!")
	high_threshold_cleared = span_info("Боль в животе на время утихает, но идея употребления чего-то съестного по-прежнему кажется сомнительной.")
	low_threshold_cleared = span_info("Приступы боли в моем животе прекратились.")

	food_reagents = list(
		/datum/reagent/consumable/nutriment/organ_tissue = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin/acid = 5,
	)
	// This is a reagent user and needs more then the 15u from edible component
	reagent_vol = 140 //125u of stuff max

	// This volume may seem misleading, but the human stomach is about the size of a fist most of the time
	organ_volume = 1
	max_blood_storage = 20
	current_blood = 20
	blood_req = 4
	oxygen_req = 4
	nutriment_req = 3
	hydration_req = 4

	/// The rate that disgust decays
	var/disgust_metabolism = 1

	/// The rate that the stomach will transfer reagents to the body
	var/metabolism_efficiency = 0.05 // the lowest we should go is 0.05

/obj/item/organ/stomach/Initialize()
	. = ..()
	//None edible organs do not get a reagent holder by default
	if(!reagents)
		create_reagents(reagent_vol, REAGENT_HOLDER_ALIVE)
	else
		reagents.flags |= REAGENT_HOLDER_ALIVE

/obj/item/organ/stomach/get_availability(datum/species/S)
	return !(NOSTOMACH in S.species_traits)
