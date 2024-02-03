//
//  Product.swift
//  My_Spar
//
//  Created by Yaroslav Zagumennikov on 03.02.2024.
//

import Foundation

struct Product {
    let name : String
    let image : String
    let country : String
    let description : String
    let characteristics : [MainFeatures]
    let reviews : [Review]
}

struct MainFeatures : Identifiable {
    var id : String {
        self.key
    }
    let key : String
    let value : String
}
