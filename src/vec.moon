
export class vec
	new:(x,y)=>
		@x = x or 0
		@y = y or 0
	
	clone:=>
		return vec(@x,@y)

	copy:=>
		return vec(@x,@y)

	add:(o)=>
		@x += o.x
		@y += o.y
		return @

	sub:(o)=>
		@x -= o.x
		@y -= o.y
		return @

	mul:(o)=>
		@x *= o.x
		@y *= o.y
		return @

	div:(o)=>
		@x /= o.x
		@y /= o.y
		return @

	ort:=>
		tmp = @x
		@x = @y
		@y = -tmp
		return @
	
	mag:=>
		return math.sqrt @x*@x + @y*@y

	norm:=>
		l = @mag!
		assert l!=0
		@x /= l
		@y /= l
		return @

	scale:(f)=>
		@x *= f
		@y *= f
		return @
	
	cross:(o)=>
		return @x * o.y - @y * o.x

	set:(x,y)=>
		@x = x
		@y = y
		return @
	
	put:(v)=>
		@x = v.x
		@y = v.y
		return @

	move:(t,md)=>
		v = t\copy!\sub(@)
		if v\mag! != 0
			if v\mag! <= md
				@put t
			else
				v\norm!\scale md
				@add v
		return @

	dis:(o)=>
		return o\copy!\sub(@)\mag!

	print:=>
		return "<"..@x..","..@y..">"


vec.lerp=(a,b,t)->a\copy!\scale(1-t)\add b\copy!\scale(t)
