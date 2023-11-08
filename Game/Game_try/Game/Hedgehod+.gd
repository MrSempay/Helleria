extends "res://Game/Spells/Pieces_emerging_from_ground.gd"


var velocity = Vector2()
var first = true

func _on_KinematicBody2D_body_entered(body):
	if first:
		if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
			body.handle_hit(SPELLS_PARAMETERS.damage_hedgehod, get_parent().get_node("Heroe"))
			body.stun(SPELLS_PARAMETERS.stun_duration_hedgehod)
	first = false
