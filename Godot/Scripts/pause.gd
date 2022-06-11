extends CanvasLayer

func _ready() -> void:
	show(false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		show(!get_tree().paused)
		get_tree().paused = !get_tree().paused
		

func show(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_continue_pressed():
	show(false)
	get_tree().paused = false
