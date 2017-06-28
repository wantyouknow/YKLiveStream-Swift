//
//  ViewController.swift
//  YKLiveStream
//
//  Created by 裴塔塔 on 5/29/16.
//  Copyright © 2017 peitata. All rights reserved.
//  播放界面

import UIKit

class ViewController: UIViewController {

//    传过来的值
    var live : YKCell!
    
    @IBOutlet weak var backclick: UIButton!
    
    @IBOutlet weak var liwu: UIButton!
    
    @IBOutlet weak var love: UIButton!
    
    
    @IBOutlet weak var imgclick: UIImageView!
    
    @IBAction func clickback(_ sender: UIButton) {
    }
    
    @IBAction func clickgift(_ sender: UIButton) {
    }
    
    @IBAction func clicklove(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        dump(live)
        setbg()
        
    }

//    设置背景图
    func setbg()  {
        let imgurl = URL(string: live.portrait)
        imgclick.kf.setImage(with: imgurl)
        
//        虚化背景图
        let blureffect = UIBlurEffect(style: .light)
        
//        创建一个容器
        let effectview = UIVisualEffectView(effect: blureffect)
        effectview.frame = imgclick.bounds
        
        imgclick.addSubview(effectview)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

