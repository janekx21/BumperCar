require "entity"
require "vec"

export class Particle extends Entity
	img: Nil
	new:(pos)=>
		super pos
		@vel = vec!
		@livetime = 1
		@r = 0
		@gravity = vec!
		@size = 1

	update:(dt)=>
		super dt
		@pos\add @vel\copy!\scale(dt)
		@vel\add @gravity\copy!\scale(dt)
		if @t > @livetime
			@die!

	draw:=>
		size = math.sin @t/@livetime*math.pi
		love.graphics.draw @img,@pos.x,@pos.y,@r,@size*size,@size*size,@img\getWidth!/2,@img\getHeight!/2
