function love.conf(t)
	t.window.width = 720
	t.window.height = 576
	t.window.minwidth = 720
	t.window.minheight = 576
	t.window.resizable = true
	t.accelerometerjoystick = false
	t.modules.joystick = false
	t.modules.physics = true
	t.title = "Physics@Home"
	--t.window.icon = "textures/icon.png"
end
