extends StaticBody2D

var first = true
var self_sprite
var first_anim = "idle"
var already_anim_created = false

func _ready():
	self_sprite = $AnimatedSprite
	if get_tree().get_current_scene().get_name() == "First_Scene" && !already_anim_created:
		creating_animations_for_wall_from_folder("res://Anims/Gasria/stone_wall/", {"idle": [7, true], "wall_growing": [55, false], "wall_destruction": [14, false]})
	self_sprite.play(first_anim)
	yield(get_tree(), "idle_frame")
	if get_parent().get_name() == "PositionsWalls":
		self_sprite.flip_h = get_parent().global_position.x > self.global_position.x

func stone_wall_self():
	pass

func _physics_process(delta):
	yield(get_tree(), "idle_frame")
	if self_sprite.get_animation() == "wall_destruction" && first_anim != "wall_destruction":
		first_anim = "wall_destruction"
	#print(self_sprite.get_frame())
	#print(self_sprite.get_sprite_frames().get_animation_names())
	if first:
		if self_sprite.is_flipped_h():
			$CollisionShape2D.set_position($CollisionShape2D.get_position() + Vector2(16,0))
			first = false

func _on_AnimatedSprite_animation_finished():
	if self_sprite.get_animation() == "wall_destruction":
		self.queue_free()
	if self_sprite.get_animation() == "wall_growing":
		first_anim = "idle"
		self_sprite.play("idle")

func creating_animations_for_wall_from_folder(path, fps_and_loop_for_each_animationDictionaryArrays, sprite = self_sprite):
	var dir_of_dir_animations = Directory.new()
	if dir_of_dir_animations.open(path) == OK:
		dir_of_dir_animations.list_dir_begin(true)
		var animation = dir_of_dir_animations.get_next()
		while animation != "":
			#print(animation)
			#print(self_sprite.get_sprite_frames())
			if sprite.get_sprite_frames().get_animation_names().has(animation):
				sprite.get_sprite_frames().clear(animation)
			sprite = GLOBAL.making_animation_for_sprite_from_folder(path + animation, sprite, animation, fps_and_loop_for_each_animationDictionaryArrays[animation][1], Vector2(0, 0), fps_and_loop_for_each_animationDictionaryArrays[animation][0], false)
			animation = dir_of_dir_animations.get_next()
