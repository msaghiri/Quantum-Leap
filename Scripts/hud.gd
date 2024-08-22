extends Control

var score = 0;
var countdown = 10;

var energyTween;

func _ready():
	score = 0;
	
	SingletonVariables.score = 0;
	SingletonVariables.energy = 100;
	SingletonVariables.coins = 0;
	
	$CoinIndicator.play();
	$PurchaseEnergy/AnimateText.play("fade")
	$EnergyBar.value = SingletonVariables.energy;
	$EnergyBar.tint_progress = Color.GOLD;
	$EnergyBar/EnergyDecay.start();
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Score
	if countdown > 0:
		countdown -= 1;
	elif countdown == 0:
		score += 1;
		SingletonVariables.score = score;
		countdown = 10;
	$ScoreLabel.text = "Score: " + str(score);
	$CoinAmt.text = "[center]" + str(SingletonVariables.coins);
	
	#Energy
	if SingletonVariables.energy <= 100:
		$EnergyBar.value = SingletonVariables.energy;
		$EnergyAmt.visible = false;
	elif SingletonVariables.energy > 100:
		$EnergyBar.value = 100;
		$EnergyAmt.text = "[center]" + str(SingletonVariables.energy);
		$EnergyAmt.visible = true;
	pass
	
	if energyTween != null:
		if energyTween.is_running() && get_parent().get_parent().get_node("Player").isOnElectric:
			energyTween.kill();
			
	if Input.is_action_just_pressed("purchase") && SingletonVariables.coins >= 5:
		SingletonVariables.coins -= 5;
		if(energyTween != null):
			if energyTween.is_running():
				energyTween.kill();
		quickAlterEnergy(10);

func alterEnergy(byValue: int):
	#Handle Colors
	
	if SingletonVariables.energy + byValue < 40:
		alterColor("aa002f7d");
	elif SingletonVariables.energy + byValue < 100:
		alterColor("0066727d");
	elif SingletonVariables.energy + byValue > 100:
		alterColor(Color.GOLD);
	
	#Handle Effects
	if SingletonVariables.energy + byValue < 40:
		get_parent().get_parent().get_node("Player").JUMP_VELOCITY = -400;
	else:
		get_parent().get_parent().get_node("Player").JUMP_VELOCITY = -450;
	
	#Actually add 
	energyTween = create_tween();
	energyTween.tween_property(SingletonVariables, "energy", SingletonVariables.energy + byValue, 1);
	
func quickAlterEnergy(byValue: int):
	#Handle Colors	
	if SingletonVariables.energy + byValue < 40:
		alterColor("aa002f7d");
	elif SingletonVariables.energy + byValue < 100:
		alterColor("0066727d");
	elif SingletonVariables.energy + byValue > 100:
		alterColor(Color.GOLD);
	
	#Handle Effects
	if SingletonVariables.energy + byValue < 40:
		get_parent().get_parent().get_node("Player").JUMP_VELOCITY = -400;
	else:
		get_parent().get_parent().get_node("Player").JUMP_VELOCITY = -450;
	
	#Actually Add
	SingletonVariables.energy += byValue;
	$EnergyBar.value = SingletonVariables.energy

func alterColor(newColor: Color):
	var tween = create_tween();
	tween.tween_property($EnergyBar, "tint_progress", newColor, 1);
func _on_energy_decay_timeout():
	if(SingletonVariables.energy > 4) && !get_parent().get_parent().get_node("Player").isOnElectric:
		alterEnergy(-3);
	pass 
