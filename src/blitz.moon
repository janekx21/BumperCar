require "particle"

export class Blitz extends Particle
	img: love.graphics.newImage "pics/blitz.png"
	new:(pos)=>
		super pos
		@size = math.random .4,.8
		@livetime = .6
		@vel = vec(math.random(-250.0,250.0),math.random(-220.0,-50))
		@r = @vel\angle!
		@gravity = vec 0,280
		@img\setFilter "linear","linear"
	
	update:(dt)=>
		super dt
		@r = @vel\angle!+math.pi/2
