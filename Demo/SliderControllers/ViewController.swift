//
//  ViewController.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let sliderView = YTTTabSliderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "测试"
        
        
        view.addSubview(sliderView)
        sliderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.cyan
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.orange
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.blue
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.brown
        
        let vc5 = UIViewController()
        vc5.view.backgroundColor = UIColor.yellow
        
        let vc6 = UIViewController()
        vc6.view.backgroundColor = UIColor.orange
        
        let vc7 = UIViewController()
        vc7.view.backgroundColor = UIColor.cyan
        
        let vc8 = UIViewController()
        vc8.view.backgroundColor = UIColor.orange
        
        sliderView.addSubviews([("测试1",vc1.view),("测试2",vc2.view),("测试3",vc3.view),("测试4",vc4.view),("测试5",vc5.view),("测试6",vc6.view),("测试7",vc7.view),("测试8",vc8.view)], isSelected: 3)
        

    
          
        
    
    }
    
    @objc func test() {
    }

   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

