extends Node

var shake_time: float = 0.0
var shake_amount: float = 0.0
var shake_decay: float = 0.0

func _process(delta: float) -> void:
    if shake_time > 0.0:
        shake_time = max(shake_time - delta, 0.0)
        var camera = get_viewport().get_camera_2d()
        if camera:
            camera.offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
    elif shake_amount > 0.0:
        var camera = get_viewport().get_camera_2d()
        if camera:
            camera.offset = Vector2.ZERO
        shake_amount = 0.0

func screen_shake(amount: float = 8.0, duration: float = 0.2) -> void:
    shake_amount = amount
    shake_time = duration

func spawn_particles(position: Vector2, color: Color) -> void:
    # Placeholder for future particle effects.
    pass
