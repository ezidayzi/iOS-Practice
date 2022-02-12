//
//  FeedCollectionViewCell.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/13.
//

import UIKit
import Then
import SnapKit

final class FeedCollectionViewCell: UICollectionViewCell {
    
    private let tagLabel = UILabel()
    private let headingLabel = UILabel()
    private let subheadingLabel = UILabel()
    private let imageView = UIImageView()
    
    
    private let hStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagLabel.text = nil
        headingLabel.text = nil
        subheadingLabel.text = nil
        imageView.backgroundColor = nil
    }
    
    
    public func updateData(with list: List) {
        tagLabel.text = list.manufacture
        headingLabel.text = list.prdlstNm
        subheadingLabel.text = list.rawmtrl
        
        let url = URL(string: list.imgurl1)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data!)
            }
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)

        layoutAttributes.frame = frame
        return layoutAttributes
    }
}

extension FeedCollectionViewCell {
    private func render() {
        contentView.addSubview(hStackView)
        contentView.addSubview(imageView)

        hStackView.addArrangedSubview(tagLabel)
        hStackView.addArrangedSubview(headingLabel)
        hStackView.addArrangedSubview(subheadingLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(5)
            $0.height.equalTo(250)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
        }

        hStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().priority(.high)
        }
    }
    
    private func configureUI() {
        tagLabel.do {
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textColor = .systemBlue
        }
        
        headingLabel.do {
            $0.font = .boldSystemFont(ofSize: 18)
            $0.numberOfLines = 0
        }
        
        subheadingLabel.do {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .lightGray
            $0.numberOfLines = 0
        }
        
        hStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillProportionally
            $0.spacing = 5
        }
    }
}
