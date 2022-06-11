extends Sprite

var mov = Vector2(1,0)
var speed = 300
var direction = true

func _process(delta: float) -> void:
	if direction:
		look_at(get_global_mouse_position())
		direction = false
	global_position += mov.rotated(rotation) * speed * delta

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
