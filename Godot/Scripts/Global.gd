extends Node

var create_no = null
var player = null

var points = 0
var highscore = 0
var damage = null
var camera = null

func instance_node(node, location, parent):
	var node_instance = node.instance()
	
	parent.add_child(node_instance)
	node_instance.global_position = location
	
	return node_instance

func save():
	var dic_save = {
		"highscore": highscore
	}
	return dic_save
	
func game_save():
	var game_save = File.new()
	game_save.open_encrypted_with_pass("user://game_save.save", File.WRITE, "naotem")
	game_save.store_line(to_json(save()))
	game_save.close()
	
func load_game():
	var game_save = File.new()
	if not game_save.file_exists("user://game_save.save"):
		print("Erro ao carregar")
		return
		
	game_save.open_encrypted_with_pass("user://game_save.save", File.READ, "naotem")
	var actual_line = parse_json(game_save.get_line())
	
	highscore = actual_line["highscore"]
	game_save.close()
