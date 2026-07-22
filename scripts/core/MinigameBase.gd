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
var countdown_label: Label

func _ready() -> void:
    timer = duration
    build_ui()
    _start_intro()

func build_ui() -> void:
    ui_panel = Control.new()
    ui_panel.name = "MinigameUI"
    add_child(ui_panel)
    ui_panel.anchor_left = 0.0
    ui_panel.anchor_top = 0.0
    ui_panel.anchor_right = 1.0
    ui_panel.anchor_bottom = 0.0
    ui_panel.margin_left = 0
    ui_panel.margin_top = 12
    ui_panel.margin_right = 0
    ui_panel.margin_bottom = 0

    var background = ColorRect.new()
    background.color = Color(0.02, 0.04, 0.12, 0.9)
    background.anchor_left = 0.1
    background.anchor_top = 0.0
    background.anchor_right = 0.9
    background.anchor_bottom = 0.18
    background.margin_left = 0
    background.margin_top = 0
    background.margin_right = 0
    background.margin_bottom = 0
    ui_panel.add_child(background)

    var border = StyleBoxFlat.new()
    border.bg_color = Color(0.06, 0.1, 0.2, 0.6)
    border.border_color = Color(0.35, 0.65, 1.0, 0.8)
    border.border_width_all = 2
    background.add_stylebox_override("panel", border)

    instruction_label = Label.new()
    instruction_label.name = "InstructionLabel"
    instruction_label.text = instruction_text
    instruction_label.theme_override_font_size = 24
    instruction_label.theme_override_colors/font_color = Color(0.78, 0.9, 1.0)
    instruction_label.anchor_left = 0.12
    instruction_label.anchor_top = 0.0
    instruction_label.anchor_right = 0.88
    instruction_label.anchor_bottom = 0.12
    instruction_label.margin_left = 0
    instruction_label.margin_top = 16
    instruction_label.margin_right = 0
    instruction_label.margin_bottom = 0
    instruction_label.align = Label.ALIGN_CENTER
    ui_panel.add_child(instruction_label)

    timer_label = Label.new()
    timer_label.name = "TimerLabel"
    timer_label.text = "Time: %.1f" % timer
    timer_label.theme_override_font_size = 18
    timer_label.theme_override_colors/font_color = Color(0.7, 0.6, 1.0)
    timer_label.anchor_left = 0.12
    timer_label.anchor_top = 0.12
    timer_label.anchor_right = 0.88
    timer_label.anchor_bottom = 0.18
    timer_label.margin_left = 0
    timer_label.margin_top = 4
    timer_label.margin_right = 0
    timer_label.margin_bottom = 0
    timer_label.align = Label.ALIGN_CENTER
    ui_panel.add_child(timer_label)

    countdown_label = Label.new()
    countdown_label.name = "CountdownLabel"
    countdown_label.text = "3"
    countdown_label.theme_override_font_size = 72
    countdown_label.theme_override_colors/font_color = Color(1, 0.6, 0.9)
    countdown_label.anchor_left = 0.35
    countdown_label.anchor_top = 0.0
    countdown_label.anchor_right = 0.65
    countdown_label.anchor_bottom = 0.5
    countdown_label.margin_left = 0
    countdown_label.margin_top = 10
    countdown_label.margin_right = 0
    countdown_label.margin_bottom = 0
    countdown_label.align = Label.ALIGN_CENTER
    ui_panel.add_child(countdown_label)

func _process(delta: float) -> void:
    if not is_active:
        return
    timer -= delta
    if timer_label:
        timer_label.text = "Time: %.1f" % maxf(timer, 0.0)
    if timer <= 0.0:
        fail_minigame()

func update_instruction(text: String) -> void:
    instruction_text = text
    if instruction_label:
        instruction_label.text = instruction_text

func success() -> void:
    is_active = false
    if countdown_label:
        countdown_label.text = "SUCCESS"
    var tween = create_tween()
    tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.12).from(Vector2(1, 1))
    tween.tween_callback(Callable(self, "_emit_completed"))

func fail_minigame() -> void:
    is_active = false
    if countdown_label:
        countdown_label.text = "FAIL"
    var tween = create_tween()
    tween.tween_property(self, "modulate", Color(1, 0.4, 0.4, 1), 0.12).from(Color(1, 1, 1, 1))
    tween.tween_callback(Callable(self, "_emit_failed"))

func _emit_completed() -> void:
    emit_signal("completed")

func _emit_failed() -> void:
    emit_signal("failed")

func _start_intro() -> void:
    is_active = false
    countdown_label.visible = true
    await get_tree().create_timer(0.5).timeout
    for count in [3, 2, 1]:
        countdown_label.text = str(count)
        await get_tree().create_timer(0.75).timeout
    countdown_label.text = "GO!"
    await get_tree().create_timer(0.4).timeout
    countdown_label.visible = false
    is_active = true
