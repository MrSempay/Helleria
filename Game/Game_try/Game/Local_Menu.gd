extends Control


func _ready():
	pass


func _on_Continue_Game_pressed():
	GLOBAL.pause_or_unpause_game(get_parent().get_parent(), false, true)


func _on_Save_Game_pressed():
	GLOBAL.save_game(get_parent().get_parent())


func _on_Settings_pressed():
	GLOBAL.load_game()
