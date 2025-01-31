//proc for switching combat styles
/mob/living/proc/switch_combat_style(new_style, silent = FALSE)
	if(new_style == combat_style)
		return
	combat_style = new_style
	if(!silent)
		print_combat_style(combat_style)
	return TRUE

//proc for printing info about a combat style
/mob/living/proc/print_combat_style(print_style = combat_style)
	var/message = "<span class='infoplain'><div class='infobox'>"
	switch(print_style)
		if(CS_NONE)
			message += span_largeinfo("НИЧЕГО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Нажатие ПКМа не привнесёт особых ударов - полезно для обыденного взаимодействия с предметами и терминалами.")
		if(CS_FEINT)
			message += span_largeinfo("ФИНТ")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Прожми ПКМ, чтобы совершить финт. \
								Если успешна, то открывается возможность нанести реальный удар.\n\
								Цена: зависит от успеха, однако твоя защита остаётся открытой для ударов.")
		if(CS_DUAL)
			message += span_largeinfo("АКИМБО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Прожми ПКМ, чтобы атаковать второй рукой.\n\
								Цена: Нет. Только твоя выносливость.")
		if(CS_GUARD)
			message += span_largeinfo("НА ГОТОВЕ")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Нажатие ПКМ в режиме боя будет автоматически атаковать всякого, кто окажется рядом. \
								При стрельбе позволяет стрелять точно в тайл. \
								Изменение стиля боля уберёт имеющийся режим.")
		if(CS_DEFEND)
			message += span_largeinfo("ЗАЩИТА")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Уклонение и парирование в разы эффективнее.\n\
								Цена: Уменьшенный исходящий урон.")
		if(CS_STRONG)
			message += span_largeinfo("СИЛЬНО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Прожми ПКМ для атаки. Снесёт крышу знатно.\n\
								Цена: зависит от успеха, твоя защита открыта для ударов. Атака тратит большое количество выносливости.")
		if(CS_FURY)
			message += span_largeinfo("РЕЗКО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Нажимай ПКМ для наненесения нескольких ударов в короткий промежуток. \
								Противодействие этим атакам сложно - что для парирование, что для уклонения.\n\
								Цена: -2 СИЛ")
		if(CS_AIMED)
			message += span_largeinfo("ТОЧНО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Прожми ПКМ для точной атаки. \
								Шанс попасть в разы выше.\n\
								Цена: зависит от успеха, твоя защита открыта для ударов. Промежуток времени для атак увеличен.")
		if(CS_WEAK)
			message += span_largeinfo("СЛАБО")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Уменьшает урон атак - \
								полезно при дуэли не на жизнь или нелетального взаимодействия (прим. хирургия).\n\
								Цена: уменьшает в разы урон от так, но они менее изнурительнее.")
	message += "</div></span>"
	to_chat(src, message)
