//
//  MenuBar.swift
//  CustomTabbar
//
//  Created by 김윤서 on 2021/05/21.
//

import UIKit
import SnapKit

class MenuBar: UIView{
    
    var VC : ViewController?
    
    private let newButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEW", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let bestButton : UIButton = {
        let button = UIButton()
        button.setTitle("BEST", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let myButton : UIButton = {
        let button = UIButton()
        button.setTitle("My", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let hStack : UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 0
        hStack.distribution = .fillEqually
        return hStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMenuBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMenuBar(){
        backgroundColor = .purple
        
        addSubview(hStack)
        hStack.addArrangedSubview(newButton)
        hStack.addArrangedSubview(bestButton)
        hStack.addArrangedSubview(myButton)
        
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
    }
}
