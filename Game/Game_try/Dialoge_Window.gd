extends Node2D

onready var dialoge_phrase = get_node("Control/TextureRect/RichTextLabel")

func _ready():
	pass # Replace with function body.

		

func choosing_text(parent_name, number_of_phrase, number_of_dialoge):
	match parent_name:
		"Aglea":
			match number_of_dialoge:
				1:
					match number_of_phrase:
						1: dialoge_phrase.set_text("1")
						2: dialoge_phrase.set_text("2")
						3: dialoge_phrase.set_text("3")
						5: dialoge_phrase.set_text("5")
						7: dialoge_phrase.set_text("7")
						9: dialoge_phrase.set_text("9")
						10: dialoge_phrase.set_text("10")
						11: dialoge_phrase.set_text("11")
						13: dialoge_phrase.set_text("13")
		"Akira":
			match number_of_dialoge:
				1:
					match number_of_phrase:
						1: dialoge_phrase.set_text("1")
						2: dialoge_phrase.set_text("2")
						4: dialoge_phrase.set_text("4")
						6: dialoge_phrase.set_text("6")
						8: dialoge_phrase.set_text("8")
						12: dialoge_phrase.set_text("12")
		"Heroe":
			match number_of_dialoge:
				1:
					match number_of_phrase:
						1: dialoge_phrase.set_text("1")
						2: dialoge_phrase.set_text("2")
						3: dialoge_phrase.set_text("3")
						5: dialoge_phrase.set_text("5")
						7: dialoge_phrase.set_text("7")
						9: dialoge_phrase.set_text("9")
						10: dialoge_phrase.set_text("10")
						11: dialoge_phrase.set_text("11")
						13: dialoge_phrase.set_text("13")
		"Imaginary_Heroe":
			match number_of_dialoge:
				1:
					match number_of_phrase:
						1: dialoge_phrase.set_text("1")
						2: dialoge_phrase.set_text("2")
						4: dialoge_phrase.set_text("4")
						6: dialoge_phrase.set_text("6")
						8: dialoge_phrase.set_text("8")
						12: dialoge_phrase.set_text("12")
