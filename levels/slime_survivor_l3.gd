extends Node2D

var coins_collected = 0
const COINS_TO_WIN = 10
var mega_mobs_killed = 0

const PINE_TREE_SCENE = preload("res://pine_tree.tscn")
const TREE_COUNT = 70 # Najwięcej drzew na ostatnim poziomie
const SPAWN_AREA_MIN = Vector2(-4000, -3000)
const SPAWN_AREA_MAX = Vector2(4000, 3000)
const MIN_DISTANCE_BETWEEN_TREES = 150

var generated_tree_positions = []

func _ready():
	$UI/CoinCounter.text = "Monety: %d/%d" % [coins_collected, COINS_TO_WIN]
	$Timer.wait_time = $Timer.wait_time / 1.8
	
	generate_trees() # Generuj drzewa
	
	await get_tree().create_timer(1.0).timeout
	spawn_mega_mob()

func _process(delta):
	var time_left = $LevelTimer.time_left
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	$UI/TimeLabel.text = "%02d:%02d" % [minutes, seconds]

func generate_trees():
	for i in range(TREE_COUNT):
		var new_tree_position = Vector2.ZERO
		var valid_position_found = false
		var attempts = 0
		
		while not valid_position_found and attempts < 100:
			var random_x = randf_range(SPAWN_AREA_MIN.x, SPAWN_AREA_MAX.x)
			var random_y = randf_range(SPAWN_AREA_MIN.y, SPAWN_AREA_MAX.y)
			new_tree_position = Vector2(random_x, random_y)
			
			valid_position_found = true
			for existing_pos in generated_tree_positions:
				if existing_pos.distance_to(new_tree_position) < MIN_DISTANCE_BETWEEN_TREES: # Poprawiona literówka
					valid_position_found = false
					break
			attempts += 1
			
		if valid_position_found:
			var tree = PINE_TREE_SCENE.instantiate()
			tree.position = new_tree_position
			add_child(tree)
			generated_tree_positions.append(new_tree_position)
		else:
			print("Nie udało się znaleźć miejsca dla drzewa po %d próbach." % attempts)

func spawn_mob():
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	new_mob.speed = 250.0 * 1.6 
	%PathFollow2D.progress_ratio = randf()
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, -3800, 3800)
	spawn_pos.y = clamp(spawn_pos.y, -2800, 2800)
	new_mob.global_position = spawn_pos
	add_child(new_mob)
	
func spawn_mega_mob():
	if mega_mobs_killed < 5:
		var new_mega_mob = preload("res://mobs/mega_mob.tscn").instantiate()
		%PathFollow2D.progress_ratio = randf()
		var spawn_pos = %PathFollow2D.global_position
		spawn_pos.x = clamp(spawn_pos.x, -3800, 3800)
		spawn_pos.y = clamp(spawn_pos.y, -2800, 2800)
		new_mega_mob.global_position = spawn_pos
		add_child(new_mega_mob)

func spawn_final_mob():
	var final_mob = preload("res://mobs/final_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	var spawn_pos = %PathFollow2D.global_position
	spawn_pos.x = clamp(spawn_pos.x, -3800, 3800)
	spawn_pos.y = clamp(spawn_pos.y, -2800, 2800)
	final_mob.global_position = spawn_pos
	add_child(final_mob)
	
	if has_node("BossMusic"):
		get_node("BossMusic").play()

func _on_mega_mob_died():
	mega_mobs_killed += 1
	if mega_mobs_killed < 5:
		await get_tree().create_timer(3.0).timeout
		spawn_mega_mob()
	elif mega_mobs_killed == 5:
		await get_tree().create_timer(3.0).timeout
		spawn_final_mob()

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_coin_collected() -> void:
	coins_collected += 1
	$UI/CoinCounter.text = "Monety: %d/%d" % [coins_collected, COINS_TO_WIN]
	if coins_collected >= COINS_TO_WIN:
		if has_node("BossMusic"):
			get_node("BossMusic").stop()
		get_tree().change_scene_to_file("res://levels/win_screen.tscn")

func _on_LevelTimer_timeout() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true
