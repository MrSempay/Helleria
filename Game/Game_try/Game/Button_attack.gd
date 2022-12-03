extends Button

func _ready():
	match GLOBAL.stone:
		1:
			set_text("Bow")
		2:
			set_text("Stone Sword")





"""
var Attack = load("res://Game/AnimationPlayer.gd")
var Attack1 = Attack.new()

var Attack2 = load("res://Game/Enemy.gd")
var Attack3 = Attack2.new()

func _pressed():
	#GLOBAL.Attack = 100
	#Attack1.RUN(GLOBAL.Attack)
	#print("Hello world!")
	#text = str(GLOBAL.counter + 1)
	if Attack3.damage(GLOBAL.counter) > 0:
		GLOBAL.counter += 1
		print("Damage: 1")
		print("Health: ", Attack3.damage(GLOBAL.counter), "\n")
	else:
		GLOBAL.counter += 1
	#	text = str(GLOBAL.counter)
"""
