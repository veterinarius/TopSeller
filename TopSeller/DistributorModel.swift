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
    var apps: [Distributor]?
    var type: String?
    
    static func sampleDistributorCategories() -> [DistributorCategory] {
    
    let spiegelCategory = DistributorCategory()
    spiegelCategory.name = "Spiegel"
    
    var apps = [Distributor]()
    
    // logic
    let spiegelApp = Distributor()
    spiegelApp.name = "Literatur Spiegel"
    spiegelApp.imageName = "Spiegel-1-1-1"
    spiegelApp.category = ""
    apps.append(spiegelApp)
        
    spiegelCategory.apps = apps
        
        let spiegel1App = Distributor()
//        spiegel1App.name = ""
        spiegel1App.imageName = "Spiegel-1-1-2"
//        spiegel1App.category = ""
        apps.append(spiegel1App)
        
        let spiegel2App = Distributor()
//        spiegel2App.name = ""
        spiegel2App.imageName = "Spiegel-2-1-1"
//        spiegel2App.category = ""
        apps.append(spiegel2App)
        
        spiegelCategory.apps = apps
        
        let spiegel3App = Distributor()
//        spiegel3App.name = ""
        spiegel3App.imageName = "Spiegel-2-1-2"
//        spiegel3App.category = ""
        apps.append(spiegel3App)
        
        spiegelCategory.apps = apps
        
        let spiegel4App = Distributor()
//        spiegel4App.name = ""
        spiegel4App.imageName = "spiegel-online-3-1-1"
//        spiegel4App.category = ""
        apps.append(spiegel4App)
        
        spiegelCategory.apps = apps
        
        let spiegel5App = Distributor()
//        spiegel5App.name = ""
        spiegel5App.imageName = "spiegel-online-3-1-2"
//        spiegel5App.category = ""
        apps.append(spiegel5App)
        
        spiegelCategory.apps = apps

        
    let amazonCategory = DistributorCategory()
    amazonCategory.name = "amazon"
        
    var amazonApps = [Distributor]()
        
    let amazonApp = Distributor()
    amazonApp.name = "amazon.de"
//    amazonApp.category = ""
    amazonApp.imageName = "amazon-1"
    amazonApps.append(amazonApp)
        
    amazonCategory.apps = amazonApps
        
    let focusCategory = DistributorCategory()
    focusCategory.name = "Focus"
        
    var focusApps = [Distributor]()
        
    let focusApp = Distributor()
    focusApp.name = "Focus"
    focusApp.imageName = "focus-6-1-1"
//    focusApp.category = "Bücher-Bestseller"
    focusApps.append(focusApp)
        
    focusCategory.apps = focusApps
        
        let focus1App = Distributor()
        focus1App.name = "Thalia"
        focus1App.imageName = "focus-6-1-2"
//        focus1App.category = "Belletristik/Sachbuch"
        focusApps.append(focus1App)
        
        focusCategory.apps = focusApps
        
        let thaliaCategory = DistributorCategory()
        thaliaCategory.name = "Thalia"
        
        var thaliaApps = [Distributor]()
        
        let thaliaApp = Distributor()
        thaliaApp.name = "Thalia"
        thaliaApp.imageName = "thalia-4-1-1"
//        thaliaApp.category = ""
        thaliaApps.append(thaliaApp)
        
        thaliaCategory.apps = thaliaApps
        
        let thalia1App = Distributor()
        thalia1App.name = "Thalia"
        thalia1App.imageName = "thalia-4-1-2"
//        thalia1App.category = ""
        thaliaApps.append(thalia1App)
        
        thaliaCategory.apps = thaliaApps
        
    return [spiegelCategory, amazonCategory, focusCategory, thaliaCategory]
        
    }
}

class Distributor: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    
}
