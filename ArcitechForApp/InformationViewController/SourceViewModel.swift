//
//  SourceViewModel.swift
//  MVVMDemo
//
//  Created by Devang.bhavsar on 10/19/18.
//  Copyright © 2018 Collabera. All rights reserved.
//

import Foundation
class SourceViewModel: NSObject {
    var arrSoureceData:[Source] = []
    var arrSectionName = ["Section1","Section2","Section3"]
    func numberofSectionInTable() -> Int {
        return arrSectionName.count
    }
    func sectionTitleData(index:Int) -> String {
        return arrSectionName[index]
    }
    
}
