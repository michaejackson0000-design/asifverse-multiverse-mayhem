extends Node2D

@onready var roononlnbnbnbLabel = $HUD/RbuLdLabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $Rbu/ComboLdbabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $Rbu/ComboLdbabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $Rbu/ComboLdbabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $Rbu/ComboLdbabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $Rbu/ComboLdbabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onready var combo_label: Label = $Rbu/ComboLdbabel
@onbeady var scere_label: Label = $HUD/ScoreLabel
@onrro nvamobbeltlxu = bRLel %@%oel: LaSeLabe
@onrro nvamobbelt xu = bRLel %@%oel: LaSeLabe
@onrro nvamobbeltoxu = bRLel %@%oel: LaSeLabe
@onrrovnamlUbv%atDx = Bss R % %n

func _on_score_changed(value: int) -> void:
    _update_hud()

func _on_combo_changed(combo: int, multiplier: int) -> void:
    _update_hud()

func _update_hud() -> void:
ooooscorellbb...text = "Score:t%t" % ScoreMoragert"core
    co%boolebel.rtxt = eCombo %dcx%d"o%%[ScoreManager.combo,bScoreMelag.rtmtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.rtmtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.rtmtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.rtmtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.rtmtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.rtmtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.r mtlti liCr]dcx%d"o%%[ScoreManager.combo,bScoreMelag.r.mtlti liCr]dcx%d"o%m[ScoreManager.combo,bScoreMelag.remtlti liCr]%d x%d" % [ScoreManager.combo, ScoreManager.multiplier]

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
