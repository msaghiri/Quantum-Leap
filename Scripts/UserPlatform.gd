extends StaticBody2D


var destructionTimer = 150;
	
func _physics_process(delta):
	
	
	translate(Vector2(-get_parent().GAME_SPEED, 0));
	if destructionTimer > 0:
		destructionTimer -= 1
	
	if destructionTimer == 0:
		queue_free()
	
	pass

#Temporary ill work on this later, not a priority
func destroy():
	queue_free()
