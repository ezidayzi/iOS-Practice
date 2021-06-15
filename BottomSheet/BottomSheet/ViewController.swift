//
//  ViewController.swift
//  BottomSheet
//
//  Created by 김윤서 on 2021/06/09.
//

import UIKit
import PanModal

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

extension ViewController: PanModalPresentable {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(200)
    }

    var anchorModalToLongForm: Bool {
        return false
    }
}
