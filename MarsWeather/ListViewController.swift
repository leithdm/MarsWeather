//
//  ViewController.swift
//  WhiteHouseAPI
//
//  Created by Darren Leith on 24/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

	//MARK: - properties
	
	//dummy data to confirm functionality
	var archives = [Archive]()

	private let cellIdentifier = "cell"
	let marsWeatherAPI = MarsWeatherAPI()
	
	//MARK: - lifecycle methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//register CustomTableViewCell
		tableView.registerClass(CustomTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
		
		//refresh button
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
		
		//setup the tableView
		tableView.rowHeight = 60
		tableView.frame = CGRect(x: 50, y: 0, width: view.bounds.width, height: view.bounds.height)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		getWeatherFromMars()
	}
	
	func getWeatherFromMars() {
		
		marsWeatherAPI.getWeatherOnMars { (data, error) -> Void in
			
			guard let data = data else {
				print("error parsing data")
				return 
			}

			for archiveDay in data {
				let newArchive = Archive(dictionary: archiveDay)
				self.archives.append(newArchive)
			}
			
			self.performUIUpdatesOnMain({ () -> Void in
				self.tableView.reloadData()
			})
		}
	}

	//TODO: - add functionality
	func refresh() {
		tableView.reloadData()
	}
	
	//MARK: - tableView methods
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
		
		let archive = archives[indexPath.row]
		
		//basic setup of the table cell
		performUIUpdatesOnMain { () -> Void in
			cell.textField.text = "Date: \(String(archive.terrestrialDate))"
			cell.descriptionTextField.text = "Max Temp: \(String(archive.maxTemp))ºC | Min Temp: \(String(archive.minTemp))ºC"
			tableView.reloadData()
		}
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		//
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return archives.count
	}

	func performUIUpdatesOnMain(updates: () -> Void) {
		dispatch_async(dispatch_get_main_queue()) {
			updates()
		}
	}
}

