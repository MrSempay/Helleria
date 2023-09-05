extends Node2D


func _ready():
	self.set_position(Vector2(0, -55))
	$AnimatedSprite.play("dropping")
	#$AnimatedSprite.modulate = Color(0.0, 6.0, 0.0)

func _on_AnimatedSprite_animation_finished():
	if get_parent().array_for_dropping_consumption_health_animations != []:
		get_parent().array_for_dropping_consumption_health_animations.remove(0)
		if get_parent().array_for_dropping_consumption_health_animations != []:
			get_parent().add_child(get_parent().array_for_dropping_consumption_health_animations[0])
	self.queue_free()
