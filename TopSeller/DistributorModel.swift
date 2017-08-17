//
//  DistributorModel.swift
//  TopSeller
//
//  Created by Stephan Wegmann on 11.07.17.
//  Copyright © 2017 Stephan Wegmann. All rights reserved.
//

import UIKit

class TopNew: NSObject {
    
    var bannerCategory: DistributorCategory?
    var appCategories: [DistributorCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [DistributorCategory]()
            
            for dict in value as! [[String: AnyObject]] {
                let appCategory = DistributorCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
        
            }
            
        } else if key == "bannerCategory" {
            bannerCategory = DistributorCategory()
            bannerCategory?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    } 
}

class DistributorCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
                }
            } else {
                super.setValue(value, forKey: key)
            }
        }
    
        static func fetchTopNew(completionHandler: @escaping (TopNew) -> ()) {
            
            let urlString = "https://articyoulate.com/images/Bestseller/TopNeueinsteiger.json"
            
            URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                do {
                    let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    let newApps = TopNew()
                    
                    newApps.setValuesForKeys(json as! [String: AnyObject])
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        completionHandler(newApps)
                    })
                } catch let err {
                    print(err)
                }
            }) .resume()
        }

    static func sampleDistributorCategories() -> [DistributorCategory] {
    
    let spiegelCategory = DistributorCategory()
    spiegelCategory.name = "Spiegel"
    
    var apps = [App]()
    
    // logic
    let spiegelApp = App()
//    spiegelApp.name = "Literatur Spiegel"
    spiegelApp.imageName = "Spiegel-1-1-1"
    spiegelApp.category = ""
    apps.append(spiegelApp)
        
    spiegelCategory.apps = apps
        
        let spiegel1App = App()
//        spiegel1App.name = ""
        spiegel1App.imageName = "Spiegel-1-1-2"
//        spiegel1App.category = ""
        apps.append(spiegel1App)
        
        let spiegel2App = App()
//        spiegel2App.name = ""
        spiegel2App.imageName = "Spiegel-2-1-1"
//        spiegel2App.category = ""
        apps.append(spiegel2App)
        
        spiegelCategory.apps = apps
        
        let spiegel3App = App()
//        spiegel3App.name = ""
        spiegel3App.imageName = "Spiegel-2-1-2"
//        spiegel3App.category = ""
        apps.append(spiegel3App)
        
        spiegelCategory.apps = apps
        
        let spiegel4App = App()
//        spiegel4App.name = ""
        spiegel4App.imageName = "spiegel-online-3-1-1"
//        spiegel4App.category = ""
        apps.append(spiegel4App)
        
        spiegelCategory.apps = apps
        
        let spiegel5App = App()
//        spiegel5App.name = ""
        spiegel5App.imageName = "spiegel-online-3-1-2"
//        spiegel5App.category = ""
        apps.append(spiegel5App)
        
        spiegelCategory.apps = apps

        
    let amazonCategory = DistributorCategory()
    amazonCategory.name = "amazon"
        
    var amazonApps = [App]()
        
    let amazonApp = App()
//    amazonApp.name = "amazon.de"
//    amazonApp.category = ""
    amazonApp.imageName = "amazon-1"
    amazonApps.append(amazonApp)
        
    amazonCategory.apps = amazonApps
        
    let focusCategory = DistributorCategory()
    focusCategory.name = "Focus"
        
    var focusApps = [App]()
        
    let focusApp = App()
//    focusApp.name = "Focus"
    focusApp.imageName = "focus-6-1-1"
//    focusApp.category = "Bücher-Bestseller"
    focusApps.append(focusApp)
        
    focusCategory.apps = focusApps
        
        let focus1App = App()
//        focus1App.name = "Thalia"
        focus1App.imageName = "focus-6-1-2"
//        focus1App.category = "Belletristik/Sachbuch"
        focusApps.append(focus1App)
        
        focusCategory.apps = focusApps
        
        let thaliaCategory = DistributorCategory()
        thaliaCategory.name = "Thalia"
        
        var thaliaApps = [App]()
        
        let thaliaApp = App()
//        thaliaApp.name = "Thalia"
        thaliaApp.imageName = "thalia-4-1-1"
//        thaliaApp.category = ""
        thaliaApps.append(thaliaApp)
        
        thaliaCategory.apps = thaliaApps
        
        let thalia1App = App()
//        thalia1App.name = "Thalia"
        thalia1App.imageName = "thalia-4-1-2"
//        thalia1App.category = ""
        thaliaApps.append(thalia1App)
        
        thaliaCategory.apps = thaliaApps
        
    return [spiegelCategory, amazonCategory, focusCategory, thaliaCategory]
        
    }
}

class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
    var screenshots: [String]?
    var desc: String?
    var appInformation: AnyObject?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            self.desc = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
    }

}
