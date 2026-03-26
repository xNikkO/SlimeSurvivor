extends Node

var main_music: AudioStreamPlayer
var game_music_stream = preload("res://sounds/game_music.mp3")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	main_music = AudioStreamPlayer.new()
	main_music.stream = game_music_stream
	main_music.volume_db = -20.0 
	add_child(main_music)
	main_music.play()

func mute_music():
	main_music.volume_db = -80.0

func resume_music():
	main_music.volume_db = -20.0
