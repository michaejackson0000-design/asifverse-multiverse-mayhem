extends Node

const SAVE_PATH := "user://game_save.json"

func save_game() -> void:
	var data = {
		"high_score": 0
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return {}

	var text = file.get_as_text()
	file.close()

	var json = JSON.new()
	var err = json.parse(text)

	if err != OK:
		return {}

	return json.data