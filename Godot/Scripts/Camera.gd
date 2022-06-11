extends Camera2D

var intensity_shake = 0
var start_shake = false

func _process(delta):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	
	if start_shake == true:
		global_position += Vector2(rand_range(-intensity_shake, intensity_shake),  rand_range(-intensity_shake, intensity_shake)) * delta

func shake_screen(intensity, time):
	zoom = Vector2(1,1) - Vector2(intensity * 0.02, intensity * 0.02)
	intensity_shake =  intensity
	
	$timer.wait_time = time
	$timer.start()
	
	start_shake = true

func _ready():
	Global.camera = self

func _exit_tree():
	Global.camera = null

func _on_timer_timeout():
	start_shake = false
