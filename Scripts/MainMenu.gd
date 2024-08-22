extends Node2D

@onready var highScore;

func _ready():
	if not FileAccess.file_exists("res://saves/savegame.txt"):
		highScore = 0;
	else:
		var file = FileAccess.open("res://saves/savegame.txt", FileAccess.READ);
		highScore = file.get_as_text();
		
	
	$MenuMusic.play(3.5)
	$HighScore.text = "High Score: " + str(highScore);
	pass 
	
@onready var currentFocus = $StartButton
func _process(delta):
	$MenuBG.scroll_offset.x -= 150 * delta;
	
	if Input.is_action_just_pressed("up") || Input.is_action_just_pressed("down"):
		$MenuSFX.play()
		if currentFocus == $StartButton:
			currentFocus = $QuitButton
		elif currentFocus == $QuitButton:
			currentFocus = $StartButton
			
	if Input.is_action_just_pressed("ui_accept"):
		currentFocus.emit_signal("pressed")
		pass
	
	if currentFocus == $StartButton:
		$trianglePointer.position = Vector2(36, 284)
		$StartButton.add_theme_color_override("font_color", Color.HOT_PINK)
		$StartButton.add_theme_color_override("font_hover_color", Color.HOT_PINK)
		
		$QuitButton.add_theme_color_override("font_color", Color.WHITE)
		$QuitButton.add_theme_color_override("font_hover_color", Color.WHITE)
	elif currentFocus == $QuitButton:
		$trianglePointer.position = Vector2(36, 330)
		$QuitButton.add_theme_color_override("font_color", Color.LIGHT_PINK)
		$QuitButton.add_theme_color_override("font_hover_color", Color.LIGHT_PINK)
		
		$StartButton.add_theme_color_override("font_color", Color.WHITE)
		$StartButton.add_theme_color_override("font_hover_color", Color.WHITE)
	
	pass



#36x284
#36x330
#Pointer

func _on_start_button_mouse_entered():
	if currentFocus != $StartButton:
		$MenuSFX.play()
		currentFocus = $StartButton
	pass 
func _on_quit_button_mouse_entered():
	if currentFocus != $QuitButton:
		$MenuSFX.play()
		currentFocus = $QuitButton
	pass 



#Button Functionality
func _on_start_button_pressed():
	SceneTransition.change_scene("res://Scenes/MainGame.tscn", Color.BLACK)
	pass 

func _on_quit_button_pressed():
	get_tree().quit()
	pass 


func _on_credits_button_pressed():
	SceneTransition.change_scene("res://Scenes/Credits.tscn", Color.BLACK)
	pass 
