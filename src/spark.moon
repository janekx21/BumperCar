require "particle"

export class Spark extends Particle
	img: love.graphics.newImage "pics/spark-blue.png"
	new:(pos)=>
		super pos
		@size = math.random .4,.8
		@livetime = .6
		@vel = vec(math.random(-90.0,90.0),math.random(-120.0,-50))
		@r = @vel\angle!
		@gravity = vec 0,280
		@img\setFilter "linear","linear"
	
	update:(dt)=>
		super dt
		@r = @vel\angle!+math.pi/2
