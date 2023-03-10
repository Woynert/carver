extends Area2D

export var showWings = false

var alive = true
var canMove = true

var maxSpeed = 2
var acc = 1
var fricc = 1
var speed: Vector2 = Vector2.ZERO

func _ready():
	$Car1.visible = !showWings
	$CarWings.visible = showWings

func _physics_process(delta):
	var hKey = 0
	var vKey = 0
	
	if canMove:
		hKey = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		vKey = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if abs(hKey):
		speed.x += hKey * acc
	else:
		# friction
		if (abs(speed.x) <= fricc):
			speed.x = 0
		elif (abs(speed.x)):
			speed.x = max(0, abs(speed.x) - fricc) * sign(speed.x)
			pass
		else:
			speed.x = 0
			
	if abs(vKey):
		speed.y += vKey * acc
	else:
		# friction
		if (abs(speed.y) <= fricc):
			speed.y = 0
		elif (abs(speed.y)):
			speed.y = max(0, abs(speed.y) - fricc) * sign(speed.y)
			pass
		else:
			speed.y = 0
		
	# clamp
	speed.x = sign(speed.x) * min(abs(speed.x), abs(maxSpeed))
	speed.y = sign(speed.y) * min(abs(speed.y), abs(maxSpeed))
	
	# apply movement
	if alive:
		self.custom_move(speed)
		
	# check for extra collisions interactions
	collisions()
	
func collisions():
	
	# point
	var point = Rect2Col.collision_check(self, global_position, "point")
	if (point):
		point.queue_free()
		GlobalState.add_score()
		GameAudio.play_sound("point", 1, -20)
		
	# obstacle
	if (Rect2Col.collision_check(self, global_position, "enemy")):
		GlobalState.die()
		GameAudio.play_sound("collision")

func custom_move(speed: Vector2):
	
	if !Rect2Col.collision_check(self, global_position + Vector2(0, speed.y)):
		global_position.y += speed.y
	else:
		for i in range(1, abs(int(speed.y))):
			if !Rect2Col.collision_check(self, global_position + Vector2(0, sign(speed.y))):
				global_position.y += sign(speed.y)
			else:
				break
	
	if !Rect2Col.collision_check(self, global_position + Vector2(speed.x, 0)):
		global_position.x += speed.x
	else:
		for i in range(1, abs(int(speed.x))):
			if !Rect2Col.collision_check(self, global_position + Vector2(sign(speed.x), 0)):
				global_position.x += sign(speed.x)
			else:
				break
