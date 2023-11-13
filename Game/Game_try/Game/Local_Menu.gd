extends Control


func _ready():
	pass


func _on_Continue_Game_pressed():
	GLOBAL.pause_or_unpause_game(get_parent().get_parent(), false)
