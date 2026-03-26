extends CharacterBody2D

var health = 2
var speed = 250.0

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	
	
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
