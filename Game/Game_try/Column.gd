extends Area2D


var velocity = Vector2()
var damage_column = 25
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
			body.handle_hit(damage_column)
			body.stun = true
			body.get_node("Timer_Of_Stun").start()
			body.get_node("Sprite").play("idle")
	first = false



