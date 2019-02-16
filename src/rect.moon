require "vec"

export class rect
	new:(pos,size,pivot)=>
		@pos = pos or vec!
		@size = size or vec!
		@pivot = pivot or vec!
	
	get:=>
		return @pos\copy!\sub(@pivot) , @size

	inflate:(value)=>
		@size\add(value)
		@pivot\add(value\copy!\scale .5)

	center:=>
		@pivot = @size\copy!\scale(.5)
		return @

	
