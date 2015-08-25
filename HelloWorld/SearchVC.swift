//
//  SearchVC.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright © 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
import UIKit

class SearchVC: UIViewController {
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 2)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.view.backgroundColor = UIColor.magentaColor()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}