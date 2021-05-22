//
//  FirstViewController.swift
//  CustomTabbar
//
//  Created by 김윤서 on 2021/05/22.
//

import UIKit

class FirstViewController: UIViewController {
    let label : UILabel = {
        let label = UILabel()
        label.text = "First View Controller"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(200)
        }
    }
    

}
