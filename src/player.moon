require "vec"
require "entity"
require "particle"
require "dusk"

export class Player extends Entity
	img: love.graphics.newImage "pics/run.png"
	new:(pos)=>
		super pos
		@vel = vec!
		@img\setFilter "nearest","nearest"
		@speed = 64*4
		@z = 1
		@animTimer = 0
		@move = vec!
		@dir = 1
		@pTimer = 0
		@body = love.physics.newBody World.own.world,@pos.x,@pos.y,"dynamic"
		@shape = love.physics.newRectangleShape 32,32
		@fixture = love.physics.newFixture @body,@shape

		@body\setBullet true
		@body\setFixedRotation true

	update:(dt)=>
		super dt
		@pos\set @body\getX!,@body\getY!
		@vel.x,@vel.y = @body\getLinearVelocity!
		@move\set 0,0
		if love.keyboard.isDown "right" then @move.x += 1
		if love.keyboard.isDown "left" then @move.x += -1
		--@pos\add @move\copy!\scale @speed*dt
		@body\setLinearVelocity @move.x*@speed,@vel.y
		if @move\mag! >0
			@animTimer += dt
			@dir = @move.x
			if @pTimer <= 0
				Dusk @pos\copy!\add vec(0,32)
				@pTimer = .1
		@pTimer -= dt
	
	draw:=>
		quad = love.graphics.newQuad math.floor(@animTimer*12)%5*32,0,32,32,@img\getWidth!,@img\getHeight!
		love.graphics.draw @img,quad,@pos.x,@pos.y,0,@dir*2,2,@img\getWidth!/5/2,@img\getHeight!/2
