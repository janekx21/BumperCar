require "entity"
require "vec"
require "spark"
require "blitz"
require "dusk"
require "world"
require "color"

export class Car extends Entity
	ground: {   love.graphics.newImage("pics/car-ground-black.png"),
				love.graphics.newImage("pics/car-ground-inner.png"),
				love.graphics.newImage("pics/car-ground-lower.png"),
				love.graphics.newImage("pics/car-ground-upper.png")
			}
	vertex: {   -32,-64+18,-32+18,-64,
				32-18,-64,32,-64+18
				32,64,
				-32,64}
	playerColors: {Color(1,0,0),Color(0,1,0),Color(0,1,1),Color(1,0,1)}
	shine: love.graphics.newImage "pics/shine.png"
	new:(pos,num)=>
		super pos
		@pos = pos
		@vel = vec!
		@num = num or 1 -- possible 1,2,3,4
		@body = love.physics.newBody(World.own.world,@pos.x,@pos.y,"dynamic")
		@shape = love.physics.newPolygonShape(@vertex)
		@fixture = love.physics.newFixture(@body,@shape)
		@fixture\setUserData({origen:@})
		@fixture\setRestitution 1
		@target = vec(1,0)
		@accel = 4000
		@apply = vec!
		@angle = 0
		@state = 0
		@deactTimer = 0
		@maxHP = 3
		@lives = @maxHP

		@body\setMassData 0,32,2,3400
		@body\setLinearDamping 2.8
		@body\setAngularDamping 3.8*10
		@debug = {vec!,vec!}
	
	update:(dt)=>
		super dt
		@deactTimer -= dt
		@pos = vec(@body\getPosition!)
		@vel = vec(@body\getLinearVelocity!)
		mouse = vec love.mouse.getPosition!
		@angle = @body\getAngle!

		@apply = vec 0,-48
		@apply\rotate @angle
		@apply\add @pos

		@target = vec!
		if @num == 1
			if love.mouse.isDown 1
				@target = mouse\copy!\sub @apply
		if @num == 2
			if World.own.joysticks[1] != Nil
				dir = vec World.own.joysticks[1]\getAxes!
				@target = dir

		
		if (@target.x != 0 or @target.y != 0) and @deactTimer<=0 and @lives > 0
			if @target\mag!>1
				@target\norm!
			speed = @accel
			if @state == 2
				speed *= 1.6
			if @state == 0
				speed *= .1
			@target\scale speed
			@body\applyForce @target.x,@target.y,@apply.x,@apply.y

		ray = vec 0,-64
		ray\rotate @angle
		ray\add @pos
		dir = vec 0,-64-@vel\mag!*.01-1
		dir\rotate @angle
		dir\add @pos
		callback = (fixture, x, y, xn, yn, fraction)->
			data= fixture\getUserData!
			if fixture != @fixture and data != Nil
				if data.origen != Nil
					if data.origen.deactTimer <= 0
						for i=1,8
							d = Dusk vec(x,y)
							d.vel\add data.origen.vel\copy!\scale .3
					data.origen\getHit(@)
			return 0
		if @lives > 0
			World.own.world\rayCast(ray.x,ray.y,dir.x,dir.y,callback)
		@debug = {ray,dir}


		start = vec 0,64-16
		start\rotate @angle
		start\add @pos
		coll = vec(math.floor(start.x/World.own.netSize),math.floor((start.y - 128)/World.own.netSize))
		@state = 0
		if coll.x >= 0 and coll.x < 8 and coll.y >= 0 and coll.y < 4 and @lives > 0
			@state = World.own.net[coll.y+1][coll.x+1]
			if World.own.net[coll.y+1][coll.x+1] == 1
				Spark start\copy!\add(vec(0,-128))
			if World.own.net[coll.y+1][coll.x+1] == 2
				Blitz start\copy!\add(vec(0,-128))
	
	getHit:(origen)=>
		if @deactTimer <= 0 and @lives > 0
			@lives -= 1
		@deactTimer = 1

	draw:=>
		love.graphics.setColor @playerColors[@num]\pack!
		if @deactTimer > 0 and math.floor(love.timer.getTime!*6)%2==0 or @lives == 0
			love.graphics.setColor 0,0,0,0
		love.graphics.draw(@shine,@pos.x,@pos.y,@angle,.6,1,128,128)
		love.graphics.setColor 1,1,1
		for i,p in pairs @ground
			if i == 2
				love.graphics.setColor @playerColors[@num]\copy!\scale(.8)\pack!
			else
				love.graphics.setColor 1,1,1
			for j=0,4
				love.graphics.draw(p,@pos.x,@pos.y-(i*4+j),@angle,1,1,32,64)
		start = vec 0,64-16
		start\rotate @angle
		start\add @pos
		love.graphics.line start.x,start.y - 16,start.x,start.y - 128
		love.graphics.setColor @playerColors[@num]\pack!
		love.graphics.line start.x,start.y - 16,start.x,start.y - 16 - ((128-16)*@lives/@maxHP)

		love.graphics.setColor 1,1,1
		ende = start\copy!\add @vel\copy!\scale -.02
		love.graphics.line start.x,start.y - 128,ende.x,ende.y - 128-16

		coll = vec(math.floor(start.x/World.own.netSize),math.floor((start.y - 128)/World.own.netSize))
		love.graphics.setColor 1,1,1
		if coll.x >= 0 and coll.x < 8 and coll.y >= 0 and coll.y < 4
			if World.own.net[coll.y+1][coll.x+1]!= 0
				love.graphics.setColor 1,0,0

		love.graphics.line start.x,start.y - 128,ende.x,ende.y - 128-16
		love.graphics.setColor 1,1,1
		--love.graphics.polygon("line", @body\getWorldPoints(@shape\getPoints()))
		if @deactTimer > 0
			love.graphics.print(@lives,@apply.x,@apply.y)

		love.graphics.line(@debug[1].x,@debug[1].y,@debug[2].x,@debug[2].y)


