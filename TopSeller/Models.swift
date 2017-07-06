//
//  Models.swift
//  TopSeller
//
//  Created by Stephan Wegmann on 21.06.17.
//  Copyright © 2017 Stephan Wegmann. All rights reserved.
//

import UIKit
  
class Book {
    let number: String
    let lastWeekNumber: String
    let title: String
    let author: String
    let publisher: String
    let price: String
    let pages: [ContentPage]
    let coverImageUrl: String

    init(dictionary: [String: Any]) {
        self.number = dictionary["number"] as? String ?? ""
        self.lastWeekNumber = dictionary["lastWeekNumber"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.publisher = dictionary["publisher"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
        
        var bookPages = [ContentPage]()
        
        if let pagesDictionaries = dictionary["pages"] as? [[String: Any]] {
            
            for pageDictionary in pagesDictionaries {
                
                if let pageText = pageDictionary["text"] as? String {
                    let page = ContentPage(number: 1, text: pageText)
                    bookPages.append(page)
                }
            }
        }
        pages = bookPages
    }
}

class ContentPage {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
