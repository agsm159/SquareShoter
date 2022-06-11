extends Sprite

export(int) var speed = 75
var mov = Vector2.ZERO
var stuned = false

export(int) var knockback = 500	
export(int) var hp = 3
export(int) var points = 10

var color = modulate
var blood = preload("res://Scenes/blood_particle.tscn")

func _process(delta):
	if hp <= 0 and Global.create_no != null:
		if Global.camera != null:
			Global.camera.shake_screen(50, 0.5)
		Global.points += points
		var instance_blood = Global.instance_node(blood, global_position, Global.create_no)
		instance_blood.rotation = mov.angle()
		instance_blood.modulate = Color.from_hsv(color.h, 1, 0.35)
		queue_free()

func base_movement(delta):
	if Global.player != null and stuned == false:
		mov = global_position.direction_to(Global.player.global_position)
		global_position += mov * speed * delta
	elif stuned:
		mov = lerp(mov, Vector2.ZERO, 0.3)
		global_position += mov * delta
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage") and stuned == false:
		modulate = Color.white
		area.get_parent().queue_free()
		mov = -mov * knockback
		stuned = true
		hp -= 1
		$timer.start()

func _on_timer_timeout() -> void:
	modulate = color
	stuned = false


