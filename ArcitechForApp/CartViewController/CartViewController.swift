//
//  CartViewController.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 18/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tblDisplay: UITableView!
    var objCartViewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        objCartViewModel.setHeaderView(headerView: self.viewHeader)
        tblDisplay.delegate = self
        tblDisplay.dataSource = self
    }
    
    @objc func btnBackClicked() {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
