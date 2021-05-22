//
//  BaseVC.swift
//  CustomTabbar
//
//  Created by 김윤서 on 2021/05/21.
//

import UIKit

class BaseVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.dismissKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.barTintColor = .systemPink
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
