//
//  ViewController.swift
//  CompositionalLayout-Practice
//
//  Created by 김윤서 on 2022/01/19.
//

import UIKit

class ViewController: UIViewController {

    enum SectionLayoutKind: Int, CaseIterable {
        case list, grid5, grid3
        var columnCount: Int {
            switch self {
            case .grid3:
                return 3

            case .grid5:
                return 5

            case .list:
                return 1
            }
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Distinct Sections"
        configureHierarchy()
        configureDataSource()
    }
}

extension ViewController {
    /// - Tag: PerSection
    func createLayout() -> UICollectionViewLayout { // UICollectionViewLayout를 반환하는 함수
        let layout = UICollectionViewCompositionalLayout {
            (
                sectionIndex: Int,
                layoutEnvironment: NSCollectionLayoutEnvironment
            ) -> NSCollectionLayoutSection? in

            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil } // 위에 SectionLayoutKind에서 생성한 레이아웃 종류 (list, grid5, grid3)
            let columns = sectionLayoutKind.columnCount // 레이아웃 종류에 따른 열 개수
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), // 실제 항목 너비를 자동으로 계산하여 요청된 열 수에 맞도록 하므로 widthDimension는 무시됨
                heightDimension: .fractionalHeight(1.0) // fractional: 현재 자신이 속한 컨테이너의 크기를 기반으로 비율로써 자신의 크기를 정함. 0.0~1.0 사이의 CGFloat값을 넣을  수 있음
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize) // item size를 넣어 item layout 생성
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2) // item의 contentInsets 지정

            let groupHeight = columns == 1 ? // 각 그룹의 높이
            NSCollectionLayoutDimension.absolute(44) : // 열의 개수가 하나인 경우 44로 지정
            NSCollectionLayoutDimension.fractionalWidth(0.2) // 열의 개수가 하나가 아닌 경우 너비*0.2
            
            let groupSize = NSCollectionLayoutSize( // 각 그룹의 사이즈
                widthDimension: .fractionalWidth(1.0), // 너비는 속해있는 컨테이너 * 1.0 만큼
                heightDimension: groupHeight // 위에서 정해준 groupHeight
            )
            
            let group = NSCollectionLayoutGroup.horizontal( // 그룹위 속성을 horizontal로 지정 (수평 배치 왼->오)
                layoutSize: groupSize, // 각 그룹의 사이즈 넣어주기
                subitem: item, // 각 그룹의 item layout 넣어주기
                count: columns // 각 섹션의 열 개수만큼
            )

            let section = NSCollectionLayoutSection(group: group) // 각 그룹이 포함된 섹션 생성
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20) // 섹션의 contentInsets 설정
            return section
        }
        return layout
    }
}

extension ViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        // list Cell 생성
        let listCellRegistration = UICollectionView.CellRegistration<ListCell, Int> {
            (
                cell, indexPath, identifier
            ) in
            
            cell.label.text = "\(identifier)"
        }
        
        // text Cell 생성
        let textCellRegistration = UICollectionView.CellRegistration<TextCell, Int> {
            (
                cell, indexPath, identifier
            ) in
            
            cell.label.text = "\(identifier)"
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = SectionLayoutKind(rawValue: indexPath.section)! == .grid5 ? 8 : 0
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        // dataSource Section 별 셀 레이아웃 , item 넣어주기
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Int>(collectionView: collectionView) {
            (
                collectionView: UICollectionView,
                indexPath: IndexPath,
                identifier: Int
            ) -> UICollectionViewCell? in
            
            return SectionLayoutKind(rawValue: indexPath.section)! == .list ?
            collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: identifier) : // list 레이아웃이면 리스트 셀
            collectionView.dequeueConfiguredReusableCell(using: textCellRegistration, for: indexPath, item: identifier) // 아니면 텍스트 셀
        }

        let itemsPerSection = 10 // 섹션당 10개
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>() // snapshot 생성
        
        SectionLayoutKind.allCases.forEach {
            snapshot.appendSections([$0])
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false) // dataSource에 데이터 적용 apply
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
