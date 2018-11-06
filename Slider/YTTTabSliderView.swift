//
//  YTTTabSliderView.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/23.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

public protocol YTTTabSliderViewDelegate: class {
    
    func yttTabSliderView(_ sliderView: YTTTabSliderView, didShowPageAt index: Int);
}




public class YTTTabSliderView: UIView {
    
    private var headerView: YTTSegmentedView = YTTSegmentedView()
    public private(set) var childItems: [(String, UIView)] = []
    private var contentView: YTTSliderView = YTTSliderView()
    private var tabSliderViewWidth: CGFloat = UIScreen.main.bounds.width
    
    public override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        if frame != CGRect.zero {
            tabSliderViewWidth = frame.width
        }
        
        setupSubViews()
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        contentView.delegate = self
        headerView.delegate = self
        self.addSubview(headerView)
        self.addSubview(contentView)
        let div = UIView()
        div.backgroundColor = UIColor.gray
        self.addSubview(div)
        
        headerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        div.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(div.snp.bottom)
        }
    }
    
    
    /// 添加子视图
    ///
    /// - Parameters:
    ///   - items: 要显示视图列表, item 为元组, title 为对应的 header 字段, contentView 与 title 对应的显示视图
    ///   - index: 初始选中位置
    public func addSubviews(_ items: [(title: String, contentView: UIView)], isSelected index: Int = 0) {
        if items.count < 0 {
            assertionFailure("请确保至少有一个子视图")
        }
        childItems = items
        headerView.addTitleItems(items.map({ (item) -> String in
            return item.title
        }), isSelected: index)
        
        contentView.addChildViews(items.map({ (item) -> UIView in
            return item.contentView
        }), isSelected: index)
    }
    

}

extension YTTTabSliderView: YTTSegmentedViewDelegate {
    public func segmentedView(_ segmentView: YTTSegmentedView, didSelectItemAt index: Int) {
        contentView.showPage(index)
    }
}

extension YTTTabSliderView: YTTSliderViewDelegate {
    public func sliderView(_ sliderView: YTTSliderView, didShowPageAt index: Int) {
        headerView.setSelectedIndex(index)
    }
}
