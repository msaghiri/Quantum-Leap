extends Node2D


var GAME_SPEED = 0; 

var platformBigSource = preload("res://Scenes/Platforms/Platform.tscn")
var platformSmallSource = preload("res://Scenes/Platforms/SmallPlatform.tscn")


var platformBig = {
	"type": "big", 
	"platform": platformBigSource,
	"range_before": Vector2(75, 113), 
	"range_height": Vector2(250, 320),
	"range_high": Vector2(220, 300) 
}
var platformSmall = {
	"type": "small",
	"platform": platformSmallSource,
	"range_before_ifbig": Vector2(65, 100),
	"range_before": Vector2(60, 85),
	"range_before_ifhigher": Vector2(50, 65), 
	"range_high": Vector2(170, 210),
	"range_height": Vector2(195, 220)
}
var platforms = [platformBig, platformSmall];


#Normal Game_SPEED should be 5.5
func _ready():
	GAME_SPEED = 5.5;
	$GameMusic.play(6)
	pass 
func _process(delta):
	pass
