extends CharacterBody2D

var health = 30
var max_health = 30
var speed = 350.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var game = get_tree().current_scene

func _ready():
	%FinalSlime.play_walk()
	
	if game.has_node("UI/BossHealthBar"):
		var hp_bar = game.get_node("UI/BossHealthBar")
		hp_bar.visible = true
		hp_bar.max_value = max_health
		hp_bar.value = health
	if game.has_node("UI/BossName"):
		game.get_node("UI/BossName").visible = true

func _physics_process(delta):
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	
	
func take_damage():
	health -= 1
	%FinalSlime.play_hurt()
	
	if game != null and game.has_node("UI/BossHealthBar"):
		game.get_node("UI/BossHealthBar").value = health
	
	if health <= 0:
		queue_free()
		
		if game != null and game.has_node("UI/BossHealthBar"):
			game.get_node("UI/BossHealthBar").visible = false
			game.get_node("UI/BossName").visible = false
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		const COIN_SCENE = preload("res://coin.tscn")
		for i in range(10):
			var coin = COIN_SCENE.instantiate()
			get_parent().add_child(coin)
			var angle = i * (PI * 2.0 / 10.0)
			var offset = Vector2(cos(angle), sin(angle)) * 120.0
			coin.global_position = global_position + offset
