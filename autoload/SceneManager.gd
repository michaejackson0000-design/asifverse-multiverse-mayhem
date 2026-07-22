extends Node

func change_scene(path: String) -> void:
    get_tree().change_scene_to_file(path)

func transition_to_scene(path: String) -> void:
    var transition = preload("res://scenes/ui/scene_transition.tscn").instantiate()
    get_tree().current_scene.add_child(transition)
    transition.connect("transition_finished", Callable(self, "change_scene").bind(path))
    transition.play_out()
