require "vec"

export class Entity
	new:(pos)=>
		@pos = pos
		@z = 0
		@t = 0
		table.insert Entity.all,@
	die:=>
		index = -1
		for i,item in pairs Entity.all
			if item == @
				index = i
				break
		if index != -1
			table.remove Entity.all,index
		else
			print "Entity not found"
	
	update:(dt)=>
		@t += dt
	
	draw:=>Nil
		
Entity.all = {}
