//
//  SearchVC.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright © 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
	let width = UIScreen.mainScreen().bounds.width
	let height = UIScreen.mainScreen().bounds.height
	
	lazy var searchField = UITextField()
	lazy var searchButton = UIButton()
	lazy var tableview = UITableView(frame: CGRectZero)
	
	var filterdData: [StudyData]?
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 2)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func initViews() {
		// searchField
		initSearchField()
		
		// button
		initSearchButton()
		
		// table
		initTableview()
	}
	
	func initTableview() {
		tableview.delegate = self
		tableview.dataSource = self
		tableview.registerClass(MyStudyTableCell.self, forCellReuseIdentifier: "studyCell")
		
		tableview.estimatedRowHeight = 120
		tableview.rowHeight = UITableViewAutomaticDimension
	}
	
	func initSearchButton() {
		searchButton.setTitle("Search", forState: .Normal)
		searchButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		searchButton.addTarget(self, action: "search:", forControlEvents: .TouchUpInside)
	}
	
	func initSearchField() {
		searchField.font = UIFont(name: "Helvetica", size: 20)
		searchField.placeholder = "input category"
		searchField.borderStyle = UITextBorderStyle.RoundedRect
		searchField.returnKeyType = UIReturnKeyType.Search
		searchField.clearButtonMode = UITextFieldViewMode.WhileEditing
		searchField.delegate = self
	}
	
	func search(sender: UIButton) {
		let query = searchField.text
		let filterQuery = {
			(data: StudyData) -> Bool in
			data.category == query
		}
		if !(query == "") {
			filterdData = studyData.filter(filterQuery)
		}
		
		tableview.reloadData()
	}
	
	func setupAutoLayout() {
		let p: CGFloat = 8
		let t: CGFloat = 50
		let autolayout = view.northLayoutFormat(["p": p, "t": t], [
			"search": searchField,
			"button": searchButton,
			"table": tableview,
			])
		autolayout("H:|-p-[search]-p-[button]-p-|")
		autolayout("H:|-p-[table]-p-|")
		autolayout("V:|-t-[search]-p-[table]-p-|")
		autolayout("V:|-t-[button]-p-[table]-p-|")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.view.backgroundColor = UIColor.whiteColor()
		initViews()
		setupAutoLayout()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension  SearchVC: UITableViewDataSource {
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: MyStudyTableCell = tableview.dequeueReusableCellWithIdentifier("studyCell", forIndexPath: indexPath) as! MyStudyTableCell
		
		cell.initViews()
		
		if let fData = filterdData {
			let data = fData[indexPath.row]
			cell.categoryLabel.text = data.category
			cell.levelLabel.text = data.level?.toString()
			cell.titleLabel.text = data.title
			cell.authorLabel.text = data.author
			cell.urlLabel.text = data.url?.absoluteString
			cell.reviewLabel.text = data.review
			
			cell.setupAutoLayout()
			
			cell.layoutIfNeeded()
		}
		return cell
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let fData = filterdData {
			return fData.count
		}
		else {
			return 0
		}
	}
}

extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}