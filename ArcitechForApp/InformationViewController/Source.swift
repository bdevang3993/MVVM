//
//  Source.swift
//  MVVMDemo
//
//  Created by Devang.bhavsar on 10/19/18.
//  Copyright © 2018 Collabera. All rights reserved.
//

import Foundation

struct JSonData: Decodable {
    var status:String?
     var source: [Source]
    enum CodingKeys : String, CodingKey {
        case status
        case source = "sources"
    }
}
struct Source: Decodable {
    var id:String?
    var  name:String?
    var description: String?
    var  url: String?
    var category:String?
    var language:String?
    var country: String?
}

