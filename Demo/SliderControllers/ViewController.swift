//
//  ViewController.swift
//  SliderControllers
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let sliderView = YTTSliderView()
        view.addSubview(sliderView)
        sliderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.cyan
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.orange
        
        sliderView.ytt_addChildControllers([("测试1",vc1),("测试2",vc2)])
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let VC = YTTSliderController()
        VC.yttHeaderItems = ["dd","rrr"]
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.cyan
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.orange
        
        VC.yttChildControllers = [vc1, vc2]
        
        
        self.present(VC, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

