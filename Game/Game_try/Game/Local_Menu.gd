extends Control


func _ready():
	pass


func _on_Continue_Game_pressed():
	GLOBAL.pause_or_unpause_game(get_parent().get_parent(), false, true)


func _on_Save_Game_pressed():
	if !get_tree().get_current_scene().has_method("Fight_Scene"):
		GLOBAL.save_game(get_parent().get_parent())


func _on_Settings_pressed():
	if !get_tree().get_current_scene().has_method("Fight_Scene"):
		GLOBAL.load_game()
