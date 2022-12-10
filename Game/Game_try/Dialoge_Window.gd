extends Node2D

onready var dialoge_phrase = get_node("TextureRect/RichTextLabel")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func choosing_text(parent_name, number_of_phrase):
	match parent_name:
		"Aglea":
			match number_of_phrase:
				1: dialoge_phrase.set_text("So, Hello!")
				2: dialoge_phrase.set_text("Oh... I'm fine!!!")
				3: dialoge_phrase.set_text("I will enslave you")
		"Akira":
			match number_of_phrase:
				1: dialoge_phrase.set_text("Hi! How are you?")
				2: dialoge_phrase.set_text("So, that is good, then I will destroy you")
				3: dialoge_phrase.set_text("Ha-ha... Aha-ha... You are so weak!")
