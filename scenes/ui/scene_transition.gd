extends Control

signal transition_finished

func play_out() -> void:
    var tween = create_tween()
    tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 1), 0.3)
    tween.tween_callback(emit_signal.bind("transition_finished"))
