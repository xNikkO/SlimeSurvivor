extends Control

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/slime_survivor_l1.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
