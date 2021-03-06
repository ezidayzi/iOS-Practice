//
//  ViewController.swift
//  CustomTabbar2
//
//  Created by 김윤서 on 2021/06/15.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController{
    
    private let menuList = ["가","나","다","라","마"]
    
    private let customTabbar = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: 150, height: 60)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.collectionViewLayout = layout
    }
    
    private let mainScrollView = UIScrollView().then{
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    
    private let indicator = UIView().then {
        $0.backgroundColor = .cyan
    }
    
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setMainScrollView()
        setUI()

    }
    
    func setDelegate(){
        customTabbar.delegate = self
        customTabbar.dataSource = self
        customTabbar.register(MenuItemCVC.self, forCellWithReuseIdentifier: MenuItemCVC.identifier)
        
        mainScrollView.delegate = self
        
    }
    
    func setUI(){
        view.addSubview(customTabbar)
        view.addSubview(indicator)
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(contentView)
        
        customTabbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        indicator.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(customTabbar.snp.bottom)
            $0.width.equalTo(150)
            $0.height.equalTo(4)
        }

        mainScrollView.snp.makeConstraints {
            $0.top.equalTo(customTabbar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width * 5)
            $0.height.equalToSuperview()
        }
    }
    
    func setMainScrollView(){
        let vc = FirstViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: mainScrollView.frame.height)
        addChild(vc)
        mainScrollView.addSubview(vc.view)
        
        let vc2 = SecondViewController()
        vc2.view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: mainScrollView.frame.height)
        addChild(vc2)
        mainScrollView.addSubview(vc2.view)

        let vc3 = ThirdViewController()
        vc3.view.frame = CGRect(x: UIScreen.main.bounds.width*2, y: 0, width: UIScreen.main.bounds.width, height: mainScrollView.frame.height)
        addChild(vc3)
        mainScrollView.addSubview(vc3.view)

        let vc4 = FourthViewController()
        vc4.view.frame = CGRect(x: UIScreen.main.bounds.width*3, y: 0, width: UIScreen.main.bounds.width, height: mainScrollView.frame.height)
        addChild(vc4)
        mainScrollView.addSubview(vc4.view)

        let vc5 = FifthViewController()
        vc5.view.frame = CGRect(x: UIScreen.main.bounds.width*4, y: 0, width: UIScreen.main.bounds.width, height: mainScrollView.frame.height)
        addChild(vc5)
        mainScrollView.addSubview(vc5.view)
    }
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = customTabbar.dequeueReusableCell(withReuseIdentifier: MenuItemCVC.identifier,
                                                                        for: indexPath)
                                                                        as? MenuItemCVC
                                                                        else {return MenuItemCVC() }
        cell.setData(title: menuList[indexPath.row])
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newOffset = CGPoint(x: Int(UIScreen.main.bounds.width) * indexPath.row, y: 0)
        mainScrollView.setContentOffset(newOffset, animated: true)

        indicator.snp.updateConstraints {
            $0.leading.equalToSuperview().offset((mainScrollView.contentOffset.x/5))
        }
        
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath,at: .right, animated: true)
        collectionView.isPagingEnabled = true
//        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
  
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView == mainScrollView{
            customTabbar.setContentOffset(CGPoint(x:mainScrollView.contentOffset.x/5, y: 0), animated: true)
            print(mainScrollView.contentOffset.x/5)
//            indicator.snp.updateConstraints {
//                $0.leading.equalToSuperview().offset((mainScrollView.contentOffset.x/5))
//            }
        } else{
            indicator.snp.updateConstraints {
                $0.leading.equalToSuperview().offset((customTabbar.contentOffset.x))
            }
        }
    }
}

