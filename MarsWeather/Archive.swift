struct Archive {
	
	// MARK: Properties
	
	let maxTemp: Float
	let minTemp: Float
	
	// MARK: Initializers
	
	// construct an Archive from a dictionary
	init(dictionary: [String:AnyObject]) {
		maxTemp = dictionary["max_temp"] as! Float
		minTemp = dictionary["min_temp"] as! Float
	}
}

