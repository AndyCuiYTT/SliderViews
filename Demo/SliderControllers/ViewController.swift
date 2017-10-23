//
//  ViewController.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "SliderViews"

        
        let segmented = YTTSegmentedControl()
        segmented.delegate = self // 必须设置 实现 YTTSegmentedDelegate
        segmented.addTitleItems(["SliderView1","SliderView2","SliderView3"], isSelected: 1)
        segmented.backgroundColor = UIColor.cyan
        self.view.addSubview(segmented)
        segmented.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(segmented.snp.bottom).offset(10)
        }
    
        
//
//        let sliderView = YTTSliderView()
//        let view1 = UIView()
//        view1.backgroundColor = UIColor.cyan
//        let view2 = UIView()
//        view2.backgroundColor = UIColor.orange
//        let view3 = UIView()
//        view3.backgroundColor = UIColor.blue
//        sliderView.addChildViews([view1, view2, view3], isSelected: 1)
//        self.view.addSubview(sliderView)
//        sliderView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        
        
        
        
//        let tabSliderView = YTTTabSliderView()
//        tabSliderView.addSubviews([("SliderView1",view1),("SliderView2",view2),("SliderView3",view3)])
//        view.addSubview(tabSliderView)
//        tabSliderView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        
    
    }
    
  
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: YTTSegmentedDelegate {
    public func yttSegmentedControl(_ segment: YTTSegmentedControl, didSeletItemAt index: Int) {
        label.text = "当前点击 index 为:\(index)"
    }
    
    
}

