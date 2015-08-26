//
//  PlaceHolderTextView.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright (c) 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit

class PlaceHolderTextView: UITextView {
	
	lazy var placeHolderLabel: UILabel = UILabel()
	let placeHolderColor: UIColor = UIColor.grayColor()
	var placeHolder: String?
	
	override init(frame: CGRect, textContainer: NSTextContainer?){
		super.init(frame: frame, textContainer: textContainer)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged:", name: UITextViewTextDidChangeNotification, object: nil)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	func setupText(text: String) {
		super.text = text
		self.textChanged(nil)
	}
	
	override internal func drawRect(rect: CGRect) {
		if let str = placeHolder {
			if(count(str.utf16) > 0) {
				placeHolderLabel.frame           = CGRectMake(0, 8, self.bounds.size.width, 0)
				placeHolderLabel.lineBreakMode   = NSLineBreakMode.ByWordWrapping
				placeHolderLabel.numberOfLines   = 0
				placeHolderLabel.font            = self.font
				placeHolderLabel.backgroundColor = UIColor.clearColor()
				placeHolderLabel.textColor       = placeHolderColor
				placeHolderLabel.alpha           = 0
				placeHolderLabel.tag             = 999
				
				placeHolderLabel.text = self.placeHolder
				placeHolderLabel.sizeToFit()
				placeHolderLabel.layer.position.x = self.bounds.size.width / 2
				self.addSubview(placeHolderLabel)
			}
			
			self.sendSubviewToBack(placeHolderLabel)
			
			if(count(text.utf16) == 0 && count(str.utf16) > 0){
				self.viewWithTag(999)?.alpha = 1
			}
		}
		super.drawRect(rect)
	}
	
	internal func textChanged(notification:NSNotification?) -> (Void) {
		if let str = placeHolder {
			if count(str.utf16) == 0 {
				return
			}
		}
		else {
			return
		}
		if count(self.text.utf16) == 0 {
			self.viewWithTag(999)?.alpha = 1
		}
		else {
			self.viewWithTag(999)?.alpha = 0
		}
	}
}