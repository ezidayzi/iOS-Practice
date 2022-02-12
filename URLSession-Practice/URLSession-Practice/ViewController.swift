//
//  ViewController.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/06.
//

import UIKit

import SnapKit
import Then
import RxSwift

class ViewController: UIViewController {
    enum Section {
        case main
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(cell: FeedCollectionViewCell.self)
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, List>! = nil
    
    var data: Product? {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = DefaultProductRepository()
        Task {
            data = try await repository.getProducts()
            dump(data)
        }
        
        
         render()
         createDataSource()
         loadData()
    }
}

extension ViewController {
    func render() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(300)
        )
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(300)
        )
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: layoutGroupSize,
            subitems: [layoutItem]
        )
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = .init(top: 0, leading: 32, bottom: 0, trailing: 32)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ViewController {
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, List>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell: FeedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.updateData(with: itemIdentifier)
            return cell
        }
    }
    
    func loadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, List>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data?.list ?? [])
        dataSource?.apply(snapshot)
    }
}
