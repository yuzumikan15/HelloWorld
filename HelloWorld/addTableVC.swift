//
//  AddTableVC.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright (c) 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit
import NorthLayout

class  AddTableVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	let width = UIScreen.mainScreen().bounds.width
	let height = UIScreen.mainScreen().bounds.height
	
	lazy var categoryField = UITextField()
	lazy var levelPicker = UIPickerView()
	lazy var levelButton = UIButton()
	lazy var titleField = UITextField()
	lazy var authorField = UITextField()
	lazy var urlField = UITextField()
	lazy var reviewField = PlaceHolderTextView()
	
	lazy var cancelButton = UIButton()
	lazy var addButton = UIButton()
	
	lazy var doneButtonView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
		
		setupTextFields()
		setupLevelButton()
		setupReviewField()
		setupCancelButton()
		setupAddButton()
		
		setupAutoLayout()
	}
	
	func setupLevelButton() {
		levelButton.setTitle("Level", forState: .Normal)
		levelButton.addTarget(self, action: "showLevelPicker:", forControlEvents: .TouchUpInside)
		levelButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
	}
	
	func showLevelPicker(sender: UIButton) {
		let alertController = UIAlertController(title: "Choose Level", message: "\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
		let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Cancel, handler: nil)
		alertController.addAction(action)
		
		levelPicker.delegate = self
		levelPicker.dataSource = self
		
		alertController.view.addSubview(levelPicker)
		self.presentViewController(alertController, animated: true, completion: nil)
	}
	
	func setupReviewField() {
		reviewField.placeHolder = "Review..."
		reviewField.font = UIFont(name: "Helvetica", size: 20)
		reviewField.layer.borderColor = UIColor.grayColor().CGColor
		reviewField.layer.borderWidth = 1.0
	}
	
	func setupTextFields() {
		setupTextField(categoryField, placeHolder: "Category")
		setupTextField(titleField, placeHolder: "Title")
		setupTextField(authorField, placeHolder: "Author")
		setupTextField(urlField, placeHolder: "URL")
	}
	
	func setupTextField(textField: UITextField, placeHolder: String) {
		textField.placeholder = placeHolder
		textField.font = UIFont(name: "Helvetica", size: 20)
		textField.borderStyle = UITextBorderStyle.RoundedRect
		textField.delegate = self
	}
	
	func setupCancelButton() {
		cancelButton.setTitle("Cancel", forState: .Normal)
		cancelButton.setTitleColor(UIColor.redColor(), forState: .Normal)
		cancelButton.addTarget(self, action: "backToMyStudyVC:", forControlEvents: .TouchUpInside)
	}
	
	func backToMyStudyVC(sender: UIButton) {
		self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
		self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func setupAddButton() {
		addButton.setTitle("Add", forState: .Normal)
		addButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		addButton.addTarget(self, action: "addTable:", forControlEvents: .TouchUpInside)
	}
	
	func addTable(sender: UIButton) {
		var newStudy = StudyData()
		newStudy.category = categoryField.text
		newStudy.level = toLevel(levelButton.titleLabel?.text)
		newStudy.title = titleField.text
		newStudy.author = authorField.text
		newStudy.url = NSURL(string: urlField.text)
		newStudy.review = reviewField.text
		
		studyData.append(newStudy)
		
		
		//close this view to back to myStudyVC
		self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
		self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
	}
	
	private func toLevel(string: String?) -> Level? {
		if let str = string {
			switch str {
			case "Beginner":
				return .Beginner
			case "Intermediate":
				return .Intermediate
			case "Senior":
				return .Senior
			case "Pro":
				return .Pro
			default:
				return nil
			}
		}
		else {
			return nil
		}
	}
	
	func setupAutoLayout() {
		let p: CGFloat = 8
		let t: CGFloat = 30
		let buttonW: CGFloat = width / 3
		let autolayout = view.northLayoutFormat(["p": p, "t": t, "buttonW": buttonW], [
			"category": categoryField,
			"level": levelButton,
			"title": titleField,
			"author": authorField,
			"url": urlField,
			"review": reviewField,
			"cancel": cancelButton,
			"add": addButton,
			])
		autolayout("H:|-p-[category]-p-[level(==buttonW)]-p-|")
		autolayout("H:|-p-[title]-p-|")
		autolayout("H:|-p-[author]-p-|")
		autolayout("H:|-p-[url]-p-|")
		autolayout("H:|-p-[review]-p-|")
		autolayout("H:|-p-[cancel(<=buttonW)]-p-[add(<=buttonW)]-p-|")
		
		autolayout("V:|-t-[category]-p-[title]-p-[author]-p-[url]-p-[review]-p-[cancel]-p-|")
		autolayout("V:|-t-[category]-p-[title]-p-[author]-p-[url]-p-[review]-p-[add]-p-|")
		autolayout("V:|-t-[level]")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension AddTableVC: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}

extension AddTableVC: UIPickerViewDataSource {
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return 4
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		switch row {
		case 0:
			return "Beginner"
		case 1:
			return "Intermediate"
		case 2:
			return "Senior"
		case 3:
			return "Pro"
		default:
			return ""
		}
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch row {
		case 0:
			levelButton.setTitle("Beginner", forState: .Normal)
		case 1:
			levelButton.setTitle("Intermediate", forState: .Normal)
		case 2:
			levelButton.setTitle("Senior", forState: .Normal)
		case 3:
			levelButton.setTitle("Pro", forState: .Normal)
		default:
			levelButton.setTitle("", forState: .Normal)
		}
		levelButton.sizeToFit()
	}
}
