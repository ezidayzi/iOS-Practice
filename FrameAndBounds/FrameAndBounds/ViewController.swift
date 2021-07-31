//
//  ViewController.swift
//  FrameAndBounds
//
//  Created by 김윤서 on 2021/07/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        let view1 = UIView()
        view1.backgroundColor = .purple
        view1.frame = CGRect(x: 50, y: 100, width: 300, height: 500)
        view.addSubview(view1)
        
        
        let view2 = UIView()
        view2.backgroundColor = .white
        view2.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view1.addSubview(view2)
        
        print("frame")
        dump(view2.frame)
        print("bounds")
        dump(view2.bounds)
    }


}

