//
//  ViewController.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var btn1: UIButton = {
        let view = UIButton.init(type: UIButton.ButtonType.custom)
        view.setTitle("选尺寸", for: UIControl.State.normal)
        view.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    @objc func buttonAction(sender: UIButton) {
        self.present(SelectSizeView(), animated: false, completion: nil)
    }
    
    lazy var btn2: UIButton = {
        let view = UIButton.init(type: UIButton.ButtonType.custom)
        view.setTitle("地址管理", for: UIControl.State.normal)
        view.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addTarget(self, action: #selector(buttonAction2(sender:)), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    @objc func buttonAction2(sender: UIButton) {
        self.present(AddressViewController(), animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let widthScreen = UIScreen.main.bounds.size.width
        
        let imageDataList = [
                            "https://pic.bonwebuy.com/sources/images/goods/MB/295334/295334_00.jpg",
                            "https://pic.bonwebuy.com/sources/images/goods/MB/295334/295334_30.jpg",
                            "https://pic.bonwebuy.com/sources/images/goods/MB/295334/295334_31.jpg"]
        
        
        let bannerView = BannerView()
        bannerView.frame = CGRect.init(x: 0, y: 50, width: widthScreen, height: widthScreen)
        bannerView.setImages(images: imageDataList, type: BannerView.ImageType.URL) { (number) in
            
        }
        self.view.addSubview(bannerView)
        
        btn1.frame = CGRect.init(x: 50, y: widthScreen+100, width: widthScreen, height: 20)
        self.view.addSubview(btn1)
        btn2.frame = CGRect.init(x: 50, y: widthScreen+150, width: widthScreen, height: 20)
        self.view.addSubview(btn2)
        
    }


}

