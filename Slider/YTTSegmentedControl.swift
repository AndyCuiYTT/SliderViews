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


@objc public protocol YTTSegmentedDelegate: class {
    
    /// item 选中回调
    ///
    /// - Parameters:
    ///   - segment: 当前视图
    ///   - index: 选中位置
    func yttSegmentedControl(_ segment: YTTSegmentedControl, didSeletItemAt index: Int);
    
    /// 自定义 item 样式回调
    ///
    /// - Parameters:
    ///   - segment: 当前视图
    ///   - index: 选中位置
    @objc optional func yttSegmentedControl(_ segment: YTTSegmentedControl, itemAt index: Int) -> UIButton;
    
}


public class YTTSegmentedControl: UIView {
    
    public var isSelectedIndex: Int {
        get {
            return currentIndex
        }
        
        set {
            if currentIndex != newValue && newValue >= 0 && newValue < titleItems.count {
                if currentButton != nil {
                    currentButton?.isSelected = false
                }
                if let btn = mainView.viewWithTag(newValue + 101) as? UIButton  {
                    btn.isSelected = true
                    currentButton = btn
                    currentIndex = newValue
                    // item 居中
                    let offset_x = CGFloat(Int(btn.center.x / segmentedWidth)) * segmentedWidth
                    let off_x = btn.center.x - offset_x - segmentedWidth / 2
                    var offsetX = offset_x + off_x
                    if btn.center.x < segmentedWidth / 2  {
                        offsetX = 0
                    }
                    if offsetX + segmentedWidth > scrollView.contentSize.width {
                        offsetX = offsetX - (offsetX + segmentedWidth - scrollView.contentSize.width)
                    }
                    scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                }
            }
        }
    }
    
    public private(set) var titleItems: [String] = []
    
    
    private var currentButton: UIButton?
    private var currentIndex: Int = -1
    private var yttItemMinWidth: CGFloat = 50
    private var mainView: UIView = UIView()
    private let scrollView = UIScrollView()
    weak var delegate: YTTSegmentedDelegate?
    private var segmentedWidth: CGFloat = yttScreenWidth
    
    public override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        if frame != CGRect.zero {
            segmentedWidth = frame.width
        }
        self.setupSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setSegmentedWidth(_ width: CGFloat) {
        self.segmentedWidth = width
    }
    
    
    /// 为 SegmentedControl 添加 title
    ///
    /// - Parameters:
    ///   - items: title 数组
    ///   - index: 初始选中位置
    public func addTitleItems(_ items: [String], isSelected index: Int = 0) {
        
        
        guard items.count >= 1 else {
            assertionFailure("SegmentedControl 必须有一个或多个 item")
            return
        }
        
        self.titleItems = items
        
        mainView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        if items.count > 0 {
            let width = segmentedWidth / CGFloat(4 > items.count ? items.count : 4)
            yttItemMinWidth = yttItemMinWidth > width ? yttItemMinWidth : width
        }
        
        for i in 0 ..< items.count {
            
            if let button = delegate?.yttSegmentedControl?(self, itemAt: i) {
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
            }else {
                let button = UIButton(type: .custom)
                button.setTitleColor(UIColor.darkText, for: .normal)
                button.setTitleColor(UIColor.blue, for: .selected)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) { [weak self] in
            self?.isSelectedIndex = index
        }
    }
    
    @objc func itemClick(_ sender: UIButton) {
        let index = sender.tag - 101
        isSelectedIndex = index
        delegate?.yttSegmentedControl(self, didSeletItemAt: isSelectedIndex)

    }
    
    
}
