//
//  DatbaseViewController.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 10/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class DatbaseViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPowerRanking: UITextField!
    @IBOutlet weak var tblViewHeros: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    var headerViewXib:CommanView?
    var objDatabaseViewModel = DatabaseViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblViewHeros.dataSource = self
        self.tblViewHeros.delegate = self
        objDatabaseViewModel.setUpAllTheValue()
        self.tblViewHeros.reloadData()
        self.setHeaderView()
    }
    
    //MARK:- HeaderView
    func setHeaderView() {
        headerViewXib = setCommanHeaderView()
        viewHeader.frame = headerViewXib!.frame
        headerViewXib!.lblTitle.text = "Database Demo"
        headerViewXib?.btnHeader.isHidden = true
        headerViewXib?.btnBack.isHidden = false
        headerViewXib?.btnBack.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        viewHeader.addSubview(headerViewXib!)
    }
    @objc func btnBackClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitClicked(_ sender: Any) {
        var message:String = ""
        objDatabaseViewModel.nameOfPerson = self.txtName.text!
        objDatabaseViewModel.powerRanking = self.txtPowerRanking.text!
        do {
            message = try objDatabaseViewModel.addValueinDatabase()
        }
        catch LoginValidation.nameEmpty {
            Alert().showAlert(message: LoginValidation.nameEmpty.loginValidationDescription(), viewController: self)
        }
        catch LoginValidation.descriptionEmpty {
             Alert().showAlert(message: LoginValidation.descriptionEmpty.loginValidationDescription(), viewController: self)
        }
        catch {
            
        }
        if message == "success"
        {
            if self != nil {
                self.tblViewHeros.reloadData()
            }
        }
        else {
            Alert().showAlert(message: message, viewController: self)
        }
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
extension DatbaseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objDatabaseViewModel.arrHeroData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = objDatabaseViewModel.arrHeroData[indexPath.row].name//"hero.name"
        return cell
    }
    
    
}
