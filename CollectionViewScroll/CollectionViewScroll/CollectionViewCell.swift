//
//  CollectionViewCell.swift
//  CollectionViewScroll
//
//  Created by 김윤서 on 2021/05/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    public static let identifier = "CollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
