//
//  CartViewController.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 18/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tblDisplay: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblDisplay.delegate = self
        tblDisplay.dataSource = self
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
extension CartViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 1 {
//            return 100.0
//        }else {
           return 200.0
 //       }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 60.0))
        let label:UILabel = UILabel(frame: CGRect(x:10, y: 10, width: screenWidth/2, height: 40.0))
        label.text = "NewHeader"
        view.addSubview(label)
        
        let labelSubmit:UILabel = UILabel(frame: CGRect(x: screenWidth - 60, y: 10, width: 60, height: 40))
        labelSubmit.text = "Show"
        view.addSubview(labelSubmit)
        let button:UIButton = UIButton(frame: CGRect(x: screenWidth - 60, y: 10, width: 60, height: 40))
        button.tag = section
        button.addTarget(self, action: #selector(btnHeaderClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        return view
        
    }
    @objc func btnHeaderClicked(_ sender:UIButton) {
        print("Button Header Clicked = \(sender.tag)")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let objcell = tblDisplay.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
            objcell.tblTag = indexPath.section
            return objcell
        }else {
            let objcell = tblDisplay.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
            objcell.tblTag = indexPath.section
            return objcell
        }
        
    }
    
}
