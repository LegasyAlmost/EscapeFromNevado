//Proc for switching between jump, kick and bite
/mob/living/proc/toggle_special_attack(new_attack, silent = FALSE)
	if(!ishuman(src))
		if(!silent)
			to_chat(src, div_infobox(span_warning("моя нечеловеческая форма не позволяет совершать особый приём.")))
		return

	if(!new_attack || new_attack == special_attack)
		special_attack = SPECIAL_ATK_NONE
		if(!silent)
			var/message = "<span class='infoplain'><div class='infobox'>"
			message += span_largeinfo("НИЧЕГО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Теперь мои атаки совершаются обыденно.\n(СКМ не вызовет особый приём)")
			message += "</div></span>"
			to_chat(src, message)
	else
		special_attack = new_attack
		if(!silent)
			var/message = "<span class='infoplain'><div class='infobox'>"
			switch(new_attack)
				if(SPECIAL_ATK_KICK)
					message += span_largeinfo("ПИНОК")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Теперь я буду стараться пинать оппонента.\n(СКМ для пинка)")
				if(SPECIAL_ATK_BITE)
					message += span_largeinfo("УКУС")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Теперь я буду стараться укусить оппонента.\n(СКМ для укуса)")
				if(SPECIAL_ATK_JUMP)
					message += span_largeinfo("ПРЫЖОК")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Теперь я буду стараться прыгать вдаль.\n(СКМ для прыжка)")
				if(SPECIAL_ATK_STEAL)
					message += span_largeinfo("УКРАСТЬ")
					message += "\n<br><hr class='infohr'>\n"
					message += span_info("Теперь я буду стараться красть у оппонентов.\n(СКМ для кражи из карман)")
			message += "</div></span>"
			to_chat(src, message)
