//
//  NorthLayout.swift
//  NorthLayout
//
//  Created by BAN Jun on 5/9/15.
//  Copyright (c) 2015 banjun. All rights reserved.
//

#if os(iOS)
    import UIKit
    public typealias UXView = UIView
    #else
    import AppKit
    public typealias UXView = NSView
#endif


public extension UXView {
    public func northLayoutFormat(metrics: [String:CGFloat], _ views: [String:UXView]) -> String -> Void {
        return self.northLayoutFormat(metrics, views, options: nil) // `options: []` for Xcode 7 beta 2
    }
    
    public func northLayoutFormat(metrics: [String:CGFloat], _ views: [String:UXView], options: NSLayoutFormatOptions) -> String -> Void {
        for v in views.values {
            #if os(iOS)
                let isAlreadySubview = v.isDescendantOfView(self)
                #else
                let isAlreadySubview = v.isDescendantOf(self)
            #endif
            if !isAlreadySubview {
				#if os(iOS)
					v.setTranslatesAutoresizingMaskIntoConstraints(false)
					#else
					v.translatesAutoresizingMaskIntoConstraints = false
				#endif
//				this is for Xcode 7 beta 2
//                v.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(v)
            }
        }
        return { (format: String) in
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views))
        }
    }
}
