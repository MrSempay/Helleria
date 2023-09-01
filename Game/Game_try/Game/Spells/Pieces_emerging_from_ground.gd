extends Area2D


func _ready():
	$Sprite.play("start_appearing")
	$Sprite.connect("animation_finished", self, "_on_Sprite_animation_finished")


func _on_Sprite_animation_finished():
	self.queue_free()
