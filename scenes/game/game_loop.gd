extends Node2D

var current_minigame: Node2D = null

func _ready() -> void:
    GameManager.start_game()
    _start_minigame()

func _start_minigame() -> void:
    if current_minigame:
        current_minigame.queue_free()
        current_minigame = null

    var data = MiniGameManager.get_random_minigame()
    if data.is_empty():
        return

    var script_path = "res://scripts/minigames/%s.gd" % data.id
    var script: Script = load(script_path)
    if script == null:
        push_warning("Could not load minigame script: %s" % script_path)
        return

    current_minigame = Node2D.new()
    current_minigame.name = data.name
    current_minigame.set_script(script)
    add_child(current_minigame)

    if current_minigame.has_signal("completed"):
        current_minigame.completed.connect(_on_minigame_completed)
    if current_minigame.has_signal("failed"):
        current_minigame.failed.connect(_on_minigame_failed)

func _on_minigame_completed() -> void:
    ScoreManager.add_score(100)
    ScoreManager.increase_combo()
    GameManager.start_round()
    _start_minigame()

func _on_minigame_failed() -> void:
    ScoreManager.reset_combo()
    GameManager.end_game()
    SceneManager.change_scene("res://scenes/ui/game_over.tscn")
