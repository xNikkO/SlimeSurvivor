extends Control

func _on_start_level2_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/slime_survivor_l2.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
