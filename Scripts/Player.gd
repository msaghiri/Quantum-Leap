extends CharacterBody2D

var JUMP_VELOCITY = -450.0
const ANIMATION_SPEED = 1.5;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jumping = false;
var isOnElectric = false;

var electricCountdown = 10;

func _ready():
	$JumpingCollision.disabled = true;
	$CollisionShape2D.disabled = false;

func _physics_process(delta):
	
	#Temporary game over mechanic
	if position.x < 0 || position.y > 400:
		die();
	
	if jumping && $JumpingCollision.disabled:
		$CollisionShape2D.disabled = true;
		$JumpingCollision.disabled = false;
	
	if is_on_floor() && jumping:
		$CollisionShape2D.disabled = false;
		$JumpingCollision.disabled = true;
		jumping = false;
	
	if(is_on_floor()):
		$PlayerAnimator.play("run", ANIMATION_SPEED, false);
		
	if velocity.y < 0:
		jumping = true;
	
	if !is_on_floor():
		velocity.y += gravity * delta;
	
	if isOnElectric && electricCountdown == 0:
		#SingletonVariables.energy += 2;
		get_parent().get_node("CanvasLayer/HUD").quickAlterEnergy(2);
		electricCountdown = 10;
	
	if(Input.is_action_just_pressed("jump") && is_on_floor()):
		if isOnElectric:
			jump(JUMP_VELOCITY, false, true);
		else:
			jump(JUMP_VELOCITY, false, false)
			
	if jumping && !$PlayerAnimator.animation == "jump":
		$PlayerAnimator.play("jump", ANIMATION_SPEED, false);
	
	if electricCountdown > 0:
		electricCountdown -= 1;
	
	move_and_slide()
	
func jump(height, platform, isElectric):
	velocity.y = height;
	$PlayerAnimator.play("jump", ANIMATION_SPEED, false);
	$CollisionShape2D.disabled = true;
	$JumpingCollision.disabled = false;
	jumping = true;
	
	if !platform:
		get_parent().get_node("CursorPlacer").canPlaceThisJump = true;
	
	if !platform && SingletonVariables.energy >= 3 && !isElectric:
		get_parent().get_node("CanvasLayer/HUD").alterEnergy(-3);
	pass

func die():
	SceneTransition.change_scene("res://Scenes/GUI/GameOver.tscn", Color.BLACK);
	pass	


func _on_detect_boost_area_entered(area):
	if area.name == "Bouncy":
		jump(-500, true, false);
		area.get_parent().destroy();
	pass 

func _on_detect_boost_body_entered(body):
	if body.has_method("isElectric"):
		if body.isElectric():
			isOnElectric = true;
	pass 
	
func _on_detect_boost_body_exited(body):
	if body.has_method("isElectric") && isOnElectric:
		isOnElectric = false;	
		if SingletonVariables.energy >= 40:
			JUMP_VELOCITY = -450
	pass 
