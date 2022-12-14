extends Area2D


var velocity = Vector2()
var damage_hedgehod = 25
var first = true


func _ready():
	$Sprite.play("hedgehod")


func _physics_process(delta):
	pass

func _on_Sprite_animation_finished():
	self.queue_free()


func _on_Timer_timeout():
	pass


func _on_KinematicBody2D_body_entered(body):
	if first:
		if body.has_method("handle_hit") && body.has_method("start_jump"):
			body.handle_hit(damage_hedgehod)
	first = false
