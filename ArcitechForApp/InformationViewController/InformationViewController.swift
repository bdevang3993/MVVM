//
//  InformationViewController.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 04/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    let tableView = UITableView()
    let cellId = "CellId"
    var viewModel = SourceViewModel()
    var apiResponse:TaAPICallBack?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
               view.addSubview(tableView)
               tableView.register(CustomCell.self , forCellReuseIdentifier: cellId)
               tableView.frame = view.frame
               tableView.dataSource = self
               tableView.delegate = self
        self.setAPICall()
    }
    //MARK:- API Call
    func setAPICall() {
        var message = ""
        viewModel.fetchData()
        viewModel.apiResponse = { [weak self] value in
            message = value
            if message == "success"
            {
                if self != nil {
                    self!.tableView.reloadData()
                }
            }
            else {
                Alert().showAlert(message: message, viewController: self!)
            }
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
extension InformationViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
       func numberOfSections(in tableView: UITableView) -> Int {
           return viewModel.numberofSectionInTable()
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50
       }
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return viewModel.sectionTitleData(index: section)
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return  viewModel.arrSoureceData.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!  CustomCell
           cell.sourceVIew = viewModel.arrSoureceData[indexPath.row]
           return cell
       }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           let data = viewModel.arrSoureceData[indexPath.row].description
            Alert().showAlert(message: data!, viewController: self)
           print("Selected Country = \(data!)")
           
       }
}
