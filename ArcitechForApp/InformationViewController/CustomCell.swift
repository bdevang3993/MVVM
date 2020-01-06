//
//  CustomCell.swift
//  MVVMDemo
//
//  Created by Devang.bhavsar on 10/19/18.
//  Copyright © 2018 Collabera. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var sourceVIew: Source!
    {
        didSet {
            self.textLabel?.text = sourceVIew.name
            self.detailTextLabel?.text = sourceVIew.description 
    }
    
//    var sourceModelView: SourceViewModel! {
//        didSet {
//            self.textLabel?.text = sourceModelView.nameWithId
//            self.detailTextLabel?.text = sourceModelView.description
//        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
        required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
