//
//  PullToRefresh.swift
//  MarsWeatherAPI
//
//  Created by Darren Leith on 25/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit

class PullToRefresh: UIView {
	
	private unowned var scrollView: UIScrollView //unowned as dont want a strong reference to it
	private let sceneHeight: CGFloat = 120
	var percentagePulledDown: CGFloat = 0
	var activityIndicator: UIActivityIndicatorView!
	
	required init?(coder aDecoder: NSCoder) {
		scrollView = UIScrollView()
		assert(false, "use init(frame:scrollView:")
		super.init(coder: aDecoder)
	}
	
	//refresh view needs a reference back to the scrollview
	
	init(frame: CGRect, scrollView: UIScrollView) {
		self.scrollView = scrollView
		super.init(frame: frame)
		updateBackgroundColor()
		
		//activityIndicator
		activityIndicator = UIActivityIndicatorView(frame: CGRect(x: CGRectGetMidX(self.bounds) - 25, y: CGRectGetHeight(self.bounds) - 60, width: 50, height: 50))
		activityIndicator.activityIndicatorViewStyle = .WhiteLarge
		addSubview(activityIndicator)
	}
	
	func updateBackgroundColor() {
		let value = percentagePulledDown * 0.7 + 0.2 //light gray all the way up to a dark gray
		backgroundColor = UIColor(red: value, green: value, blue: value, alpha: 1.0)
	}
	
}

extension PullToRefresh: UIScrollViewDelegate {
	func scrollViewDidScroll(scrollView: UIScrollView) {
		let refreshViewVisibleHeight = max(0, -(scrollView.contentOffset.y + scrollView.contentInset.top)) //only want positive values from 0 up
		percentagePulledDown = min(1, refreshViewVisibleHeight / sceneHeight) //cap the value at 100%
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
		updateBackgroundColor()
	}
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		activityIndicator.stopAnimating()
		activityIndicator.alpha = 0.0
	}
	
}