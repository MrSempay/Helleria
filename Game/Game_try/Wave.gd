extends Area2D

var local_parameters = {

 "character_who_casted_wave": "",
 "name_of_wave": null,
 "should_be_destroing_after_colliding": true,
 "velocity": Vector2(),
 "vector": 0,
 "speed": 1,
 "global_position_for_wave": Vector2(),
 "amount_bounces": 0,
 "flip_h": false,
 "current_animation": "wave_starting"
}


func _ready():
	print(local_parameters)
	$AnimatedSprite.play(local_parameters["current_animation"])
	self.global_position = local_parameters["global_position_for_wave"]
	$AnimatedSprite.flip_h = local_parameters["flip_h"]
	if local_parameters["vector"] == 0 && !get_parent() is Viewport:
		if get_parent().global_position.x < self.global_position.x:
			local_parameters["vector"] = -1
			$AnimatedSprite.flip_h = true
		else: 
			local_parameters["vector"] = 1
			$AnimatedSprite.flip_h = false


func _physics_process(delta):
	#print($AnimatedSprite.flip_h)
	local_parameters["global_position_for_wave"] = global_position
	if !get_parent() is Viewport:
		local_parameters["velocity"].x = SPELLS_PARAMETERS.characters[local_parameters["character_who_casted_wave"]][local_parameters["name_of_wave"] + "_wave"][local_parameters["name_of_wave"] + "_wave_speed"] * delta * local_parameters["vector"] * local_parameters["speed"]
	translate(local_parameters["velocity"])


func _on_Wave_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.characters[local_parameters["character_who_casted_wave"]][local_parameters["name_of_wave"] + "_wave"][local_parameters["name_of_wave"] + "_wave_damage"], get_tree().get_current_scene().get_node(local_parameters["character_who_casted_wave"]))
	elif local_parameters["should_be_destroing_after_colliding"]:
		queue_free()
	if body.has_method("stone_wall_self") && local_parameters["amount_bounces"] > 0:
		local_parameters["speed"] = local_parameters["speed"] + 0.5
		local_parameters["vector"] = local_parameters["vector"] * (-1)
		$AnimatedSprite.flip_h = !$AnimatedSprite.is_flipped_h()
		local_parameters["flip_h"] = $AnimatedSprite.flip_h
		if local_parameters["amount_bounces"] == SPELLS_PARAMETERS.characters[local_parameters["character_who_casted_wave"]][local_parameters["name_of_wave"] + "_wave"][local_parameters["name_of_wave"] + "_wave_amount_bounces"] + 1:
			queue_free()
			body.get_node("AnimatedSprite").play("wall_destruction")
		local_parameters["amount_bounces"] += 1
	if body.has_method("stone_wall_self") && local_parameters["amount_bounces"] < 1:
		local_parameters["amount_bounces"] += 1


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation() == "wave_starting":
		local_parameters["current_animation"] = "idle"
		$AnimatedSprite.play("idle")
		
