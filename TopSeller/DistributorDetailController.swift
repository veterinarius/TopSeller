//
//  DistributorDetailController.swift
//  TopSeller
//
//  Created by Stephan Wegmann on 06.08.17.
//  Copyright © 2017 Stephan Wegmann. All rights reserved.
//

import UIKit

class DistributorDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id {
                let urlString = "http://www.statsallday.com/appstore/appdetail?id=\(id)"
                
                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    do {
                        
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                        
                        let appDetail = App()
                        appDetail.setValuesForKeys(json as! [String: AnyObject])
                        
                        self.app = appDetail
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.collectionView?.reloadData()
                        })
                        
                    } catch let err {
                        print(err)
                    }
                    
                    }).resume()


            }
         }
    }
    
    private let headerId = "headerId"
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(DistributorDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        
        cell.app = app
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView,  viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DistributorDetailHeader
        header.app = app
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
}

class DistributorDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)

            }
            
            nameLabel.text = app?.name
            
            if let price = app?.price?.stringValue {
                buyButton.setTitle("€\(price)", for: .normal)
            }
         }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
        
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["amazon", "thalia"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
        
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: .normal)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
        
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()

    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|-14-[v0(100)]", views: imageView)
        
        addConstraintsWithFormat("V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat("V:[v0(34)]-8-|", views: segmentedControl)
        
       addConstraintsWithFormat("H:[v0(60)]-14-|", views: buyButton)
       addConstraintsWithFormat("V:[v0(32)]-56-|", views: buyButton)

       addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
       addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
          addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }

}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
