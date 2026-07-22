extends Control

@onready var score_label: Label = $PanelBackground/ScoreLabel
@onready var combo_label: Label = $PanelBackground/ComboLabel
@onready var round_label: Label = $PanelBackground/RoundLabel
@onready var timer_label: Label = $PanelBackground/TimerLabel

func _ready() -> void:
    ScoreManager.score_changed.connect(_update_hud)
    ScoreManager.combo_changed.connect(_update_hud)
    GameManager.round_started.connect(_on_round_started)
    _update_hud()

func _update_hud() -> void:
    score_label.text = "SCORE: %d" % ScoreManager.score
    combo_label.text = "COMBO: %d x%d" % [ScoreManager.combo, ScoreManager.multiplier]
    timer_label.text = "%.1f" % maxf(0, ScoreManager.score / 10)

func _on_round_started(round_number: int) -> void:
    round_label.text = "ROUND %d" % round_number
