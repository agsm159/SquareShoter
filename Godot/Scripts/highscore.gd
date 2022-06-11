extends Label

func _ready() -> void:
	Global.load_game()
	text = String(Global.highscore)

func _process(delta: float) -> void:
	if Global.points > Global.highscore:
		Global.highscore = Global.points
