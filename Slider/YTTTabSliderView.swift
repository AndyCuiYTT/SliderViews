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
    
    private var headerView: YTTSegmentedControl = YTTSegmentedControl()
    public private(set) var childItems: [(String, UIView)] = []
    private var contentView: YTTSliderView = YTTSliderView()
    private var tabSliderViewWidth: CGFloat = yttScreenWidth
    
    public override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        if frame != CGRect.zero {
            tabSliderViewWidth = frame.width
            headerView.setSegmentedWidth(tabSliderViewWidth)
            contentView.setSliderWidth(tabSliderViewWidth)
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
    
    func addSubviews(_ item: [(title: String, contentView: UIView)], isSelected index: Int = 0) {
        
        headerView.addTitleItems(item.map({ (item) -> String in
            return item.title
        }), isSelected: index)
        
        contentView.addChildViews(item.map({ (item) -> UIView in
            return item.contentView
        }), isSelected: index)
        
       
        
    }
    

}

extension YTTTabSliderView: YTTSegmentedDelegate {
    public func yttSegmentedControl(_ segment: YTTSegmentedControl, didSeletItemAt index: Int) {
        contentView.setSelectedIndex(index)
    }
    
    
}

extension YTTTabSliderView: YTTSliderViewDelegate {
    public func yttSliderView(_ sliderView: YTTSliderView, didShowPageAt index: Int) {
        headerView.isSelectedIndex = index
    }
    
    
}
