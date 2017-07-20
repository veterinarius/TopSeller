//
//  BookCell.swift
//  TopSeller
//
//  Created by Stephan Wegmann on 23.06.17.
//  Copyright © 2017 Stephan Wegmann. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            thisWeekNumberTextField.text = book?.thisWeekNumber
            lastWeekNumberTextField.text = book?.lastWeekNumber
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            publisherLabel.text = book?.publisher
            priceTextField.text = book?.price
            
            guard let coverImageUrl = book?.coverImageUrl else { return }
            guard let url = URL(string: coverImageUrl) else { return }
            
            coverImageView.image = nil
            
            URLSession.shared.dataTask(with: url) { (data, response, error)
                in
                
                if let err = error {
                    print("Laden des Cover-Bildes fehlgeschlagen!", err)
                    return
                }
                
                guard let imageData = data else { return }
                let image = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.coverImageView.image = image

                }
                
            }.resume()
        }
    }
    
    private let thisWeekNumberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    private let lastWeekNumberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField

    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "steve_jobs")
        return imageView
        
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
        
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
        
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label

    }()
    
    private let priceTextField: UITextField = {
        let priceTextField = UITextField()
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.textColor = .red
          return priceTextField
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(thisWeekNumberTextField)
        thisWeekNumberTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        thisWeekNumberTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        thisWeekNumberTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -43).isActive = true
        thisWeekNumberTextField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(lastWeekNumberTextField)
        lastWeekNumberTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        lastWeekNumberTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        lastWeekNumberTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        lastWeekNumberTextField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: thisWeekNumberTextField.rightAnchor, constant: 4).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(publisherLabel)
        publisherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        publisherLabel.leftAnchor.constraint(equalTo: authorLabel.rightAnchor, constant: 8).isActive = true
        publisherLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(priceTextField)
        priceTextField.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4).isActive = true
        priceTextField.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        priceTextField.widthAnchor.constraint(equalToConstant: 65).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
