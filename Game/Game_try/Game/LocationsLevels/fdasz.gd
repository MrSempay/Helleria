extends KinematicBody2D



var ally
var heroe
var speed = 2.5
var velocity = Vector2()
var name_character = "Sed"
var trigger_of_ally = false
var file = File.new()
var JUMP_POWER = 500
var stun = false
var nav_path = [Vector2()]
var manual_navigation = false

var chaining = preload("res://Game/Spells/Chaining.tscn")
var statusbar = preload("res://Game/Spells/BarDuration.tscn")

