extends Area2D


var velocity = Vector2()
var first = true


func _ready():
	$Sprite.play("column")


func _physics_process(delta):
	pass

func _on_Sprite_animation_finished():
	self.queue_free()


func _on_Timer_timeout():
	pass


func _on_Column_body_entered(body):
	if first:
		if body.has_method("handle_hit") && body.has_method("enemy"):
			body.handle_hit(SPELLS_PARAMETERS.damage_column_Heroe)
			body.stun = true
			body.stun(SPELLS_PARAMETERS.stun_duration_column_Heroe)
			body.get_node("Sprite").play("idle")
			
			first = false



