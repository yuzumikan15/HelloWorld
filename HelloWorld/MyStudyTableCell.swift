//
//  MyStudyTableCell.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright (c) 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit
import NorthLayout

class MyStudyTableCell: UITableViewCell {
	lazy var bookImageView = UIImageView()
	lazy var categoryLabel = UILabel()
	lazy var levelLabel = UILabel()
	lazy var titleLabel = UILabel()
	lazy var authorLabel = UILabel()
	lazy var urlLabel = UILabel()
	lazy var reviewLabel = UILabel()
	
	func initViews() {
		// imageView
		if let image = UIImage(named: "dummy") {
			bookImageView.image = image
		}
		else {
			bookImageView.backgroundColor = UIColor.cyanColor()
		}
		
		// labels
		setupLabelFont(categoryLabel, fontsize: 16, fontcolor: UIColor.blackColor())
		setupLabelFont(levelLabel, fontsize: 12, fontcolor: UIColor.grayColor())
		setupLabelFont(titleLabel, fontsize: 20, fontcolor: UIColor.blackColor())
		setupLabelFont(authorLabel, fontsize: 16, fontcolor: UIColor.blackColor())
		setupLabelFont(urlLabel, fontsize: 12, fontcolor: UIColor.blueColor())
		setupLabelFont(reviewLabel, fontsize: 16, fontcolor: UIColor.blackColor())
		
	}
	
	func setupLabelFont(label: UILabel, fontsize: CGFloat, fontcolor: UIColor) {
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.ByWordWrapping
		label.font = UIFont.systemFontOfSize(fontsize)
		label.textColor = fontcolor
	}
	
	func setupAutoLayout() {
		let p: CGFloat = 8
		let imageWidth: CGFloat = 128
		let imageHeight = imageWidth * 1.5
		let autolayout = self.northLayoutFormat(["p": p, "imageWidth": imageWidth, "imageHeight": imageHeight], [
			"bookImage": bookImageView,
			"category": categoryLabel,
			"level": levelLabel,
			"title": titleLabel,
			"author": authorLabel,
			"url": urlLabel,
			"review": reviewLabel,
			])
		autolayout("H:|-p-[bookImage(==imageWidth)]-p-[category]")
		autolayout("[level]-p-|")
		autolayout("H:|-p-[bookImage(==imageWidth)]-p-[title]-p-|")
		autolayout("H:|-p-[bookImage(==imageWidth)]-p-[author]-p-|")
		autolayout("H:|-p-[bookImage(==imageWidth)]-p-[url]-p-|")
		autolayout("H:|-p-[review]-p-|")
		autolayout("V:|-p-[bookImage(==imageHeight)]-p-[review]-p-|")
		autolayout("V:|-p-[level]")
		autolayout("V:|-p-[category]-p-[title]-p-[author]-p-[url]-p-[review]-p-|")
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
}
