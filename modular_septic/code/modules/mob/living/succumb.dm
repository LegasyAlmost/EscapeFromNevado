/mob/living/verb/succumb(whispered as null)
	set name = "Суицид"
	set category = "IC"
	set desc = "Отдайся смерти."

	if(!CAN_SUCCUMB(src))
		to_chat(src, span_info("Я не способен покончить с собой! Жизнь должна продолжаться."))
		return
	log_message("Has [whispered ? "whispered his final words" : "succumbed to death"] with [round(health, 0.1)] points of health!", LOG_ATTACK)
	ADJUSTBRAINLOSS(src, src.maxHealth)
	if(!whispered)
		to_chat(src, span_dead("Я отказался от жизни и поддался смерти."))
	death()
	updatehealth()
