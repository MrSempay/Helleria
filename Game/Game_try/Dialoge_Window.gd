extends Node2D

onready var dialoge_phrase = get_node("Control/TextureRect/RichTextLabel")

func _ready():
	pass # Replace with function body.

		

func choosing_text(parent_name, number_of_phrase):
	match parent_name:
		"Aglea":
			if number_of_phrase == 6:
				print("already here")
			match number_of_phrase:
				1: dialoge_phrase.set_text("Where is he?...")
				2: dialoge_phrase.set_text("Where...")
				3: dialoge_phrase.set_text("Where?!????....")
				5: dialoge_phrase.set_text("WHEEERRREEEE!!!!?!??")
				7: dialoge_phrase.set_text("ДА КУДА ОН ДЕЛСЯ ЧЁРТ ВОЗЬМИ")
				9: dialoge_phrase.set_text("325м5е1")
				10: dialoge_phrase.set_text("qwerewq!")
				11: dialoge_phrase.set_text("3235wg5g221!")
				13: dialoge_phrase.set_text("32gg1dddddddd!")
		"Akira":
			match number_of_phrase:
				2: dialoge_phrase.set_text("Hi! How are you?")
				4: dialoge_phrase.set_text("So, that is good, then I will destroy you")
				6: dialoge_phrase.set_text("Ha-ha... Aha-ha... You are so weak!")

