/mob/living/carbon/examine(mob/user)
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
//	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()

	. = list("<span class='info'>*---------*\nЭто [icon2html(src, user)] <EM>[src]</EM>!")
	var/obscured = check_obscured_slots()

	if (handcuffed)
		. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] закован!")
	if (head)
		. += "[t_He] [t_is] носит [head.get_examine_string(user)] на [t_his] голове. "
	if(wear_mask && !(obscured & ITEM_SLOT_MASK))
		. += "[t_He] [t_is] носит [wear_mask.get_examine_string(user)] на [t_his] лице."
	if(wear_neck && !(obscured & ITEM_SLOT_NECK))
		. += "[t_He] [t_is] обвязал [wear_neck.get_examine_string(user)] вокруг [t_his] шеи."

	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] держит [I.get_examine_string(user)] в [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	if (back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] на [t_his] спине."
	var/appears_dead = FALSE
	if (stat == DEAD)
		appears_dead = TRUE
		if(getorgan(/obj/item/organ/brain))
			. += span_deadsay("[t_He] [t_is] бледный и тихий. Он не подаёт признаков жизни.")
		else if(get_bodypart(BODY_ZONE_HEAD))
			. += span_deadsay("Кажется, [t_his] мозг не на месте... Его нет!")

	var/list/msg = list("<span class='warning'>")
	var/list/missing = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	var/list/disabled = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.bodypart_disabled)
			disabled += BP
		missing -= BP.body_zone
		for(var/obj/item/I in BP.embedded_objects)
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] [icon2html(I, user)] [I] крепко застряло в [t_his] [BP.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] [icon2html(I, user)] [I] конкретно так застряло в [t_his] [BP.name]!</B>\n"
		for(var/i in BP.wounds)
			var/datum/wound/W = i
			msg += "[W.get_examine_description(user)]\n"

	for(var/X in disabled)
		var/obj/item/bodypart/BP = X
		var/damage_text
		if(!(BP.get_damage(include_stamina = FALSE) >= BP.max_damage)) //Stamina is disabling the limb
			damage_text = "бледный и безжизненный"
		else
			damage_text = (BP.brute_dam >= BP.burn_dam) ? BP.heavy_brute_msg : BP.heavy_burn_msg
		msg += "<B>[capitalize(t_his)] [BP.name] оценивается, примерно, в [damage_text]!</B>\n"

	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "[span_deadsay("<B>[t_His] [parse_zone(t)] отсутствует!</B>")]\n"
			continue
		msg += "[span_warning("<B>[t_His] [parse_zone(t)] отсутствует!</B>")]\n"


	var/temp = getBruteLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_He] имеет небольшие увечья.\n"
			else if (temp < 50)
				msg += "[t_He] имеет <b>серьёзно</b> побит!\n"
			else
				msg += "<B>[t_He] с ног до головы избит!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_He] имеет небольшие ожоги.\n"
			else if (temp < 50)
				msg += "[t_He] имеет <b>значительные</b> ожоги!\n"
			else
				msg += "<B>[t_He] полностью обгоревший!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] имеет небольшую внешнию деформацию.\n"
			else if (temp < 50)
				msg += "[t_He] имеет <b>серьёзно</b> дефомарцию!\n"
			else
				msg += "<b>[t_He] полностью деформирован!</b>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_He] выглядит достаточно тупо.\n"

	if(fire_stacks > 0)
		msg += "[t_He] покрыты чем-то горючим.\n"
	if(fire_stacks < 0)
		if(FEMALE)
			msg += "[t_He] выглядит промокшей.\n"
		else
			msg += "[t_He] выглядит промокшим.\n"


	if(pulledby?.grab_state)
		msg += "[t_He] находится в захвате у [pulledby].\n"

	var/scar_severity = 0
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			scar_severity += S.severity

	switch(scar_severity)
		if(1 to 4)
			msg += "[span_tinynoticeital("У [t_He] виднеются шрамы, подойдя ближе Вы могли бы осмотреть их...")]\n"
		if(5 to 8)
			msg += "[span_smallnoticeital("У [t_He] виднеются значительные шрамы, подойдя ближе Вы могли бы осмотреть их...")]\n"
		if(9 to 11)
			msg += "[span_notice("<i>У [t_He] виднеются значительное и повсеместное шрамирование, подойдя ближе Вы могли бы осмотреть их...</i>")]\n"
		if(12 to INFINITY)
			msg += "[span_notice("<b><i>[t_He] полностью покрыто всё огромными и вездесущими шрамами, подойдя ближе вы могли бы осмотреть их...</i></b>")]\n"

	msg += "</span>"

	. += msg.Join("")

	if(!appears_dead)
		switch(stat)
			if(SOFT_CRIT)
				. += "У [t_His] дыхание быстрое и затрудненное."
			if(UNCONSCIOUS, HARD_CRIT)
				. += "[t_He] выглядит словно не придавая значению окружающему его пространству. Кажись, [t_He] спит или без сознания."

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.shown_mood)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				. += "[t_He] выглядит, словно мир для него - говно ебучее."
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				. += "[t_He] выглядит крайне опечаленным."
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				. += "[t_He] выглядит расстроенным."
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				. += "[t_He] выглядит слегка счастливым."
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				. += "[t_He] выглядит очень радостным."
			if(MOOD_LEVEL_HAPPY4 to INFINITY)
				. += "[t_He] выглядит, словно находится в состоянии экстаза."
	. += "*---------*</span>"

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)
/* SEPTIC EDIT REMOVAL
/mob/living/carbon/examine_more(mob/user)
	if(!all_scars)
		return ..()

	var/list/visible_scars
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			LAZYADD(visible_scars, S)

	if(!visible_scars)
		return ..()

	var/msg = list(span_notice("<i>You examine [src] closer, and note the following...</i>"))
	for(var/i in visible_scars)
		var/datum/scar/S = i
		var/scar_text = S.get_examine_description(user)
		if(scar_text)
			msg += "[scar_text]"

	return msg
*/
