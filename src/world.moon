
require "entity"
require "vec"
require "rect"

export class World
	own: Nil
	bg: love.graphics.newImage "pics/bg.png"
	fg: love.graphics.newImage "pics/fg.png"
	shine: love.graphics.newImage "pics/shine.png"
	grill: love.graphics.newImage "pics/grill.png"
	grillBorder: love.graphics.newImage "pics/grill-border.png"

	new:=>
		@@own = @
		@world = love.physics.newWorld 0,0,true
		love.physics.setMeter 64
		@body = love.physics.newBody @world,0,0
		@shapeU = love.physics.newEdgeShape 0,60,960,60
		@fixtureU = love.physics.newFixture @body,@shapeU
		@shapeR = love.physics.newEdgeShape 960-38,0,960-38,540
		@fixtureR = love.physics.newFixture @body,@shapeR
		@shapeL = love.physics.newEdgeShape 0+38,0,0+38,540
		@fixtureL = love.physics.newFixture @body,@shapeL
		@shapeB = love.physics.newEdgeShape 0,540,960,540
		@fixtureB = love.physics.newFixture @body,@shapeB

		@net = {{1,1,2,2,1,1,2,1},
				{1,2,1,0,1,1,0,1},
				{1,0,1,2,2,1,0,1},
				{1,1,1,1,1,1,1,1}}

		@netSize = 120

		@joysticks = love.joystick.getJoysticks!
		@spot = {pos:vec!,color:Color!,t:0}

	update:(dt)=>
		@world\update dt
		for e in *Entity.all
			if e!=Nil
				e\update dt

		@spot.t -= dt
		if @spot.t < 0
			@spot.t = .6
			@spot.pos = vec(math.random(64,960-64),math.random(64,450-64))
			@spot.color = Color.fromHSL(math.random(0.0,255)/255.0,1,.5)


	draw:=>
		love.graphics.draw @bg,0,0
		for e in *Entity.all
			if e!=Nil
				e\draw!
		
		love.graphics.setColor @spot.color.r,@spot.color.g,@spot.color.b,.2
		love.graphics.draw @shine,@spot.pos.x,@spot.pos.y

		love.graphics.setColor 1,1,1
		love.graphics.draw @fg,0,0


		for y,line in pairs @net
			for x,v in pairs line
				if v != 0
					if v == 1
						love.graphics.setColor .7,.7,.7,.1
					if v == 2
						love.graphics.setColor 1,.3,.3,.2
					love.graphics.draw @grillBorder,(x-1)*@netSize,(y-1)*@netSize
					love.graphics.setColor 1,1,1,.1
					love.graphics.draw @grill,(x-1)*@netSize,(y-1)*@netSize
		love.graphics.setColor 1,1,1,1
		--love.graphics.polygon("line", @body\getWorldPoints(@shape\getPoints()))

