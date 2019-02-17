
export class Color
	new:(r,g,b)=>
		@r = r or 0
		@g = g or 0
		@b = b or 0
		@clamp!
	
	add:(o)=>
		@r += o.r
		@g += o.g
		@b += o.b
		@clamp!
		return @

	scale:(f)=>
		@r *= f
		@g *= f
		@b *= f
		@clamp!
		return @

	sub:(o)=>
		@r -= o.r
		@g -= o.g
		@b -= o.b
		@clamp!
		return @

	put:(value)=>
		@r = value.r
		@g = value.g
		@b = value.b
		return @

	clamp:=>
		if @r > 1 @r=1
		if @r < 0 @r=0
		if @g > 1 @g=1
		if @g < 0 @g=0
		if @b > 1 @b=1
		if @b < 0 @b=0
		return @

	copy:=> Color(@r,@g,@b)
	
	pack:=>
		return {@r,@g,@b}

Color.fromHSL = (h,s,l)->
	if s<=0 then return Color(l,l,l)
	h, s, l = h*6, s, l
	c = (1-math.abs(2*l-1))*s
	x = (1-math.abs(h%2-1))*c
	m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	color = Color((r+m),(g+m),(b+m))
	return color


Color.RED = Color 1,0,0
Color.GREEN = Color 0,1,0
Color.BLUE = Color 0,0,1
Color.WHITE = Color 1,1,1
Color.BLACK = Color 0,0,0
