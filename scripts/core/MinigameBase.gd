extends Node2D

signal completed
signal failed

@export var instruction_text: String = "Beat the challenge!"
@export var duration: float = 4.0
@export var difficulty_scale: float = 1.0

var timer: float = 0.0
var is_active: bool = false
var ui_panel: Control
var instruction_label: Label
var timer_label: Label

func _ready() -> void:
    is_active = true
    timer = duration
    build_ui()

func build_ui() -> void:
    ui_panel = Control.new()
    ui_panel.name = "MinigameUI"
    add_child(ui_panel)

    var background = ColorRect.new()
    background.color = Color(0.0, 0.05, 0.12, 0.7)
    background.size = Vector2(640, 140)
    background.position = Vector2(320, 80)
    ui_panel.add_child(background)

    instruction_label = Label.new()
    instruction_label.position = Vector2(340, 100)
    instruction_label.size = Vector2(600, 28)
    instruction_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    instruction_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    instruction_label.modulate = Color.CYAN
    instruction_label.text = instruction_text
    ui_panel.add_child(instruction_label)

    timer_label = Label.new()
    timer_label.position = Vector2(340, 140)
    timer_label.size = Vector2(600, 24)
    timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    timer_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    timer_label.modulate = Color.ORANGE
    timer_label.text = "Time: %.1f" % timer
    ui_panel.add_child(timer_label)

func _process(delta: float) -> void:
    if not is_active:
        return
    timer -= delta
    if timer <= 0.0:
        fail_minigame()
    if timer_label:
        timer_label.text = "Time: %.1f" % maxf(timer, 0.0)

func update_instruction(text: String) -> void:
    instruction_text = text
    if instruction_label:
        instruction_label.text = instruction_text

func success() -> void:
    is_active = false
    emit_signal("completed")

func fail_minigame() -> void:
    is_active = false
    emit_signal("failed")
