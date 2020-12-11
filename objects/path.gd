extends Path

onready var follow = get_node("follow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# follow path
	follow.set_offset(follow.get_offset() + 10 * delta)
