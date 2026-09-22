extends Area2D
@export var fall_speed: float = 200
@onready var skin: AnimatedSprite2D = $skin

func _ready()-> void:
	var skin_names = ["1", "2", "3"]
	var random_skin = skin_names.pick_random()
	skin.play(random_skin)

func _process(delta: float) -> void:
	position.y += fall_speed * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()
	
func _on_body_entered(body):
	if body.name == "player" or body.is_in_group("player"):
		# Find the main scene controller (Panel) to update score
		var main_node = get_tree().current_scene
		if main_node and main_node.has_method("add_score"):
			main_node.add_score(1)
		
		queue_free()
