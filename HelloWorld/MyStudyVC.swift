//
//  MyStudyVC.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright © 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit
import NorthLayout

class MyStudyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let width = UIScreen.mainScreen().bounds.width
	let height = UIScreen.mainScreen().bounds.height
	
	lazy var tableview = UITableView()
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Featured, tag: 1)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.view.backgroundColor = UIColor.whiteColor()
		
		
		// setup tableview
		let frame = CGRectMake(0, 20, width, height)
		tableview = UITableView(frame: frame)
		
		// tableview delegate
		tableview.delegate = self
		tableview.dataSource = self
		
		// let tableview height variable
		tableview.estimatedRowHeight = 120
		tableview.rowHeight = UITableViewAutomaticDimension
		
		// register class for the identifier
		tableview.registerClass(MyStudyTableCell.self, forCellReuseIdentifier: "studyCell")
		
		self.view.addSubview(tableview)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension MyStudyVC: UITableViewDataSource {
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell: MyStudyTableCell = tableview.dequeueReusableCellWithIdentifier("studyCell", forIndexPath: indexPath) as! MyStudyTableCell
		
		cell.initViews()
		
		let data = studyData[indexPath.row]
		cell.categoryLabel.text = data.category
		cell.levelLabel.text = data.level?.toString()
		cell.titleLabel.text = data.title
		cell.authorLabel.text = data.author
		cell.urlLabel.text = data.url?.absoluteString
		cell.reviewLabel.text = data.review
		
		cell.setupAutoLayout()
		
		cell.layoutIfNeeded()
		return cell
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return studyData.count
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let row = indexPath.row
		let data = studyData[row]
		let detailVC = BookDetailVC()
		
		detailVC.initViews()
		
		detailVC.categoryLabel.text = data.category
		detailVC.levelLabel.text = data.level?.toString()
		detailVC.titleLabel.text = data.title
		detailVC.authorLabel.text = data.author
		detailVC.urlLabel.text = data.url?.absoluteString
		detailVC.reviewLabel.text = data.review
		
		detailVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
		detailVC.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
		self.presentViewController(detailVC, animated: true, completion: nil)

	}
}