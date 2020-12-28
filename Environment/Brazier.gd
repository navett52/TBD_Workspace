extends Sprite

var flame_color: Color = Color.white

func interact(current_tool: int) -> void:
	if current_tool == G.Items.LANTERN:
		flame_color = Color.blue
		self.modulate = flame_color
