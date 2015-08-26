//
//  BookDetailVC.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright (c) 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit
import NorthLayout

class BookDetailVC: UIViewController {
	lazy var bookImageView = UIImageView()
	lazy var categoryLabel = UILabel()
	lazy var levelLabel = UILabel()
	lazy var titleLabel = UILabel()
	lazy var authorLabel = UILabel()
	lazy var urlLabel = UILabel()
	lazy var reviewLabel = UILabel()
	
	lazy var navBar = UIView()
	
	func initViews() {
		// image
		if let image = UIImage(named: "dummy") {
			bookImageView.image = image
		}
		else {
			bookImageView.backgroundColor = UIColor.grayColor()
		}
		
		// labels
		setupLabelFont(titleLabel, fontsize: 20, fontcolor: UIColor.blackColor())
		setupLabelFont(authorLabel, fontsize: 16, fontcolor: UIColor.blackColor())
		setupLabelFont(urlLabel, fontsize: 16, fontcolor: UIColor.blueColor())
		setupLabelFont(reviewLabel, fontsize: 16, fontcolor: UIColor.blackColor())
		
	}
	
	func setupLabelFont(label: UILabel, fontsize: CGFloat, fontcolor: UIColor) {
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.ByWordWrapping
		label.font = UIFont.systemFontOfSize(fontsize)
		label.textColor = fontcolor
	}
	
	func setupNavBar() {
		navBar.backgroundColor = UIColor.blueColor()
		
		let backButton = UIButton()
		setupBackButton(backButton)
		
		categoryLabel.backgroundColor = UIColor.whiteColor()
		categoryLabel.font = UIFont(name: "Helvetica", size: 18)
		levelLabel.backgroundColor = UIColor.whiteColor()
		levelLabel.font = UIFont(name: "Helvetica", size: 16)
		
		setupNavBarAutoLayout(backButton)
	}
	
	func setupBackButton(button: UIButton) {
		button.setTitle("Back", forState: .Normal)
		button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		button.addTarget(self, action: "backToMyStudyVC:", forControlEvents: .TouchUpInside)
	}
	
	func setupNavBarAutoLayout(button: UIButton) {
		let p: CGFloat = 8
		let v: CGFloat = 2
//		let buttonW: CGFloat = navBar.
		let autolayout = navBar.northLayoutFormat(["p": p, "v": v], [
			"back": button,
			"category": categoryLabel,
			"level": levelLabel,
		])
		
		autolayout("H:|-p-[back][category]-p-[level]-p-|")
		autolayout("V:|-v-[back]-v-|")
		autolayout("V:|-v-[category]-v-|")
		autolayout("V:[level]-v-|")
		categoryLabel.center.x = navBar.center.x
	}
	
	func backToMyStudyVC(sender: UIButton) {
		self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
		self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func setupAutoLayout() {
		let p: CGFloat = 10
		let t: CGFloat = 20
		let imageWidth: CGFloat = 128
		let imageHeight = imageWidth * 1.5
		let autolayout = view.northLayoutFormat(["p": p, "t": t, "imageWidth": imageWidth, "imageHeight": imageHeight], [
			"navBar": navBar,
			"bookImage": bookImageView,
			"title": titleLabel,
			"author": authorLabel,
			"url": urlLabel,
			"review": reviewLabel,
			])

		autolayout("H:|[navBar]|")
		autolayout("H:|-p-[bookImage(==imageWidth)]-p-[title]-p-|")
		autolayout("H:|-p-[bookImage(==imageWidth)]-p-[author]-p-|")
		autolayout("H:|-p-[url]-p-|")
		autolayout("H:|-p-[review]-p-|")
		
		autolayout("V:|-t-[navBar]")
		autolayout("V:|-t-[navBar]-p-[bookImage(==imageHeight)]-p-[url]-p-[review]")
		autolayout("V:|-t-[navBar]-p-[title]-p-[author]")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
		setupAutoLayout()
		// button
		setupNavBar()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}