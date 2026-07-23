extends Node2D

signal completed
signal failed

@export var instruction_text: String = "Beat the challenge!"
@export var duration: float = 4.0
@export var difficulty_scale: float = 1.0

var timer: float
var is_active := false

var ui_panel: Control
var instruction_label: Label
var timer_label: Label
var countdown_label: Label

func _ready() -> void:
	timer = duration
	build_ui()
	_start_intro()

func build_ui() -> void:
	ui_panel = Control.new()
	add_child(ui_panel)

	ui_panel.set_anchors_preset(Control.PRESET_FULL_RECT)

	instruction_label = Label.new()
	instruction_label.text = instruction_text
	instruction_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	instruction_label.position = Vector2(250, 20)
	instruction_label.size = Vector2(700, 40)
	ui_panel.add_child(instruction_label)

	timer_label = Label.new()
	timer_label.text = "Time: %.1f" % timer
	timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	timer_label.position = Vector2(250, 60)
	timer_label.size = Vector2(700, 30)
	ui_panel.add_child(timer_label)

	countdown_label = Label.new()
	countdown_label.text = ""
	countdown_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	countdown_label.position = Vector2(400, 120)
	countdown_label.size = Vector2(400, 80)
	ui_panel.add_child(countdown_label)

func _process(delta: float) -> void:
	if !is_active:
		return

	timer -= delta

	if timer_label:
		timer_label.text = "Time: %.1f" % max(timer, 0.0)

	if timer <= 0.0:
		fail_minigame()

func update_instruction(text: String) -> void:
	instruction_text = text

	if instruction_label:
		instruction_label.text = text

func success() -> void:
	if !is_active:
		return

	is_active = false

	if countdown_label:
		countdown_label.text = "SUCCESS"

	completed.emit()

func fail_minigame() -> void:
	if !is_active:
		return

	is_active = false

	if countdown_label:
		countdown_label.text = "FAIL"

	failed.emit()

func _start_intro() -> void:
	is_active = false

	countdown_label.visible = true

	for t in ["3","2","1","GO!"]:
		countdown_label.text = t
		await get_tree().create_timer(0.7).timeout

	countdown_label.visible = false
	is_active = true