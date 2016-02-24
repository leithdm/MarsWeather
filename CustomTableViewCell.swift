//
//  CustomTableViewCell.swift
//  WhiteHouseAPI
//
//  Created by Darren Leith on 24/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	//MARK: - properties
	
	var textField: UITextField = UITextField()
	var descriptionTextField: UITextField = UITextField()
	
	
	//MARK: - selected state of the cell
	
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
	
	//MARK: - initializor
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		//TODO: refactor
		
		//textField properties
		textField = UITextField(frame: CGRect(x: 10, y: 0, width: self.bounds.size.width, height: 40))
		textField.font = UIFont(name: "Arial", size: 20.0)
		textField.delegate = self
		
		//descriptionTextField properties
		descriptionTextField = UITextField(frame: CGRect(x: 10, y: 40, width: self.bounds.size.width, height: 15))
		descriptionTextField.textColor = UIColor.darkGrayColor()
		descriptionTextField.font = UIFont(name: "Arial", size: 14.0)
		descriptionTextField.allowsEditingTextAttributes = false
		descriptionTextField.delegate = self
		
		//add textfields
		addSubview(textField)
		addSubview(descriptionTextField)
	}
	

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - textfield delegate methods
extension CustomTableViewCell: UITextFieldDelegate {
	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
		return false
	}
}
