/datum/species/madness
	name = "MADNESS"
	id = SPECIES_MADNESS
	default_color = "#4B4B4B"
	sexes = FALSE
	species_traits = list(
		AGENDER,
        NOEYESPRITES,
		NO_UNDERWEAR,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		MOB_HUMANOID
	)
	disliked_food = GROSS | RAW | CLOTH
	liked_food = JUNKFOOD | FRIED
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	limbs_id = "human"
	limbs_icon = DEFAULT_BODYPART_ICON_ORGANIC //Эту строчку изменить на путь с требуемыми спрайтами конечностей. Пример limbs_icon = 'modular_septic/icons/mob/human/species/human/creepypasta_parts.dmi'


/datum/species/madness/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	..()
	if(!istype(C, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/H = C
	var/answer = tgui_input_list(H, "Выбор клана", "Выбери свой клан", list("Умные и сильные Горки", "Ловкие и выносливые Морки"), timeout = 20 SECONDS)
	if(!answer)
		answer = pick("Ловкие и выносливые Морки", "Умные и сильные Горки")
	switch(answer)
		if("Ловкие и выносливые Морки")
			H.attributes.add_sheet(/datum/attribute_holder/sheet/madness_mork)
		if("Умные и сильные Горки")
			H.attributes.add_sheet(/datum/attribute_holder/sheet/madness_gork)
