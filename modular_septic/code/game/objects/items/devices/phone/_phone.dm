/obj/item/cellphone
	name = "Трубка"
	desc = "Предположительно портативный телефон, который в первую очередь используется для связи, с возможностью совершать как публичные, так и личные звонки из любой точки мира. Связь может отличаться если Вы \
		плотно заперты в сверхъестественном складе с единственным выходом."
	icon = 'modular_septic/icons/obj/items/phone.dmi'
	icon_state = "phone"
	base_icon_state = "phone"
	worn_icon_state = "pda"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID | ITEM_SLOT_BELT
	verb_say = "communicates"
	pickup_sound = 'modular_septic/sound/efn/phone_pickup.ogg'
	equip_sound = 'modular_septic/sound/efn/phone_holster.ogg'
	/// General flags about the state of the phone
	var/phone_flags = PHONE_FLIPHONE
	/// Only matters if phone_flags has PHONE_FLIPHONE enabled
	var/flipped = FALSE
	/// Phone's brand
	var/brand_name = "ULTRABLUE PRINCE"
	/// I have no idea what is planned for this but Remis wanted it
	var/serial_number = ""
	/**
	 * The phone's sim card, without a sim card phones are basically useless bricks
	 * Stores the phone's number, public name AND misc programs
	*/
	var/obj/item/simcard/simcard
	/**
	 * State that specifies how we treat connected_phone
	 * Are we currently in a call with connected_phone?
	 * Are we BEING CALLED by connected_phone?
	 * Are we CALLING connected_phone?
	 * Etc.
	*/
	var/connection_state = CONNECTION_NONE
	/// Phone we are connected to, what the fuck this means depends on connection_state
	var/obj/item/cellphone/connected_phone
	/// Timer for giving up a call with someone
	var/stop_calling_timer

	// SOUNDING
	var/flip_sound = 'modular_septic/sound/efn/phone_flip.ogg'
	var/unflip_sound = 'modular_septic/sound/efn/phone_unflip.ogg'

	// SOUNDING LOOPS
	var/datum/looping_sound/phone_ringtone/ringtone_soundloop
	var/datum/looping_sound/phone_call/call_soundloop
	var/datum/looping_sound/phone_glitch/glitch_soundloop

/obj/item/cellphone/Initialize(mapload)
	. = ..()
	call_soundloop = new(src, FALSE)
	ringtone_soundloop = new(src, FALSE)
	glitch_soundloop = new(src, FALSE)
	var/list/characters = GLOB.alphabet_upper | GLOB.numerals
	serial_number = random_string(8, characters)
	name = "\proper [random_adjective()] ([rand(0,9)][rand(0,9)]) [initial(name)]"
	if(ispath(simcard, /obj/item/simcard))
		install_simcard(new simcard(src))
	become_hearing_sensitive(trait_source = ROUNDSTART_TRAIT)
	update_appearance()

/obj/item/cellphone/Destroy()
	. = ..()
	terminate_connection()
	if(simcard)
		QDEL_NULL(simcard)
	QDEL_NULL(call_soundloop)
	QDEL_NULL(ringtone_soundloop)
	QDEL_NULL(glitch_soundloop)

/obj/item/cellphone/update_overlays()
	. = ..()
	if(phone_flags & PHONE_FLIPHONE)
		. += (flipped ? "[base_icon_state]_door_open" : "[base_icon_state]_door")
	if(!((phone_flags & PHONE_FLIPHONE) && (phone_flags & PHONE_NO_UNFLIPPED_SCREEN) && !flipped))
		if(phone_flags & PHONE_RESETTING)
			. += "[base_icon_state]_resetting"
		else if(phone_flags & PHONE_GLITCHING)
			. += "[base_icon_state]_glitch"
		else if(simcard)
			switch(connection_state)
				if(CONNECTION_ACTIVE_CALL)
					. += "[base_icon_state]_paired"
				if(CONNECTION_CALLING, CONNECTION_BEING_CALLED)
					. += "[base_icon_state]_ringring"
				else
					. += "[base_icon_state]_active"

/obj/item/cellphone/examine(mob/user)
	. = ..()
	if(!simcard)
		. += span_warning("Из-за того, что в трубке нет симки, то пользование [p_them()] достаточно бесполезное действие.")
	else
		. += span_info("[src] уже имеет [icon2html(simcard, user)] <b>[simcard]</b> установленную в соответствующий слот.")
	if(phone_flags & PHONE_RESETTING)
		. += span_warning("[src] [p_are()] сбрасывается к заводским настройкам.")
	if(connected_phone)
		switch(connection_state)
			if(CONNECTION_ACTIVE_CALL)
				. += span_info("Прямо сейчас разговаривает с <b>[connected_phone.simcard.username]</b>.")
			if(CONNECTION_BEING_CALLED)
				. += span_info("Ждёт ответа на звонок от <b>[connected_phone.simcard.username]</b>.")
			if(CONNECTION_CALLING)
				. += span_info("Звонит <b>[connected_phone.simcard.username]</b>.")
	if(!simcard.username)
		. += span_warning("[simcard]] Нету псевдонима пользователя.")
	else
		. += span_info("<b>Псевдоним:</b> [simcard.username]")
	. += span_info("<b>Номер телдефона:</b> [simcard.phone_number]")
	. += span_info("Правая кнопка (ПКМ) для настроек телефона. Левая кнопка (ЛКМ), чтобы позвонить.")

/obj/item/cellphone/attack_self(mob/user, modifiers)
	. = ..()
	if((phone_flags & PHONE_FLIPHONE) && !flipped)
		to_chat(user, span_warning("[p_they(TRUE)] [p_are()] не раскрыт. (CTRL-ЛКМ)"))
		return
	if(phone_flags & PHONE_RESETTING)
		to_chat(user, span_warning("[fail_msg(TRUE)] [p_they(TRUE)] [p_are()] сбрасывается к заводским настройкам."))
		return
	if(phone_flags & PHONE_GLITCHING)
		to_chat(user, span_warning("[fail_msg(TRUE)] Что-то глючит в [p_them()]."))
		return
	if(!simcard)
		var/obj/item/simcard/fake_simcard
		var/image/simcard_image = image(initial(fake_simcard.icon), initial(fake_simcard.icon_state))
		to_chat(user, span_warning("[fail_msg(TRUE)] Нет [icon2html(simcard_image, user)] <b>симки</b>."))
		return
	if(!simcard.username)
		to_chat(user, span_warning("[fail_msg(TRUE)] [icon2html(simcard, user)] [simcard] необходимо поставить псевдоним пользователя."))
		return
	switch(connection_state)
		if(CONNECTION_BEING_CALLED)
			accept_call(user)
			return
		if(CONNECTION_CALLING)
			stop_calling(user)
			return
		if(CONNECTION_ACTIVE_CALL)
			hang_up(user)
			return
	if(phone_flags & PHONE_RECEIVING_INPUT)
		return
	INVOKE_ASYNC(src, PROC_REF(dial_menu), user)

/obj/item/cellphone/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if((phone_flags & PHONE_FLIPHONE) && !flipped)
		to_chat(user, span_warning("[p_they(TRUE)] [p_are()] не раскрыт. (CTRL-ЛКМ)"))
		return
	if(phone_flags & PHONE_RESETTING)
		to_chat(user, span_warning("[fail_msg(TRUE)] [p_they(TRUE)] [p_are()] сбрасывается к заводским настройкам."))
		return
	if(phone_flags & PHONE_GLITCHING)
		to_chat(user, span_warning("[fail_msg(TRUE)] Что-то глючит в [p_them()]."))
		return
	if(!simcard)
		var/obj/item/simcard/fake_simcard
		var/image/simcard_image = image(initial(fake_simcard.icon), initial(fake_simcard.icon_state))
		to_chat(user, span_warning("[fail_msg(TRUE)] Нет [icon2html(simcard_image, user)] <b>симки</b>."))
		return
	switch(connection_state)
		if(CONNECTION_BEING_CALLED)
			reject_call()
			return
		if(CONNECTION_CALLING)
			stop_calling()
			return
		if(CONNECTION_ACTIVE_CALL)
			hang_up()
			return
	if(phone_flags & PHONE_RECEIVING_INPUT)
		return
	INVOKE_ASYNC(src, PROC_REF(options_menu), user)

/obj/item/cellphone/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/simcard))
		if(simcard)
			to_chat(user, span_warning("[fail_msg(TRUE)] Тут уже установленна [icon2html(simcard, user)] <b>[simcard]</b> внутри трубки."))
			return
		var/obj/item/simcard/simpsons_card = attacking_item
		if(user.transferItemToLoc(simpsons_card, src))
			to_chat(user, span_notice("Я осторожно установил [icon2html(simpsons_card, user)] <b>[simpsons_card]</b> в разъём под симку на трубке."))
			playsound(src, 'modular_septic/sound/efn/phone_simcard_insert.ogg', 65, FALSE)
			install_simcard(simpsons_card, user)
			//sound_hint()
	if(istype(attacking_item, /obj/item/cellphone))
		var/obj/item/cellphone/attacker_cellphone = attacking_item
		var/datum/simcard_application/hacking/hacking_application = locate(/datum/simcard_application/hacking) in attacker_cellphone.simcard?.applications
		to_chat(user, span_notice("Я нажал на [attacker_cellphone] на своей трубке. <b>Клик!</b> Клёво!"))
		playsound(src, 'modular_septic/sound/efn/clink_so_nice.ogg', 35, FALSE, 1)
		if(!simcard) //HOW!
			return
		if(hacking_application)
			hacking_application.level_progress += simcard.binary_essence
			hacking_application.check_level_up(user)
			audible_message(span_boldwarning("[user] взламывает!"))
			terminate_connection()
			simcard.fry(silent = FALSE)
			simcard = null
			update_appearance()

/obj/item/cellphone/AltClick(mob/user)
	. = ..()
	if(!simcard)
		to_chat(user, span_warning("[fail_msg(TRUE)] Чё за симкарта?"))
		return
	if((connection_state == CONNECTION_CALLING) || (connection_state == CONNECTION_BEING_CALLED))
		to_chat(user, span_warning("Мне нужно сначала ответить."))
		return
	var/obj/item/simcard/simpsons_card = simcard
	if(user.transferItemToLoc(simpsons_card, user.loc))
		to_chat(user, span_notice("Я осторожно достал [simpsons_card] из слота под симки моей трубки."))
		playsound(src, 'modular_septic/sound/efn/phone_simcard_desert.ogg', 65, FALSE)
		uninstall_simcard(user)
		//sound_hint()

/obj/item/cellphone/CtrlClick(mob/user)
	. = ..()
	var/mob/living/living_user = user
	if(!istype(living_user))
		return
	if(!living_user.is_holding(src))
		return
	if(!(phone_flags & PHONE_FLIPHONE))
		to_chat(user, span_warning("[src] [p_are()] не раскрыт."))
		return
	if((connection_state != CONNECTION_NONE) && (connection_state != CONNECTION_BEING_CALLED))
		to_chat(user, span_warning("Мне нужно сначала ответить."))
		return
	toggle_flip(user)

/obj/item/cellphone/proc/options_menu(mob/living/user)
	var/list/options = list(
		"Отключить родительский контроль",
		"Переключить анонимность",
		"Поменять псевдоним",
		"Поменять рингтон",
		"ПОМОГИТЕ! Я НЕ МОГУ ГОВОРИТЬ",
		"Сброс к заводским настройкам",
	)
	if(!simcard.username)
		options = list("Поставить псевдоним")
	else if(LAZYLEN(simcard.applications))
		options += "Запустить приложение SIM-карты"

	phone_flags |= PHONE_RECEIVING_INPUT

	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(src, random_press_sound, 65, FALSE)
	var/title = "Что сделать?"
	var/message = "Меню настроек"
	var/input = tgui_input_list(user, message, title, options)
	switch(input)
		if("Отключить родительский контроль")
			disable_parental_controls(user)
		if("Переключить анонимность")
			toggle_simcard_publicity(user)
		if("Поменять псевдоним", "Поставить псевдоним")
			change_username(user)
		if("Поменять рингтон")
			ringtone_select(user)
		if("ПОМОГИТЕ! Я НЕ МОГУ ГОВОРИТЬ")
			user_language_help(user)
		if("Сброс к заводским настройкам")
			begin_factory_reset(user)
		if("Запустить приложение SIM-карты")
			application_menu(user)

	phone_flags &= ~PHONE_RECEIVING_INPUT

/obj/item/cellphone/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods)
	. = ..()
	if(!connected_phone || (connection_state != CONNECTION_ACTIVE_CALL))
		return
	if(get_turf(src) != get_turf(speaker))
		return
	var/talking_noise = pick('modular_septic/sound/efn/phone_talk1.ogg', 'modular_septic/sound/efn/phone_talk2.ogg', 'modular_septic/sound/efn/phone_talk3.ogg')
	if(!ishuman(speaker))
		return
	var/mob/living/carbon/human/human_speaker = speaker
	if(istype(human_speaker) && (human_speaker.dna.species.id == SPECIES_INBORN))
		talking_noise = pick('modular_septic/sound/efn/evil_talk1.ogg', 'modular_septic/sound/efn/evil_talk2.ogg', 'modular_septic/sound/efn/evil_talk3.ogg')
	playsound(connected_phone, talking_noise, 18, FALSE, -6)
	if(connected_phone == speaker)
		audible_message(span_warning("[icon2html(src, world)] [src] makes godawful noises as [p_they()] fall[p_s()] into a feedback loop!"))
		connected_phone.audible_message(span_warning("[icon2html(connected_phone, world)] [connected_phone] makes godawful noises as [p_they()] fall[p_s()] into a feedback loop!"))
		return
	connected_phone.audible_message("[icon2html(src, world)] [src] [verb_say], \"[raw_message]\"", hearing_distance = 1)

/obj/item/cellphone/proc/dial_menu(mob/living/user)
	var/list/options = list("Набрать вручную", "База контаков")
	var/mob/living/carbon/human/human_user = user
	if(istype(human_user) && (human_user.dna.species.id == SPECIES_INBORN))
		options = list("SNAPCHAT DMS!!!", "ВСЕМ ДРУЗЬЯШКАМ :)")

	phone_flags |= PHONE_RECEIVING_INPUT

	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(src, random_press_sound, 65, FALSE)
	var/title = "Набрать кому?"
	var/message = "Контакты"
	var/input = tgui_input_list(user, message, title, options)
	switch(input)
		if("Набрать вручную", "SNAPCHAT DMS!!!")
			input = input(user, "Наберите номер.", "Личный звонок")
			if(GLOB.active_simcard_list[input])
				var/obj/item/simcard/friend_card = GLOB.active_simcard_list[input]
				if(!friend_card.parent)
					return
				if(friend_card == simcard)
					to_chat(user, span_warning("Разве это не смешно, если я наберу себе?? \
											Я прошёл сеанс лоботомии. \
											Мой отец обменял меня на хлеб. \
											Чё со мною не так?"))
					return
				start_calling(friend_card.parent)
			else if(input)
				to_chat(user, span_warning("Такого номера нет."))
			else
				to_chat(user, span_warning("Забудь."))
		if("База контаков", "ВСЕМ ДРУЗЬЯШКАМ :)")
			options = GLOB.active_public_simcard_list.Copy()
			options -= simcard.username
			input = tgui_input_list(user, "Кому из?", "База контаков", options)
			if(GLOB.active_public_simcard_list[input])
				var/obj/item/simcard/friend_card = GLOB.active_public_simcard_list[input]
				if(!friend_card.parent)
					return
				var/datum/simcard_application/hacking/hacking_application = locate(/datum/simcard_application/hacking) in simcard?.applications
				if(hacking_application?.unlockable_flags & (HACKER_CAN_DDOS|HACKER_CAN_MINDJACK))
					switch(hacking_application?.unlockable_flags)
						if(HACKER_CAN_VITAL)
							var/obj/item/simcard/scanned_simcard = input
							var/mob/living/carbon/human/vital_human = locate() in get_turf(scanned_simcard)
							var/vital_message = "Этот телефон брошен."
							var/vital_status
							switch(vital_human.stat)
								if(DEAD)
									vital_status = "DEAD"
								if(CONSCIOUS)
									vital_status = "CONSCIOUS"
								if(UNCONSCIOUS)
									vital_status = "UNCONCIOUS"
								else
									vital_status = "CRITICAL"
							if(!isnull(vital_human))
								vital_message = "Этот телефон принадлежит <b>[vital_status]</b> пользователю."
							var/vital_scan_sound = list('modular_septic/sound/efn/hacker_vital_scan1.ogg', 'modular_septic/sound/efn/hacker_vital_scan2.ogg')
							playsound(scanned_simcard, vital_scan_sound, rand(5, 10), FALSE)
							to_chat(user, span_notice("[vital_message]"))
					var/list/hacker_options = list("Позвонить без взлома")
					hacker_options += hacking_application.hacking_additions()
					var/hacker_input = tgui_input_list(user, "ОСОБЫЕ ВОЗМОЖНОСТИ", "ПЕРВОМУ ГАКСТЕРУ ПРИГОТОВИТЬСЯ!", hacker_options)
					switch(hacker_input)
						if("ДДОС")
							if(!friend_card?.parent)
								to_chat(user, span_warning("НЕВЕРНАЯ ЦЕЛЬ!"))
								return
							if(friend_card.parent.phone_flags & PHONE_GLITCHING)
								to_chat(user, span_warning("АТАКА УЖЕ СОВЕРШЕНА!"))
								return
							friend_card?.parent.start_glitching()
							to_chat(user, span_boldnotice("Атака успешна проведена, enjoy."))
							playsound(src, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)
							phone_flags &= ~PHONE_RECEIVING_INPUT
							return
						if("MINDJACK")
							start_calling(friend_card.parent, mindjack = TRUE)
							phone_flags &= ~PHONE_RECEIVING_INPUT
							return
						if("Позвонить без взлома")
							start_calling(friend_card.parent)
							phone_flags &= ~PHONE_RECEIVING_INPUT
							return
				else
					start_calling(friend_card.parent)
			else if(input)
				to_chat(user, span_warning("Такого номера нет."))
			else
				to_chat(user, span_warning("Никого в базе нет, я один. Это печально"))
		else
			to_chat(user, span_warning("Забудь."))

	phone_flags &= ~PHONE_RECEIVING_INPUT

/obj/item/cellphone/proc/accept_call(mob/living/user)
	connected_phone.audible_message("[icon2html(connected_phone, world)] [simcard.username] поднял трубку.", hearing_distance = 1)
	connected_phone.connection_state = CONNECTION_ACTIVE_CALL
	connected_phone.call_soundloop.stop()
	playsound(connected_phone, 'modular_septic/sound/efn/phone_answer.ogg', 65, FALSE)
	connected_phone.update_appearance()

	if(user)
		to_chat(user, span_notice("Я принял звонок. Я разговарию с [connected_phone.simcard.username]."))
	connection_state = CONNECTION_ACTIVE_CALL
	ringtone_soundloop.stop()
	playsound(src, 'modular_septic/sound/efn/phone_answer.ogg', 65, FALSE)
	update_appearance()
	if(phone_flags & PHONE_MINDJACKED)
		if(!ishuman(user))
			return
		phone_flags &= ~PHONE_MINDJACKED
		to_chat(user, span_bigdanger("Я СЛЫШУ КОШМАРНЫЙ ВИЗГ, КОГДА ПОДНОШУ ТЕЛЕФОН К УХУ!!!"))
		user.emote("deathscream")
		user.flash_pain(75)
		do_sparks(6, FALSE, src)
		playsound(src, 'modular_septic/sound/efn/hacker_phone_zap.ogg', 95, FALSE)
		var/datum/simcard_application/hacking/hacking_application = locate(/datum/simcard_application/hacking) in simcard?.applications
		if(hacking_application)
			to_chat(user, span_boldwarning("Брандмауэр останавливает нейронную связь, прежде чем она захватит мой мозг!"))
			playsound(src, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)
			if(connected_phone)
				connected_phone.start_glitching()
			return
		var/mob/living/carbon/poor_sod = user
		var/datum/brain_trauma/severe/earfuck/earfuck = poor_sod.gain_trauma(/datum/brain_trauma/severe/earfuck)
		if(!earfuck)
			return

		var/mob/living/mindjack_user = connected_phone.loc
		if(connected_phone in mindjack_user.held_items)
			mindjack_user = mindjack_user
			earfuck.original_stranger = mindjack_user
			earfuck.assign_earfucker(mindjack_user) // Successful earfucking
			mindjack_user.flash_screen_flash(100)
			poor_sod.flash_screen_flash(100)
			addtimer(CALLBACK(earfuck, TYPE_PROC_REF(/datum/brain_trauma/severe/earfuck, switch_minds)), 0.4 SECONDS)
		else
			connected_phone.audible_message("[icon2html(connected_phone, world)] ОПЕРАЦИЯ TP4X4T_YSH1 ПРОВАЛЕНА!", hearing_distance = 1)
			playsound(connected_phone, 'modular_septic/sound/efn/phone_subtlealert.ogg', 25, FALSE)
			hang_up(user, silent = TRUE)
			return

	// virus infections from hacking software
	for(var/datum/simcard_application/hacking/hacking in connected_phone.simcard.applications)
		if(!hacking.infective)
			continue
		var/already_infected = FALSE
		for(var/virus in simcard.viruses)
			if(istype(virus, hacking.infection_type))
				already_infected = TRUE
				break
		if(already_infected)
			continue
		new hacking.infection_type(simcard)

/obj/item/cellphone/proc/reject_call(mob/living/user, silent = FALSE)
	connected_phone.audible_message("[icon2html(connected_phone, world)] [simcard.username] отклонил звонок.", hearing_distance = 1)
	connected_phone.connected_phone = null
	connected_phone.connection_state = CONNECTION_NONE
	connected_phone.call_soundloop.stop()
	if(!silent)
		playsound(connected_phone, 'modular_septic/sound/efn/phone_dead.ogg', 65, FALSE)

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] Я отклонил звонок от [connected_phone.simcard.username]."))
	if(phone_flags & PHONE_MINDJACKED)
		phone_flags &= ~PHONE_MINDJACKED
	connection_state = CONNECTION_NONE
	ringtone_soundloop.stop()
	connected_phone.update_appearance()
	connected_phone = null
	update_appearance()
	if(!silent)
		playsound(src, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

/obj/item/cellphone/proc/start_calling(obj/item/cellphone/receiver, mob/living/user, silent = FALSE, mindjack = FALSE)
	if(receiver.connected_phone)
		if(user)
			to_chat(user, span_warning("[icon2html(src, user)] Дерьмо, кто-то уже моей цели позвонил."))
		return
	receiver.connected_phone = src
	receiver.connection_state = CONNECTION_BEING_CALLED
	addtimer(CALLBACK(receiver, /obj/item/cellphone/proc/delayed_ringing), rand(25, 35))

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] Я начал звонить [receiver.simcard.username]."))
	if(mindjack)
		audible_message(span_notice("[src] присоединился по нейро-волокну к [receiver.simcard.username]."))
		playsound(src, 'modular_septic/sound/efn/earfuck_connect.ogg', 35, FALSE)
		playsound(receiver, 'modular_septic/sound/efn/phone_jammer.ogg', 1, FALSE)
		receiver?.phone_flags |= PHONE_MINDJACKED
	if(!silent)
		playsound(src, 'modular_septic/sound/efn/phone_start_call.ogg')
	connected_phone = receiver
	connection_state = CONNECTION_CALLING
	call_soundloop.start()
	update_appearance()
	stop_calling_timer = addtimer(CALLBACK(src, PROC_REF(delayed_stop_calling)), 1 MINUTES, TIMER_STOPPABLE)

/obj/item/cellphone/proc/stop_calling(mob/living/user, silent = FALSE)
	connected_phone.audible_message(span_notice("[icon2html(connected_phone, world)] [simcard.username] бросил трубку."), hearing_distance = 1)
	connected_phone.connected_phone = null
	connected_phone.connection_state = CONNECTION_NONE
	connected_phone.update_appearance()
	connected_phone.ringtone_soundloop.stop()
	if(!silent)
		playsound(connected_phone, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] Я прекратил звонить [connected_phone.simcard.username]."))
	connected_phone = null
	connection_state = CONNECTION_NONE
	update_appearance()
	call_soundloop.stop()
	if(!silent)
		playsound(src, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

	if(stop_calling_timer)
		deltimer(stop_calling_timer)
		stop_calling_timer = null

/obj/item/cellphone/proc/hang_up(mob/living/user, silent = FALSE)
	connected_phone.audible_message(span_notice("[icon2html(connected_phone, world)] [simcard.username] сбросил вызов."), hearing_distance = 1)
	connected_phone.connected_phone = null
	connected_phone.connection_state = CONNECTION_NONE
	connected_phone.update_appearance()
	if(!silent)
		playsound(connected_phone, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] Я вешаю трубку [connected_phone.simcard.username]."))
	if(connected_phone.phone_flags & PHONE_MINDJACKED)
		connected_phone.phone_flags &= ~PHONE_MINDJACKED
	if(phone_flags & PHONE_MINDJACKED)
		phone_flags &= ~PHONE_MINDJACKED
	connected_phone = null
	connection_state = CONNECTION_NONE
	update_appearance()
	if(!silent)
		playsound(src, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

#define woke_message audible_message
#define squiggly_shit span_notice
#define peepthehorror icon2html
#define chief src
#define society world
#define eradicate_hope ringtone_soundloop.start
#define update_drip update_appearance
#define yeet sound_hint
#define shawty connected_phone
#define isnt ||
#define fucking =
#define NOT !
#define NOTfucking !=
#define cringe_state connection_state
#define BITCHES CONNECTION_BEING_CALLED
#define L return
#define CAP FALSE
#define tfw silent


/obj/item/cellphone/proc/delayed_ringing(tfw = CAP)
	if(!shawty isnt (cringe_state NOTfucking BITCHES))
		L
	woke_message(squiggly_shit("[peepthehorror(chief, society)] Ring ring!"))
	eradicate_hope()
	update_drip()
	yeet()

#undef woke_message
#undef squiggly_shit
#undef peepthehorror
#undef chief
#undef society
#undef eradicate_hope
#undef update_drip
#undef yeet
#undef shawty
#undef isnt
#undef fucking
#undef NOT
#undef cringe_state
#undef BITCHES
#undef L
#undef CAP
#undef tfw

/obj/item/cellphone/proc/delayed_stop_calling(silent = FALSE)
	if(!connected_phone || (connection_state != CONNECTION_CALLING))
		return
	stop_calling(silent = TRUE)
	if(!silent)
		playsound(src, 'modular_septic/sound/efn/phone_dead.ogg', 65, FALSE)

/obj/item/cellphone/proc/terminate_connection(mob/living/user)
	if(connected_phone)
		if(phone_flags & PHONE_MINDJACKED)
			phone_flags &= ~PHONE_MINDJACKED
		switch(connection_state)
			if(CONNECTION_BEING_CALLED)
				reject_call(user)
			if(CONNECTION_CALLING)
				stop_calling(user)
			if(CONNECTION_ACTIVE_CALL)
				hang_up(user)
		return TRUE
	return FALSE

/obj/item/cellphone/proc/start_glitching(forced = FALSE)
	if(!forced && (simcard?.firewall_health > 0))
		simcard.firewall_health = max(0, simcard.firewall_health - 35)
		var/struggle_msg
		if(simcard.firewall_health < 50)
			struggle_msg = "Операционная система [simcard] едва справляется с защитой от ДДОС атаки!"
		else
			struggle_msg = "Операционная система[simcard] справилась с ДДОС атакой!"
		audible_message(span_danger("[icon2html(simcard, world)] [struggle_msg]"))
		playsound(src, 'modular_septic/sound/efn/phone_query_master.ogg', 30, FALSE)
		return FALSE
	terminate_connection()
	addtimer(CALLBACK(src, PROC_REF(stop_glitching)), rand(10, 30) SECONDS)
	audible_message(span_warning("[icon2html(src, world)] [src] начинает издавать пронзающий уши звук! \
								Звучит как альбом Sewerslvt!"))
	glitch_soundloop.start()
	phone_flags |= PHONE_GLITCHING
	update_appearance()
	//sound_hint()
	return TRUE

/obj/item/cellphone/proc/stop_glitching()
	audible_message(span_notice("[icon2html(src, world)] [src] экран очищается и глюки, кажется, прекращаются."))
	glitch_soundloop.stop()
	phone_flags &= ~PHONE_GLITCHING
	update_appearance()
	//sound_hint()

/obj/item/cellphone/proc/disable_parental_controls(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	var/funny_moment = "В доступе отказано."
	if(istype(human_user) && (human_user.dna.species.id == SPECIES_INBORN))
		funny_moment = "МОИ [pick("ПАПА", "МАМА")] СКАЗАЛИ ЭТОГО НЕ ДЕЛАТЬ."
	playsound(src, 'modular_septic/sound/efn/phone_query.ogg', 65, FALSE)
	to_chat(user, span_boldwarning(funny_moment))

/obj/item/cellphone/proc/toggle_simcard_publicity(mob/living/user)
	simcard.toggle_publicity()
	playsound(src, 'modular_septic/sound/efn/phone_query.ogg', 65, FALSE)
	if(simcard.publicity)
		to_chat(user, span_notice("[icon2html(simcard, user)] [simcard] поставил себя в контаках."))
	else
		to_chat(user, span_notice("[icon2html(simcard, user)] [simcard] убрал себя из контактов."))

/obj/item/cellphone/proc/change_username(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	var/title = "Поменять псевдоним"
	var/message = "Пожалуйста, используйте неоскорбительное имя.\nСледуйте [brand_name] правилами пользования."
	if(istype(human_user) && (human_user.dna.species.id == SPECIES_INBORN))
		title = "Подборка самых смешных телефонных розыгрышей #[rand(1,99)]"
		message = "[pick("ПААААП", "МАААААМ")], Я НЕ ХОЧУ ВВОДИТЬ ИМЯ ПОЛЬЗОВАТЕЛЯ НЕ ЯВЛЯЮЩЕЕСЯ ОСКОРБИТЕЛЬНЫМ!"
	var/input = input(user, message, title) as text|null
	if(!length(input))
		to_chat(user, span_warning("Забудь."))
	else if(GLOB.simcard_list_by_username[input])
		to_chat(user, span_warning("Такое имя уже есть. Попробуйте другое"))
	else
		GLOB.simcard_list_by_username -= simcard.username
		GLOB.active_public_simcard_list -= simcard.username
		simcard.username = input
		GLOB.simcard_list_by_username[simcard.username] = simcard
		if(simcard.publicity)
			GLOB.active_public_simcard_list[simcard.username] = simcard
		playsound(src, 'modular_septic/sound/efn/phone_query.ogg', 65, FALSE)
		to_chat(user, span_notice("Псевдоним введён."))

/obj/item/cellphone/proc/ringtone_select(mob/living/user)
	var/list/options = list(
		"Заводской" = /datum/looping_sound/phone_ringtone,
		"Нокия" = /datum/looping_sound/phone_ringtone/defaultnokia,
		"Kick" = /datum/looping_sound/phone_ringtone/kick,
		"Ультра-соник" = /datum/looping_sound/phone_ringtone/ultrasonic,
		"Badinerie" = /datum/looping_sound/phone_ringtone/bad,
		"Prodigy" = /datum/looping_sound/phone_ringtone/prodigydance,
	)
	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(src, random_press_sound, 65, FALSE)
	var/title = "Что нужно сделать?"
	var/message = "Поменять рингтон"
	var/input = tgui_input_list(user, message, title, options)
	if(!input || !options[input])
		playsound(src, random_press_sound, 65, FALSE)
		to_chat(user, span_warning("Забудь."))
		return
	var/ringtype = options[input]
	var/datum/looping_sound/phone_ringtone/new_ringtone = new ringtype(src, FALSE)
	playsound(src, new_ringtone.mid_sounds[1], 30, FALSE)
	QDEL_NULL(ringtone_soundloop)
	ringtone_soundloop = new_ringtone
	to_chat(user, span_notice("Поставить рингтон \"[input]\"."))
	if(ringtype == /datum/looping_sound/phone_ringtone/kick)
		to_chat(user, span_boldnotice("Вот это бенгер!"))

/obj/item/cellphone/proc/user_language_help(mob/living/user)

/obj/item/cellphone/proc/begin_factory_reset(mob/living/user)

/obj/item/cellphone/proc/application_menu(mob/living/user)
	var/list/appplications = list()
	for(var/datum/simcard_application/application as anything in simcard.applications)
		appplications[application.name] = application
	var/input = tgui_input_list(user, "Какое приложение вы хотите использовать?", "Меню приложений", appplications)
	if(input)
		var/datum/simcard_application/chosen_app = appplications[input]
		if(chosen_app)
			chosen_app.execute(user)
	else
		to_chat(user, span_warning("Забудь."))

/obj/item/cellphone/proc/install_simcard(obj/item/simcard/simpson, mob/living/user)
	if(istype(simcard))
		return
	simcard = simpson
	simcard.parent = src
	GLOB.active_simcard_list[simcard.phone_number] = simcard
	if(simcard.publicity && simcard.username)
		GLOB.active_public_simcard_list[simcard.username] = simcard
	for(var/datum/simcard_application/simcard_application as anything in simcard.applications)
		simcard_application.simcard_installed(src)
	for(var/datum/simcard_virus/simcard_virus as anything in simcard.viruses)
		simcard_virus.simcard_installed(src)
	update_appearance()

/obj/item/cellphone/proc/uninstall_simcard(mob/living/user)
	if(!istype(simcard))
		return
	for(var/datum/simcard_application/simcard_application as anything in simcard.applications)
		simcard_application.simcard_uninstalled(src)
	for(var/datum/simcard_virus/simcard_virus as anything in simcard.viruses)
		simcard_virus.simcard_uninstalled(src)
	if(user)
		simcard.forceMove(user.loc)
		user.put_in_hands(simcard)
	else
		simcard.forceMove(loc)
	GLOB.active_simcard_list -= simcard.phone_number
	GLOB.active_public_simcard_list -= simcard.username
	simcard.parent = null
	simcard = null
	update_appearance()

/obj/item/cellphone/proc/toggle_flip(mob/living/user, silent = FALSE)
	flipped = !flipped
	if(!flipped)
		slot_flags = initial(slot_flags)
		w_class = WEIGHT_CLASS_SMALL
		if(!silent)
			playsound(src, unflip_sound, 65, FALSE)
	else
		slot_flags = NONE
		w_class = WEIGHT_CLASS_NORMAL
		if(!silent)
			playsound(src, flip_sound, 65, FALSE)
	if(user)
		to_chat(user, span_notice("Я [flipped ? "открыл" : "закрыл"] [src]."))
	update_appearance()
	//if(!silent)
		//sound_hint()

/obj/item/cellphone/proc/begin_selfdestruct(silent = FALSE)
	phone_flags |= PHONE_GLITCHING
	audible_message(span_bigdanger("[icon2html(src, world)] [src] издает неестественный жужжащий и гудящий звук, бесконтрольно вибрируя!"))
	playsound(src, 'modular_septic/sound/efn/virus_explode_buildup.ogg', 90, FALSE)
	addtimer(CALLBACK(src, PROC_REF(selfdestruct), src), 1.8 SECONDS)
	update_appearance()

/obj/item/cellphone/proc/selfdestruct(silent = FALSE)
	explosion(src, light_impact_range = 2, flash_range = 3)
	qdel(src)
