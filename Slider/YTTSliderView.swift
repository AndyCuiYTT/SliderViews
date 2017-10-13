//
//  YTTSliderView.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/13.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

class YTTSliderView: UIView {

    public private(set) var childItems: [(String, UIViewController)] = []
    fileprivate var headerView: YTTSegmentedControl = YTTSegmentedControl(frame: CGRect.zero, items: [])
    private var contentView: UIView = UIView()
    fileprivate let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        
        headerView.delegate = self
        addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(1)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.height.equalToSuperview()
        }
    }
    
    func ytt_addChildControllers(_ childItems: [(String, UIViewController)]) {
        
        guard (self.superview != nil) else {
            assertionFailure("SlideScrollView 没有 superview")
            return
        }
        guard childItems.count >= 1 else {
            assertionFailure("SlideScrollView 至少需要一个 childView")
            return
        }
        
        headerView.titles = childItems.map({ (item) -> String in
            item.0
        })
        
        contentView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.childItems = childItems
        for i in 0 ..< childItems.count {
            contentView.addSubview(childItems[i].1.view)
            childItems[i].1.view.snp.makeConstraints({ (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(yttScreenWidth * CGFloat(i))
                make.width.equalTo(yttScreenWidth)
            })
            
            if i == childItems.count - 1 {
                childItems[i].1.view.snp.makeConstraints({ (make) in
                    make.right.equalToSuperview()
                })
            }
        }
        headerView.isSelectedIndex = 0
    }
    
}

extension YTTSliderView: YTTSegmentedDelegate {
    func yttSegmentedControl(_ segment: YTTSegmentedControl, didSeletItemAt index: Int) {
        scrollView.setContentOffset(CGPoint(x: yttScreenWidth * CGFloat(index), y: 0), animated: true)
    }
}

extension YTTSliderView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        headerView.isSelectedIndex = Int(scrollView.contentOffset.x / yttScreenWidth)
    }
}


