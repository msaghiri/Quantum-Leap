extends Node2D

func _ready():
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.25).timeout
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play_backwards("fade_in")
	await $AnimationPlayer.animation_finished
	SceneTransition.change_scene("res://Scenes/MainMenu.tscn", Color.AQUA)
	pass 
