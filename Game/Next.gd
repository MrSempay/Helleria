extends Button


func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")


func _on_Timer_timeout():
	set_disabled(false)
	visible = true
