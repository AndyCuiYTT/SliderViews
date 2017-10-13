//
//  YTTSliderController.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

class YTTSliderController: UIViewController {

    var yttChildControllers: [UIViewController] {
        get {
            return self.childViewControllers
        }
        set {
            ytt_addChildControllers(newValue)
        }
    }
    
    var yttHeaderItems: [String] {
        get {
            return headerView.titles
        }
        set {
            headerView.titles = newValue
            headerView.isSelectedIndex = 0
        }
    }
    
    var navigationItemTitle: String {
        get {
            return self.navigationItem.title ?? ""
        }
        set {
            self.navigationItem.title = newValue
        }
    }
    
    
    
    fileprivate var headerView: YTTSegmentedControl = YTTSegmentedControl(frame: CGRect.zero, items: [])
    private var contentView: UIView = UIView()
    fileprivate let scrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubViews()
        self.ytt_addChildControllers([])
    }
    
    func setupSubViews() {
        
        headerView.delegate = self
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(1)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.height.equalToSuperview()
        }
    }
    
    func ytt_addChildControllers(_ childControllers: [UIViewController]) {
        
        for i in 0 ..< childControllers.count {
            self.addChildViewController(childControllers[i])
            contentView.addSubview(childControllers[i].view)
            childControllers[i].view.snp.makeConstraints({ (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(yttScreenWidth * CGFloat(i))
                make.width.equalTo(yttScreenWidth)
            })
            
            if i == childControllers.count - 1 {
                childControllers[i].view.snp.makeConstraints({ (make) in
                    make.right.equalToSuperview()
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension YTTSliderController: YTTSegmentedDelegate {
    func yttSegmentedControl(_ segment: YTTSegmentedControl, didSeletItemAt index: Int) {
        scrollView.setContentOffset(CGPoint(x: yttScreenWidth * CGFloat(index), y: 0), animated: true)
    }
}

extension YTTSliderController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        headerView.isSelectedIndex = Int(scrollView.contentOffset.x / yttScreenWidth)
    }
}
