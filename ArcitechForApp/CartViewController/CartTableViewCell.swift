//
//  CartTableViewCell.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 18/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var tblTag:Int = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.setCollectionView()
    }
    //MARK: - Set up collection View
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout // If you create collectionView programmatically then just create this flow by UICollectionViewFlowLayout() and init a collectionView by this flow.

//        let itemSpacing: CGFloat = 3
       // let itemsInOneLine: CGFloat = 10
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       // let width = UIScreen.main.bounds.size.width - itemSpacing * CGFloat(itemsInOneLine - 1) //collectionView.frame.width is the same as  UIScreen.main.bounds.size.width here.
      //  flow.itemSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
            flow.itemSize = CGSize(width: screenWidth, height: 200)
        
        //flow.minimumInteritemSpacing = 10
        //flow.minimumLineSpacing = 3
        flow.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flow
    }
    
    
}
extension CartTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tblTag == 1 {
            return 5
        }else {
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as! CartCollectionViewCell
        cell.imgView.image = UIImage(named: "signUp")
        if tblTag == 1 {
            cell.lblData.text = "All data"
            cell.lblNewData.text = "Description"
            cell.backgroundColor = UIColor.red
        }else {
            cell.lblData.text = "New data"
            cell.lblNewData.text = "Description Data"
            cell.backgroundColor = UIColor.yellow
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Slected section = \(indexPath.section) and Selected Index = \(indexPath.row)")
    }
}

