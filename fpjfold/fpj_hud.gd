extends CanvasLayer


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var health: Control = $Health
var hudhealth = 7.0
@onready var coins = $Money

const HEART_ROW_SIZE = 10
const HEART_OFFSET = 16

func add_money(value):
	if int(coins.text) + value < 10:
		coins.text = "00" + str(int(coins.text) + value)
	elif int(coins.text) + value < 100:
		coins.text = "0" + str(int(coins.text) + value)
	else : 
		coins.text = str(int(coins.text) + value)

func create_heart():
	var newheart = Sprite2D.new()
	newheart.texture = health.texture
	newheart.hframes = health.hframes
	newheart.vframes = health.vframes
	newheart.frame = 8
	health.add_child(newheart)

#func draw_health():
	#for heart in health.get_children():
		#health.remove_child(heart)
	#for i in range(int(player.data.max_health)/20):
		#create_heart() # 1 heart per 20 hp

#func _ready() -> void:
	#draw_health()


func _process(_delta: float) -> void:
	var health_sprite = ""
	#var ph = player.data.health
	#var fh = floor(ph/20)
	#var rh = int(ph)%20
	for heart in health.get_children():
		var index = heart.get_index()
		var x = (index%HEART_ROW_SIZE) * HEART_OFFSET
		@warning_ignore("integer_division")
		var y = (index/HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		if hudhealth >= 7:
			health_sprite = "full"
		elif hudhealth == 6:
			health_sprite = "hit1"
		elif hudhealth == 5:
			health_sprite = "hit2"
		elif hudhealth == 4:
			health_sprite = "hit3"
		elif hudhealth == 3:
			health_sprite = "hit4"
		elif hudhealth == 2:
			health_sprite = "hit5"
		elif hudhealth == 1:
			health_sprite = "hit6"
		elif hudhealth <= 0:
			health_sprite = "dead"
		
		# frames 8 = empty, 7 1/4, 6 1/2, 3 3/4, 4 full
		#if index > fh:
			#heart.frame = 8
		#elif index == fh:
			#heart.frame = 8 - int(rh/5)
		#elif index < fh:
			#heart.frame = 4
	#pass
