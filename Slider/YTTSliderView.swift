//
//  YTTSliderView.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/13.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

public protocol YTTSliderViewDelegate: class {
    
    
    /// 当前显示视图位置
    ///
    /// - Parameters:
    ///   - sliderView: 当前视图
    ///   - index: 选中位置
    func yttSliderView(_ sliderView: YTTSliderView, didShowPageAt index: Int);
    
}


public class YTTSliderView: UIView {

    public private(set) var isSelectedIndex: Int = -1
    public private(set) var childViews: [UIView] = []
    public weak var delegate: YTTSliderViewDelegate?
    private var contentView: UIView = UIView()
    fileprivate let scrollView = UIScrollView()
    private var sliderViewWidth: CGFloat = yttScreenWidth
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        if frame != CGRect.zero {
            sliderViewWidth = frame.width
        }
        setupSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.height.equalToSuperview()
        }
    }
    
    public func setSliderWidth(_ width: CGFloat) {
        self.sliderViewWidth = width
    }
    
    
    /// 添加子视图
    ///
    /// - Parameters:
    ///   - childViews: 子视图数组
    ///   - index: 初始选中位置
    public func addChildViews(_ childViews: [UIView], isSelected index: Int = 0) {
        
        guard childViews.count >= 1 else {
            assertionFailure("SlideScrollView 至少需要一个 childView")
            return
        }
        
       
        contentView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.childViews = childViews
        for i in 0 ..< childViews.count {
            contentView.addSubview(childViews[i])
            childViews[i].snp.makeConstraints({ (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(sliderViewWidth * CGFloat(i))
                make.width.equalTo(sliderViewWidth)
            })
            
            if i == childViews.count - 1 {
                childViews[i].snp.makeConstraints({ (make) in
                    make.right.equalToSuperview()
                })
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) { [weak self] in
            self?.isSelectedIndex = index
            self?.scrollView.setContentOffset(CGPoint(x: (self?.sliderViewWidth)! * CGFloat(index), y: 0), animated: true)
        }
    }
    
    public func setSelectedIndex(_ index: Int) {
        
        guard index >= 0, index < childViews.count else {
            assertionFailure("index 必须在 0 ~ childViews.count\(childViews.count)之间")
            return
        }
        isSelectedIndex = index
        self.scrollView.setContentOffset(CGPoint(x: self.sliderViewWidth * CGFloat(index), y: 0), animated: true)
    }
    
}


extension YTTSliderView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.yttSliderView(self, didShowPageAt: Int(scrollView.contentOffset.x / sliderViewWidth))
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.yttSliderView(self, didShowPageAt: Int(scrollView.contentOffset.x / sliderViewWidth))
    }
}


