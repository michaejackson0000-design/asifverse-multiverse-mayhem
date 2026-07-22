extends Node2D

@onready var round_label: Label = $HUD/RoundLabel
@onready var score_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $HUD/ComboLabel
var current_minigame: Node2D = null

func _ready() -> void:
    GameManager.round_started.connect(_on_round_started)
    GameManager.boss_started.connect(_on_boss_started)
    ScoreManager.score_changed.connect(_on_score_changed)
    ScoreManager.combo_changed.connect(_on_combo_changed)
    _update_hud()
    _start_minigame()

func _on_round_started(round_number: int) -> void:
    round_label.text = "Round %d" % round_number

func _on_boss_started(round_number: int) -> void:
    round_label.text = "Boss Round %d" % round_number

func _on_score_changed(value: int) -> void:
    _update_hud()

func _on_combo_changed(combo: int, multiplier: int) -> void:
    _update_hud()

func _update_hud() -> void:
    score_label.text = "Score: %d" % ScoreManager.score
    combo_label.text = "Combo: %d x%d" % [ScoreManager.combo, ScoreManager.multiplier]

func _start_minigame() -> void:
    var data = MiniGameManager.get_random_minigame()
    if data.is_empty():
        return

    if current_minigame:
        current_minigame.queue_free()

    var script_path = "res://scripts/minigames/%s.gd" % data.id
    var script = load(script_path)
    if script:
        current_minigame = Node2D.new()
        current_minigame.name = data.name
        current_minigame.set_script(script)
        add_child(current_minigame)
        current_minigame.completed.connect(_on_minigame_completed)
        current_minigame.failed.connect(_on_minigame_failed)
    else:
        push_warning("Could not load minigame script: %s" % script_path)

func _on_minigame_completed() -> void:
    ScoreManager.add_score(100)
    ScoreManager.increase_combo()
    GameManager.start_round()
    _start_minigame()

func _on_minigame_failed() -> void:
    ScoreManager.reset_combo()
    GameManager.end_game()
    SceneManager.change_scene("res://scenes/ui/game_over.tscn")
