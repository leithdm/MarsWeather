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
	let textData = ["a", "b", "c", "d"]
	let detailTextLabel = ["foo", "bar", "foobar", "foob"]
	private let cellIdentifier = "cell"
	
	//MARK: - lifecycle methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//register CustomTableViewCell
		tableView.registerClass(CustomTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
		
		//refresh button
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
		
		//setup the tableView
		tableView.rowHeight = 60
		tableView.dataSource = self
		tableView.delegate = self
		tableView.frame = CGRect(x: 50, y: 0, width: view.bounds.width, height: view.bounds.height)
	}

	//TODO: - add functionality
	func refresh() {
		//
	}
	
	//MARK: - tableView methods
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
		
		//basic setup of the table cell
		cell.textField.text = textData[indexPath.row]
		cell.descriptionTextField.text = detailTextLabel[indexPath.row]
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		//
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return textData.count
	}

}

