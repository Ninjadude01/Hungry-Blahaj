extends Node
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@export var monster: PackedScene = preload("res://scenes/cans.tscn")
@export var endScreen: String =("res://scenes/end_screen.tscn")

var spawn_interval: float = 2.0
var score = 0

func _ready() -> void:
	update_score_ui()
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)

func _on_spawn_timer_timeout() -> void:
	if monster:
		var monster_instance = monster.instantiate()
		var random_x = randf_range(-100,600)
		monster_instance.position = Vector2(random_x, -800.0)
		add_child(monster_instance)

func add_score(amount: int) -> void:
	score += amount
	update_score_ui()
	
	if score >= 15:
		get_tree().change_scene_to_file(endScreen)

func update_score_ui() -> void:
	if score_label:
		score_label.text = "Score: " + str(score) + " / 15"
