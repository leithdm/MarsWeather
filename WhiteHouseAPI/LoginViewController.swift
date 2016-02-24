//
//  LoginViewController.swift
//  WhiteHouseAPI
//
//  Created by Darren Leith on 24/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	//TODO: this is a dummy implementation for a login screen
	
	//MARK: - properties
	var sampleText: UILabel!
	var button: UIButton!
	
	
	//MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

		//configure a UILabel with sample text
		sampleText = UILabel(frame: CGRect(x: view.bounds.width/2 - 50 , y: view.bounds.height/2, width: 100, height: 50))
		sampleText.textAlignment = .Center
		sampleText.text = "Test View"
		view.addSubview(sampleText)
		
		//configure a UIButton to segue over to ListViewController
		button = UIButton(frame: CGRect(x: (CGRectGetWidth(view.bounds)/2 - 50), y: view.bounds.height - 100 , width: 100, height: 50))
		button.setTitle("Click Me", forState: .Normal)
		button.setTitleColor(UIColor.blueColor(), forState: .Normal)
		button.addTarget(self, action: "segueToListViewController", forControlEvents: .TouchUpInside)
		view.addSubview(button)
    }

	func segueToListViewController() {
		let controller = ListViewController()
		presentViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
	}

}
