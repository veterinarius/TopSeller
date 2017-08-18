//
//  StartPageController.swift
//  TopSeller
//
//  Created by Stephan Wegmann on 10.07.17.
//  Copyright © 2017 Stephan Wegmann. All rights reserved.
//

import UIKit


class StartPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    
    var newApps: TopNew?
    var appCategories: [DistributorCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DistributorCategory.fetchTopNew { (newApps) in
            self.newApps = newApps
            self.appCategories = newApps.appCategories
            self.collectionView?.reloadData()
            
            self.appCategories = DistributorCategory.sampleDistributorCategories()
        
        }
        setupNavBarButton()
        
        navigationItem.title = "Top-Seller Bücher"
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(StartPageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    func showAppDetailForApp(app: App) {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = DistributorDetailController(collectionViewLayout: layout)
        appDetailController.app = app
        navigationController?.pushViewController(appDetailController, animated: true)
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item >= 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            
            cell.appCategory = appCategories?[indexPath.item]
            cell.featuredAppsController = self
            
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StartPageCell
        
        cell.appCategory = appCategories?[indexPath.item]
        cell.featuredAppsController = self
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item >= 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        return CGSize(width: view.frame.width, height: 190)
    }
    
    func setupNavBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector (handleMenuPress))

}
    func handleMenuPress() {
        print("Menu pressed.")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        header.appCategory = newApps?.bannerCategory
        
        return header
    }
}

class Header: StartPageCell {
    
    let cellId = "bannerCellId"
    
    override func setupViews() {
        let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Neueinsteiger der Woche"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
        
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        
        appCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(appCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-19-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appCollectionView]))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 52)
        
    }
    
    private class BannerCell: AppCell {
        
        fileprivate override func setupViews() {
            
            
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
            
        }
    }
}

class LargeCategoryCell: StartPageCell {
    
    fileprivate let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        appCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: "largeAppCellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 237, height: frame.height - 32)
        
    }
}
    private class LargeAppCell: AppCell {
        fileprivate override func setupViews() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-25-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            
        }
    }

