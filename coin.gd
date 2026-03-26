extends Area2D

signal collected

func _ready():
	var game = get_tree().current_scene
	if game.has_method("_on_coin_collected"):
		collected.connect(game._on_coin_collected)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collected.emit()
		queue_free()
