/obj/item/bodypart/Topic(href, href_list)
	. = ..()
	if(href_list["gauze"])
		var/mob/living/carbon/carbon = usr
		if(!istype(carbon) || !carbon.canUseTopic(owner, TRUE, FALSE, FALSE) || !current_gauze)
			return
		if(DOING_INTERACTION_WITH_TARGET(carbon, src))
			to_chat(carbon, span_warning("Я уже провожу действия с [src.name]!"))
			return
		if(carbon == owner)
			owner.visible_message(span_warning("<b>[owner]</b> начал снимать [current_gauze] с [owner.p_their()] [src.name]."), \
								span_warning("Я принялся срывать [current_gauze] с моей [src.name]."))
			if(do_mob(usr, owner, 6 SECONDS) && current_gauze)
				owner.visible_message(span_warning("<b>[owner]</b> разорвал [current_gauze], который находился на [owner.p_their()] [src.name], от этой повязки осталось лишь тряпьё!"),
									span_warning("Я разорвал на тряпки [current_gauze], что была на моей [src.name]!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_gauze(FALSE)
			else
				to_chat(owner, span_warning("У меня не получилось снять [current_gauze] с моей [src.name]..."))
		else
			if(do_mob(usr, owner, 3 SECONDS) && current_gauze)
				usr.visible_message(span_warning("<b>[usr]</b> разрывает [current_gauze] с [src.name] <b>[owner]</b>, разорвав [current_gauze] в рваные тряпки!"),
								span_warning("Я с силою снял [current_gauze] с [src.name] [owner], от повязки остались лишь порванные тряпки."))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_gauze(FALSE)
			else
				to_chat(usr, span_warning("У меня не получилось снять [current_gauze] с <b>[owner]</b>, а именно с [owner.p_their()] [src.name]..."))
	if(href_list["splint"])
		var/mob/living/carbon/carbon = usr
		if(!istype(carbon) || !carbon.canUseTopic(owner, TRUE, FALSE, FALSE) || !current_splint)
			return
		if(DOING_INTERACTION_WITH_TARGET(carbon, src))
			to_chat(carbon, span_warning("Я уже провожу действия с [src.name]!"))
			return
		if(carbon == owner)
			owner.visible_message(span_warning("<b>[owner]</b> начал снимать [current_splint] с [owner.p_their()] [src.name]!"), \
								span_warning("Я принялся снимать [current_splint] с моей [src.name]!"))
			if(do_mob(usr, owner, 6 SECONDS) && current_splint)
				owner.visible_message(span_warning("<b>[owner]</b> снял [current_splint] с [owner.p_their()] [src.name], повредив шину в процессе!"),
									span_warning("Я снял [current_splint] с [src.name], сломав шину!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_splint(FALSE)
			else
				to_chat(owner, span_warning("У меня не получилось снять [current_splint] моей [src.name].."))
		else
			if(do_mob(usr, owner, 3 SECONDS) && current_splint)
				usr.visible_message(span_warning("<b>[usr]</b> снял [current_splint] с <b>[owner]</b>, конкретно [owner.p_their()] [src.name], повредив шину в процессе!"),
								span_warning("Я снял [current_splint] с [owner], конкретно [owner.p_their()] [src.name], повредив шину в процессе!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_splint(FALSE)
			else
				to_chat(usr, span_warning("У меня не получилось снять [current_splint] с <b>[owner]</b>, конкретно с [owner.p_their()] [src.name]..."))
