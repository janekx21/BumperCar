
export class Dusk extends Particle
	img: love.graphics.newImage "pics/dust.png"
	new:(pos)=>
		super pos
		@size = 2
		@livetime = 1
		@vel = vec(math.random(-20.0,20.0),math.random(-30.0,-10))
		@r = math.random 0,math.pi*2
		@gravity = vec 0,-40
		@img\setFilter "nearest","nearest"
