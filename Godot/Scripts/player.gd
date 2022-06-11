extends Sprite

signal mudar_vidas(vidas_jogador)

var speed = 150
var mov = Vector2.ZERO

var projectile = preload("res://Scenes/projectile.tscn")

var reloaded = true

var dead = false

var max_vidas = 3
var vidas = max_vidas

func _ready() -> void:
	Global.player = self
	connect("mudar_vidas", get_parent().get_node("UI/Control"), "on_mudar_vidas_jogador")
	emit_signal("mudar_vidas", max_vidas)
	Global.damage = get_parent().get_node("UI/Control/damage")

func _enter_tree() -> void:
	Global.player = null

func _process(delta: float) -> void:
	mov.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	mov.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if dead == false:
		global_position += speed * mov * delta
	
	if Input.is_action_pressed("shoot") and Global.create_no != null and reloaded and dead == false:
		Global.instance_node(projectile, global_position, Global.create_no)
		reloaded = false
		$reload.start()

func _on_reload_timeout():
	reloaded = true

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		vidas -= 1
		emit_signal("mudar_vidas", vidas)
		Global.damage.show()
		yield(get_tree().create_timer(0.1), "timeout")
		Global.damage.hide()

	if vidas <= 0:
		visible = false
		dead = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
		Global.game_save()
