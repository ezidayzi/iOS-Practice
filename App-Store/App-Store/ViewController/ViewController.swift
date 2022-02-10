//
//  ViewController.swift
//  App-Store
//
//  Created by 김윤서 on 2022/01/23.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    enum SectionLayoutKind: Int, CaseIterable {
        case featured, gridMedium, gridSmall
    }
    
    let sections = MockParser.load(type: [Section].self, fileName: "appstore")!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, App>! = nil
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(cell: FeaturedCell.self)
        
        return collectionView
    }()
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render()
        createDataSource()
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
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
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch self.sections[indexPath.section].type {
            case "featured":
                let cell: FeaturedCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateData(with: itemIdentifier)
                return cell
            default:
                let cell: FeaturedCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateData(with: itemIdentifier)
                return cell
            }
           
        }
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (
                sectionIndex: Int,
                layoutEnvironment: NSCollectionLayoutEnvironment
            ) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            switch section.type {
            case "smallTable":
                return self.createFeaturedSection(using: section)
            case "mediumTable":
                return self.createFeaturedSection(using: section)
            case "featured":
                return self.createFeaturedSection(using: section)
            default:
                return nil
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 5,
            bottom: 0,
            trailing: 5
        )

        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.93),
            heightDimension: .fractionalHeight(1)
        )

        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutGroupSize,
            subitem: layoutItem,
            count: 1
        )

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

        return layoutSection
    }
    
    func loadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
}
