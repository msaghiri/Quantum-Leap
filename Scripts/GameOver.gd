extends Node2D

func _ready():
	$ScoreLabel.text = "[center] Score: \n" + str(SingletonVariables.score);
	
	if FileAccess.file_exists("res://saves/savegame.txt"):
		var file = FileAccess.open("res://saves/savegame.txt", FileAccess.READ);
		var highScore = file.get_as_text();
		
		if SingletonVariables.score > int(highScore):
			var newFile = FileAccess.open("res://saves/savegame.txt", FileAccess.WRITE);
			newFile.store_string(str(SingletonVariables.score));
			return
		return
	pass

func _process(delta):
	pass
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			SceneTransition.change_scene("res://Scenes/MainGame.tscn", Color.BLACK);
