extends Control

@onready var retry_button: Button = $RetryButton
@onready var label: Label = $Label
@onready var summary_label: Label = $SummaryLabel

func _ready() -> void:
    retry_button.pressed.connect(_on_retry_pressed)
    label.text = "Game Over\nHigh Score: %d\nPlay Again" % ScoreManager.high_score
    summary_label.text = "Final Score: %d\nPortals survived: %d" % [ScoreManager.score, GameManager.current_round]

func _on_retry_pressed() -> void:
    ScoreManager.score = 0
    ScoreManager.combo = 0
    ScoreManager.streak = 0
    ScoreManager.multiplier = 1
    GameManager.start_game()
    SceneManager.change_scene("res://scenes/game/game_loop.tscn")
