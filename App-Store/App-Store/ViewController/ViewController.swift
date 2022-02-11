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
        collectionView.register(cell: FeaturedCollectionViewCell.self)
        collectionView.register(cell: SmallCollectionViewCell.self)
        collectionView.register(cell: MediumCollectionViewCell.self)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
      
        return collectionView
    }()
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch self.sections[indexPath.section].type {
            case "featured":
                let cell: FeaturedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateData(with: itemIdentifier)
                return cell
            case "smallTable":
                let cell: SmallCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateData(with: itemIdentifier)
                return cell
            case "mediumTable":
                let cell: MediumCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateData(with: itemIdentifier)
                return cell
                
            default:
                let cell: FeaturedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateData(with: itemIdentifier)
                return cell
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? SectionHeaderView else {
                return nil
            }

            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.title.isEmpty { return nil }

            sectionHeader.titleLabel.text = section.title
            sectionHeader.subtitleLabel.text = section.subtitle
            return sectionHeader
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
                return self.createSmallSection(using: section)
            case "mediumTable":
                return self.createMediumSection(using: section)
            case "featured":
                return self.createFeaturedSection(using: section)
            default:
                return nil
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 15
        layout.configuration = config
        
        return layout
    }
    
    func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(300)
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
            heightDimension: .estimated(1)
        )

        let layoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: layoutGroupSize,
            subitems: [layoutItem]
        )

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

        return layoutSection
    }
    
    func createSmallSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.2)
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
            heightDimension: .absolute(200)
        )

        let layoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: layoutGroupSize,
            subitems: [layoutItem]
        )

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

        return layoutSection

    }
    
    func createMediumSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.33)
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
            heightDimension: .absolute(150)
        )

        let layoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: layoutGroupSize,
            subitems: [layoutItem]
        )

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

        return layoutSection

    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.93),
            heightDimension: .absolute(50)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return sectionHeader
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


final class SectionHeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    private let hStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
}

extension SectionHeaderView {
    private func configure() {
        addSubview(hStackView)
        hStackView.addArrangedSubview(titleLabel)
        hStackView.addArrangedSubview(subtitleLabel)
        
        hStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        hStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.distribution = .fillProportionally
            $0.alignment = .top
        }
        
        titleLabel.do {
            $0.font = .boldSystemFont(ofSize: 18)
        }
        
        subtitleLabel.do {
            $0.font = .systemFont(ofSize: 15)
        }
    }
}
