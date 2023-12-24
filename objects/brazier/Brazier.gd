extends Sprite2D

var flame_color: Color = Color.WHITE

func interact(current_tool: int) -> void:
	if current_tool == G.Items.LANTERN:
		flame_color = Color.BLUE
		self.modulate = flame_color
