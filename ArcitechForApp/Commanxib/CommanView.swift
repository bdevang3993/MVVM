//
//  CommanView.swift
//  XibDemo
//
//  Created by devang bhavsar on 28/12/19.
//  Copyright © 2019 devang bhavsar. All rights reserved.
//

import UIKit

class CommanView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnHeader: UIButton!
    
    public override init(frame: CGRect) {
             super .init(frame: frame)

         }
         
         required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
         }
      
     func instanceFromNib() -> CommanView {
      
     return UINib(nibName: "CommanView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! CommanView
        }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
