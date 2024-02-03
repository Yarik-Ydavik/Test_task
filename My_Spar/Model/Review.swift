//
//  Review.swift
//  My_Spar
//
//  Created by Yaroslav Zagumennikov on 03.02.2024.
//

import Foundation

struct Review : Identifiable{
    var id : String {
        self.name
    }
    let name : String
    let date : Date
    let review : Int
    let reviewDescription : String
}
