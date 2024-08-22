extends StaticBody2D

@onready var coinSource = preload("res://Scenes/Coin.tscn");

var spawnTimer = 0;
var electric = false
var first = true

var xpos = 222;
var ypos = 254;

var type;
var nextType;
var nextHeight;

var bigSpawnPoints = [Vector2(14, -20), Vector2(100, -20), Vector2(180, -20), Vector2(260, -20), Vector2(265, -20)]
var smallSpawnPoints = [Vector2(14, -20), Vector2(70, -20), Vector2(126, -20)]

func _ready():
	
	var rngElectric = RandomNumberGenerator.new();
	rngElectric.randomize()
	var elecnum = rngElectric.randi_range(1, 5);
	if elecnum == 1:
		electric = true 
		
	position.x = xpos;
	position.y = ypos;
	
		
	if electric:
		$GPUParticles2D.emitting = true;
	else:
		$GPUParticles2D.emitting = false;
		var rngCollectibles = RandomNumberGenerator.new();
		rngCollectibles.randomize();
		var collectNum = rngCollectibles.randi_range(1, 3);
		if collectNum == 1 && !first:
			spawnCollectables(type.type)
	
	var rngType = RandomNumberGenerator.new();
	var rngTimer = RandomNumberGenerator.new();
	rngTimer.randomize();
	rngType.randomize();
	
	nextType = get_parent().platforms[rngType.randi_range(0, 1)];
	
	
	var rngHeight = RandomNumberGenerator.new()
	rngHeight.randomize()
	nextHeight = rngHeight.randi_range(nextType.range_height.x, nextType.range_height.y)
	
	if !first:
		spawnTimer = rngTimer.randi_range(nextType.range_before.x, nextType.range_before.y)
	
	if type == get_parent().platforms[1] && nextType == get_parent().platforms[0]:
		spawnTimer = rngTimer.randi_range(nextType.range_before.x, nextType.range_before.y-20);
	
	#Fix two small platforms bug
	if type == get_parent().platforms[0] && nextType == get_parent().platforms[1]:
		spawnTimer = rngTimer.randi_range(nextType.range_before_ifbig.x, nextType.range_before_ifbig.y)
	if position.y < 250:
		nextHeight = rngHeight.randi_range(nextType.range_high.x, nextType.range_high.y);
	
	if type == get_parent().platforms[1] && nextType == get_parent().platforms[1] && nextHeight < position.y - 50:
		spawnTimer = rngTimer.randi_range(nextType.range_before_ifhigher.x, nextType.range_before_ifhigher.y)

func _physics_process(delta):
	translate(Vector2(-(get_parent().GAME_SPEED), 0));
	
	if(spawnTimer > 0):
		spawnTimer -= 1;
	elif spawnTimer == 0:
		spawnNewPlatform(nextHeight);
		spawnTimer = -1;
	
	if position.x < -300:
		queue_free()
	
	pass
func spawnNewPlatform(nextHeight):
	
	var newPlat = nextType.platform.instantiate()
	newPlat.first = false
	newPlat.type = nextType;
	newPlat.xpos = 620
	newPlat.ypos = nextHeight
	get_parent().add_child(newPlat)
	pass
	
func spawnCollectables(typeof: String):
	
	var rngAmt = RandomNumberGenerator.new()
	rngAmt.randomize()
	
	if typeof == "big":
		var amt = rngAmt.randi_range(1, 4)
		
		for i in amt:
			var newCoin = coinSource.instantiate();
			var coinPos = bigSpawnPoints[i];
			newCoin.position = coinPos;
			add_child(newCoin);
		pass
	elif typeof == "small":
		var amt = rngAmt.randi_range(1, 3);
		
		for i in amt:
			var newCoin = coinSource.instantiate();
			var coinPos = smallSpawnPoints[i];
			newCoin.position = coinPos;
			add_child(newCoin);
		
		pass
	pass


func isElectric():
	return electric;
