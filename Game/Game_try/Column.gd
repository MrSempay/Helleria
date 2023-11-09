extends Area2D


var velocity = Vector2()
var first = true
var ignoring_sides_armor = true


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
			#body.armor = 0
			body.handle_hit(SPELLS_PARAMETERS.damage_column_Heroe, get_parent().get_node("Heroe"), self)
			body.stun(SPELLS_PARAMETERS.stun_duration_column_Heroe)
			first = false



