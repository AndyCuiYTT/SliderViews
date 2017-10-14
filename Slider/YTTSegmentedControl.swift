//
//  YTTSegmentedControl.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit
import SnapKit

let yttScreenWidth = UIScreen.main.bounds.width


public protocol YTTSegmentedDelegate: class {
    
    func yttSegmentedControl(_ segment: YTTSegmentedControl, didSeletItemAt index: Int);
    
    func yttSegmentedControl(_ segment: YTTSegmentedControl, itemAt index: Int) -> UIButton;
    
}

extension YTTSegmentedDelegate {
    public func yttSegmentedControl(_ segment: YTTSegmentedControl, itemAt index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.setTitleColor(UIColor.blue, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }
}


public class YTTSegmentedControl: UIView {
    
    public var isSelectedIndex: Int {
        get {
            return currentIndex
        }
        
        set {
            if currentIndex != newValue && newValue >= 0 && newValue < titles.count {
                if currentButton != nil {
                    currentButton?.isSelected = false
                }
                if let btn = mainView.viewWithTag(newValue + 101) as? UIButton  {
                    btn.isSelected = true
                    currentButton = btn
                    currentIndex = newValue
                    delegate?.yttSegmentedControl(self, didSeletItemAt: newValue)
                    // item 居中
                    let offset_x = CGFloat(Int(btn.center.x / yttScreenWidth)) * yttScreenWidth
                    let off_x = btn.center.x - offset_x - yttScreenWidth / 2
                    var offsetX = offset_x + off_x
                    if btn.center.x < yttScreenWidth / 2  {
                        offsetX = 0
                    }
                    if offsetX + yttScreenWidth > scrollView.contentSize.width {
                        offsetX = offsetX - (offsetX + yttScreenWidth - scrollView.contentSize.width)
                    }
                    scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                }
            }
        }
    }
    
    public var titles: [String] = [] {
        didSet {
            addItems(items: titles)
        }
    }
    
    
    private var currentButton: UIButton?
    private var currentIndex: Int = -1
    private var yttItemMinWidth: CGFloat = 50
    private var mainView: UIView = UIView()
    private let scrollView = UIScrollView()
    weak var delegate: YTTSegmentedDelegate?
    
    init(frame: CGRect, items: [String]) {
        super.init(frame: frame)
        self.titles = items
        self.setupSubViews()
    }
    
    func setupSubViews() {
        
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.white
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        scrollView.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.height.equalToSuperview()
        }
    }
    
    private func addItems(items: [String]) {
        
        guard superview != nil else {
            assertionFailure("SegmentedControl 没有 superView")
            return
        }
        
        guard items.count >= 1 else {
            assertionFailure("SegmentedControl 必须有一个或多个 item")
            return
        }
        
        mainView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        if items.count > 0 {
            let width = yttScreenWidth / CGFloat(4 > items.count ? items.count : 4)
            yttItemMinWidth = yttItemMinWidth > width ? yttItemMinWidth : width
        }
        
        for i in 0 ..< items.count {
            
            if let button = delegate?.yttSegmentedControl(self, itemAt: i) {
                button.setTitle(items[i], for: .normal)
                button.tag = 101 + i
                button.addTarget(self, action: #selector(itemClick(_:)), for: .touchUpInside)
                mainView.addSubview(button)
                button.snp.makeConstraints({ (make) in
                    make.left.equalTo(yttItemMinWidth * CGFloat(i))
                    make.height.centerY.equalToSuperview()
                    make.width.greaterThanOrEqualTo(yttItemMinWidth)
                })
                if i == items.count - 1 {
                    button.snp.makeConstraints({ (make) in
                        make.right.equalToSuperview()
                    })
                }
            }
        }
    }
    
    @objc func itemClick(_ sender: UIButton) {
        let index = sender.tag - 101
        isSelectedIndex = index
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
}
