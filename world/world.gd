extends Spatial

var score

#onready var score_label

# reset game
func reset_game():
	score = 0

	
# Called when the node enters the scene tree for the first time.
func _ready():
	
	# score
	score = 0
	
	$UI/Score.text = str(score)


# collision handling
func on_collision_of_man():

	score -=1
	print("collision of man")
	
	# update score
	$UI/Score.text = str(score)


# collision handling
func on_man_survived():

	score +=1
	print("man_survived")
	
	# update score
	$UI/Score.text = str(score)


