function lure.dom.createHTMLTableElement()
	local self = lure.dom.nodeObj.new(1)
	
	--===================================================================
	-- PROPERTIES                                                       =
	--===================================================================
	self.tagName 	= "table"
	---------------------------------------------------------------------
	self.nodeName 	= "TABLE"	
	---------------------------------------------------------------------
	self.nodeDesc	= "HTMLTableElement"
	---------------------------------------------------------------------
	self.style		= lure.dom.HTMLNodeStyleobj.new(self)
	---------------------------------------------------------------------
	
	--===================================================================
	-- MUTATORS                                                         =
	--===================================================================
	
	--===================================================================
	-- METHODS	                                                        =	
	--===================================================================
	self.update = function()
		
	end
	---------------------------------------------------------------------
	self.draw = function()
		
	end
	---------------------------------------------------------------------
	
	return self
end