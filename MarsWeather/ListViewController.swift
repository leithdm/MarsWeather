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
	
	var archives = [Archive]()
	private let cellIdentifier = "cell"
	private let refreshViewHeight: CGFloat = 200
	let marsWeatherAPI = MarsWeatherAPI()
	let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
	var pullToRefresh: PullToRefresh!
	
	//MARK: - lifecycle methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//register CustomTableViewCell
		tableView.registerClass(CustomTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
		
		//navbar title
		navigationItem.title = "Weather on Mars"
		navigationController?.navigationBar.tintColor = UIColor.whiteColor()
		
		//setup the tableView
		tableView.rowHeight = 70
		tableView.frame = CGRect(x: 50, y: 0, width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds))
		
		//pull to refresh
		pullToRefresh = PullToRefresh(frame: CGRect(x: 0, y: -refreshViewHeight, width: CGRectGetWidth(view.bounds), height: refreshViewHeight), scrollView: tableView)
		view.insertSubview(pullToRefresh, atIndex: 0)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		getWeatherFromMars()
	}
	
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		pullToRefresh.scrollViewDidScroll(scrollView)
		getWeatherFromMars()
	}
	
	override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		pullToRefresh.scrollViewDidEndDecelerating(scrollView)
	}
	
	func getWeatherFromMars() {
		marsWeatherAPI.getWeatherOnMars { (data, error) -> Void in
			
			guard let data = data else {
				self.performUIUpdatesOnMain({ () -> Void in
					let alert = UIAlertController(title: "Error", message: "Please check your network connection", preferredStyle: .Alert)
					let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
					alert.addAction(action)
					self.presentViewController(alert, animated: true, completion: nil)
				})
				return
			}
			
			var localArchives = [Archive]()
			
			for archiveDay in data {
				let newArchive = Archive(dictionary: archiveDay)
				localArchives.append(newArchive)
			}
			
			self.archives = localArchives
			
			self.performUIUpdatesOnMain({ () -> Void in
				self.tableView.reloadData()
			})
		}
	}
	
	//MARK: - tableView methods
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
		
		let archive = self.archives[indexPath.row]
		
		//basic setup of the table cell
		performUIUpdatesOnMain { () -> Void in
			cell.textField.text = "Date: \(String(archive.terrestrialDate))"
			cell.descriptionTextField.text = "Max Temp: \(String(archive.maxTemp))ºC | Min Temp: \(String(archive.minTemp))ºC"
			tableView.reloadData()
		}
		return cell
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.archives.count
	}
	
	func performUIUpdatesOnMain(updates: () -> Void) {
		dispatch_async(dispatch_get_main_queue()) {
			updates()
		}
	}
}

