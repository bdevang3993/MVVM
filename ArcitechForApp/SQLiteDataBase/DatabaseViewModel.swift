//
//  DatabaseViewModel.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 10/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import Foundation
import SQLite3

class DatabaseViewModel:NSObject{
    var arrHeroData = [HeroModel]()
    var db: OpaquePointer?
    var nameOfPerson:String = "" {
        didSet {
            print("Name of person = \(nameOfPerson)")
        }
    }
    var powerRanking:String = "" {
        didSet {
            print("Power Ranking = \(powerRanking)")
        }
    }
    //MARK:- Fetch or Create Database
    func setUpAllTheValue() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("HeroesDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        readValues()
    }
    //MARK:- Fetch value from Database
    func readValues(){
        //heroList.removeAll()

        let queryString = "SELECT * FROM Heroes"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let powerrank = sqlite3_column_int(stmt, 2)
            var objHero:HeroModel = HeroModel(id: Int(id), name: String(name), powerRanking: String(powerrank))
            print("All Data = \(objHero)")
            arrHeroData.append(objHero)
//            heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
      //  self.tableViewHeroes.reloadData()
    }
//MARK:- Add value in Database
    func addValueinDatabase()throws -> String {
        var strMessage = "success"
        
        if nameOfPerson.isEmpty {
            throw LoginValidation.nameEmpty
        }
        if powerRanking.isEmpty {
            throw LoginValidation.descriptionEmpty
        }
        
        
        var stmt: OpaquePointer?
        
        let queryString = "INSERT INTO Heroes (name, powerrank) VALUES (?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            strMessage = errmsg
           // return
        }
        
        if sqlite3_bind_text(stmt, 1, nameOfPerson, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            strMessage = errmsg
            //return
        }
        
        if sqlite3_bind_int(stmt, 2, (powerRanking as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            strMessage = errmsg
            //return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            strMessage = errmsg
            //return
        }
        
        //              textFieldName.text=""
        //              textFieldPowerRanking.text=""
        
        readValues()
    
        print("Herro saved successfully")
        return strMessage
    }
    
}
