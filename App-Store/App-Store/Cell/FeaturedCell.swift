//
//  FeaturedCell.swift
//  App-Store
//
//  Created by 김윤서 on 2022/02/10.
//

import UIKit

import Then
import SnapKit


protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableView { }

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(
        forIndexPath indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func register<T>(
        cell: T.Type,
        forCellWithReuseIdentifier reuseIdentifier: String = T.reuseIdentifier
    ) where T: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

final class FeaturedCell: UICollectionViewCell {
    
    private let tagLabel = UILabel()
    private let headingLabel = UILabel()
    private let subheadingLabel = UILabel()
    private let imageView = UIView()
    
    
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
    
    
    public func updateData(with app: App) {
        tagLabel.text = app.tagline
        headingLabel.text = app.name
        subheadingLabel.text = app.subheading
        imageView.backgroundColor = .random
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}

extension FeaturedCell {
    private func render() {
        contentView.addSubview(hStackView)
        contentView.addSubview(imageView)

        hStackView.addArrangedSubview(tagLabel)
        hStackView.addArrangedSubview(headingLabel)
        hStackView.addArrangedSubview(subheadingLabel)

        hStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().priority(.high)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(5).priority(.high)
            $0.height.equalTo(250).priority(.medium)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.low)
        }
    }
    
    private func configureUI() {
        tagLabel.do {
            $0.font = .boldSystemFont(ofSize: 10)
            $0.textColor = .systemBlue
        }
        
        headingLabel.do {
            $0.font = .systemFont(ofSize: 16)
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

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
