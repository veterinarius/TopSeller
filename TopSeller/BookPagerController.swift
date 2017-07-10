//
//  BookPagerController.swift
//  TopSeller
//
//  Created by Stephan Wegmann on 26.06.17.
//  Copyright © 2017 Stephan Wegmann. All rights reserved.
//

import UIKit

class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        navigationItem.title = self.book?.title
        let textAttributes = [NSForegroundColorAttributeName: UIColor(red: 0.592, green: 0.004, blue: 0.031, alpha: 1.00)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
        
        collectionView?.isPagingEnabled = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "return") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector (handleCloseBook))
        
    }
    
    func handleCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionViewLayout.invalidateLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 44 - 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? PageCell
        
        let page = book?.pages[indexPath.item]
        pageCell?.textLabel.text = page?.text
        
        switch indexPath.item {
        case 0:
            pageCell?.backgroundColor = .gray
//            navigationItem.title = "Buch"
        case 1:
            pageCell?.backgroundColor = .green
//            navigationItem.title = "selbst gelesen"
        case 2:
            pageCell?.backgroundColor = .blue
//            navigationItem.title = "Eure Meinung"
        default:
            pageCell?.backgroundColor = .red
//            navigationItem.title = "Buch Laden"
        }
                
        return pageCell!
     }
}
