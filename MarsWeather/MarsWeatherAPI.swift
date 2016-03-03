//
//  MarsWeatherAPI.swift
//  MarsWeatherAPI
//
//  Created by Darren Leith on 24/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import Foundation

class MarsWeatherAPI: NSObject {
	
	//MARK: - properties
	
	let stringURL: String = "http://marsweather.ingenology.com/v1/archive/"
	let session: NSURLSession
	
	override init() {
		session = NSURLSession.sharedSession()
	}
	
	func getWeatherOnMars(completionHandler: (data: [[String: AnyObject]]?, error: String?) -> Void) {
		
		let request = NSMutableURLRequest(URL: NSURL(string: stringURL)!)
		request.HTTPMethod = "GET"
		
		//create a task
		let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
			
			guard error == nil else {
				completionHandler(data: nil, error: "Error parsing data")
				return
			}
			
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
				completionHandler(data: nil, error: "Network error")
				return
			}
			
			guard let data = data else {
				completionHandler(data: nil, error: "No data returned")
				return
			}
			
			self.parseWeatherData(data, completionHandler: completionHandler)
		}
		task.resume()
	}
	
	func parseWeatherData(data: NSData, completionHandler: (result: [[String: AnyObject]]?, error: String?) -> Void) {
		var parsedWeatherData: AnyObject!
		do {
			parsedWeatherData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject]
			if let report = parsedWeatherData["results"] as? [[String: AnyObject]] {
				completionHandler(result: report, error: nil)
				return
			}
		} catch {
			completionHandler(result: nil, error: "Could not find the weather report")
		}
	}
}
