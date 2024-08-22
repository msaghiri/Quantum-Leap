extends Node2D

var placeable = load("res://Scenes/Platforms/UserPlatform.tscn")

var canPlace = true
var canPlaceThisJump = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass 
	
func _process(delta):
	position = (get_global_mouse_position() / 16).floor() * 16
	
	if canPlace && !get_parent().get_node("Player").is_on_floor() && canPlaceThisJump:
		$Predictor/Sprite2D.modulate = Color.WHITE
	else:
		$Predictor/Sprite2D.modulate = Color.DARK_RED
	
	if Input.is_action_just_pressed("place") && canPlace && canPlaceThisJump && !get_parent().get_node("Player").is_on_floor():
		place()

	pass

func place():
	var newPlatform = placeable.instantiate();
	newPlatform.position = position
	get_parent().add_child(newPlatform)
	get_parent().get_node("CanvasLayer/HUD").alterEnergy(-20);
	canPlaceThisJump = false


func _on_predictor_body_entered(body):
	canPlace = false
func _on_predictor_body_exited(body):
	canPlace = true
