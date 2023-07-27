/datum/species/denominator
	name = "Denominator"
	id = SPECIES_DENOMINATOR
	default_color = "#4B4B4B"
	sexes = TRUE
	species_traits = list(
		NO_UNDERWEAR,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutant_bodyparts = list()
	heatmod = 4
	coldmod = 0
	liked_food = VEGETABLES | MEAT //Balanced Diet
	disliked_food = RAW
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "dictates"
	attack_verb = "punch"
	bite_sharpness = SHARP_POINTY
	limbs_id = "human"
	limbs_icon = DEFAULT_BODYPART_ICON_ORGANIC

/datum/species/denominator/random_name(gender, unique, lastname)
	var/final_name = denominator_first()
	if(lastname)
		final_name += " [denominator_last()]"
	return final_name
