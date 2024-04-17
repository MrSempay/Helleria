extends Node2D

var i
var c
var d

func _ready():
	for_position()
	



func _on_Timer_timeout():
	##(i)
	if i > 0.1:
		i = i - 0.1
		$RichTextLabel.set_text(str(i))
	else:
		if c != get_parent().get_parent().amount_status_bars.size() - 1:
			for d in range(c, get_parent().get_parent().amount_status_bars.size() - 1):
				get_parent().get_parent().amount_status_bars[d + 1].c = get_parent().get_parent().amount_status_bars[d + 1].c - 1
				get_parent().get_parent().amount_status_bars[d + 1].set_global_position(get_parent().get_parent().amount_status_bars[d + 1].get_global_position() + Vector2(-10, 0))
			get_parent().set_global_position(get_parent().get_global_position() + Vector2(5, 0))
		elif 1 != get_parent().get_parent().amount_status_bars.size():
			get_parent().set_global_position(get_parent().get_global_position() + Vector2(5, 0))
		get_parent().get_parent().amount_status_bars.remove(c)
		queue_free()

func for_position():
	$RichTextLabel.set_text(str(i))
	get_parent().get_parent().amount_status_bars.append(self)
	c = get_parent().get_parent().amount_status_bars.size() - 1
	if get_parent().get_parent().amount_status_bars.size() != 1:
		get_parent().set_global_position(get_parent().get_global_position() + Vector2(-5, 0))
		self.set_global_position(get_parent().get_global_position() + Vector2(10, 0) * c)
	else:
		self.set_global_position(get_parent().get_global_position())
	
