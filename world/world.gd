extends Spatial

var score


# reset game
func reset_game():
	score = 0

	
# Called when the node enters the scene tree for the first time.
func _ready():
	
	# score
	score = 0


# collision handling
func on_collision_of_man():

	print("collision of man")


