//
//  MediumCollectionViewCell.swift
//  App-Store
//
//  Created by 김윤서 on 2022/02/11.
//

import Foundation
import UIKit

final class MediumCollectionViewCell: UICollectionViewCell {
    
    private let leftBoxView = UIView()
    private let numberLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateData(with app: App) {
        numberLabel.text = "\(app.id)"
        titleLabel.text = app.name
    }
}

extension MediumCollectionViewCell {
    private func render() {
        contentView.addSubview(leftBoxView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        leftBoxView.addSubview(numberLabel)
        
        leftBoxView.snp.makeConstraints {
            $0.width.height.equalTo(45)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(5)
        }
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leftBoxView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        leftBoxView.do {
            $0.backgroundColor = .random
            $0.layer.cornerRadius = 9
            $0.clipsToBounds = true
        }
        
        numberLabel.do {
            $0.font = .boldSystemFont(ofSize: 25)
            $0.textColor = .white
        }
        
        titleLabel.do {
            $0.font = .boldSystemFont(ofSize: 25)
        }
    }
}
