//
//  ViewController.swift
//  App-Store
//
//  Created by 김윤서 on 2022/01/23.
//

import UIKit

class ViewController: UIViewController {

    enum SectionLayoutKind: Int, CaseIterable {
        case gridLarge, gridMedium, gridSmall
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension ViewController {
    func configureHierarchy() {
        
    }
}

extension ViewController {
//    func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout {
//            (
//                sectionIndex: Int,
//                layoutEnvironment: NSCollectionLayoutEnvironment
//            ) -> NSCollectionLayoutSection? in
//            
//        }
//    }
}
