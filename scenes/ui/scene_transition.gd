extends Control

signal transition_finished

func _ready() -> void:
    modulate = Color(0, 0, 0, 0)

func play_out() -> void:
    var tween = create_tween()
    tween.tween_property(self, "modulate", Color(0, 0, 0, 1), 0.15)
    tween.tween_callback(Callable(self, "_on_transition_complete"))

func _on_transition_complete() -> void:
    emit_signal("transition_finished")
