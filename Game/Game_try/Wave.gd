extends Area2D

var character_who_casted_wave
var name_of_wave
var should_be_destroing_after_colliding = true
var velocity = Vector2()
var vector = 0
var speed = 1
var global_position_for_wave
var amount_bounces = 0


func _ready():
	$AnimatedSprite.play("wave_starting")
	self.set_global_position(global_position_for_wave)
	print(get_parent().global_position.x )
	print(self.global_position.x)
	if get_parent().global_position.x < self.global_position.x:
		vector = -1
		$AnimatedSprite.flip_h = true
	else: 
		vector = 1
		$AnimatedSprite.flip_h = false


func _physics_process(delta):
	velocity.x = SPELLS_PARAMETERS.characters[character_who_casted_wave.get_name()][name_of_wave + "_wave"][name_of_wave + "_wave_speed"] * delta * vector * speed
	translate(velocity)


func _on_Wave_body_entered(body):
	
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.characters[character_who_casted_wave.get_name()][name_of_wave + "_wave"][name_of_wave + "_wave_damage"], character_who_casted_wave)
	elif should_be_destroing_after_colliding:
		queue_free()
	if body.has_method("stone_wall") && amount_bounces > 0:
		speed = speed + 0.5
		vector = vector * (-1)
		$AnimatedSprite.flip_h = !$AnimatedSprite.is_flipped_h()
		if amount_bounces == SPELLS_PARAMETERS.characters[character_who_casted_wave.get_name()][name_of_wave + "_wave"][name_of_wave + "_wave_amount_bounces"] + 1:
			queue_free()
			body.get_node("AnimatedSprite").play("wall_destruction")
		amount_bounces += 1
	if amount_bounces < 1:
		amount_bounces += 1
