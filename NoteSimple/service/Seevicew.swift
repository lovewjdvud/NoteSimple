//
//  Seevicew.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/12.
//

import Foundation
import SQLite3
import RxSwift
import RxRelay

class SqliteClass {
    
    var db: OpaquePointer?
    
    
    func createSqlite()   {
        // SQLite 생성하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpeData.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS NoteSimpe(nId INTEGER PRIMARY KEY AUTOINCREMENT, nContent TEXT, nPassword TEXT, nDate TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
    }
    
    func selectSqlite()  {
        
        
        
    }
    
    
}
