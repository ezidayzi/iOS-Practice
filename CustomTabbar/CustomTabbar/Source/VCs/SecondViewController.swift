//
//  SecondViewController.swift
//  CustomTabbar
//
//  Created by 김윤서 on 2021/05/22.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "Second View Controller"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(200)
        }
    }

}
