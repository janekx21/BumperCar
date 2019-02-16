
require "player"
require "entity"
require "vec"
require "rect"

export class World
	own: Nil
	new:=>
		@@own = @
		@world = love.physics.newWorld 0,32*9.8,true
		love.physics.setMeter 32
		@body = love.physics.newBody @world,0,400
		@shape = love.physics.newRectangleShape 900,32
		@fixture = love.physics.newFixture @body,@shape
		--@player = Player vec(300,300)
		@v = 0

	update:(dt)=>
		@world\update dt
		for e in *Entity.all
			if e!=Nil
				e\update dt
		if love.keyboard.isDown("a")
			@v += dt*32
		if love.keyboard.isDown("s")
			@v -= dt*32

	draw:=>
		for e in *Entity.all
			if e!=Nil
				e\draw!

		r = rect vec(128,128),vec(64,80),vec(32,0)
		r\center!
		r\inflate(vec(@v,@v))
		a,b = r\get!
		love.graphics.setColor 0,1,0
		love.graphics.rectangle "line",a.x,a.y,b.x,b.y
		love.graphics.circle "line",r.pos.x,r.pos.y,2
		love.graphics.setColor 1,0,0
		love.graphics.rectangle "line",r.pos.x,r.pos.y,r.size.x,r.size.y
