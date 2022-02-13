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
    var filepathconfirm = "/Users/songjeongpyeong/Library/Developer/CoreSimulator/Devices/0053FC45-93A1-4CA1-AB3C-FFFD8FD6FB7B/data/Containers/Data/Application/84454F95-3333-4F71-8FC1-C38F5619E134/Documents/NoteSimpeData.sqlite"
    
    var filemanager: FileManager?
    
    
    
    
    
    func createSqlite()   {
        
        if filemanager?.fileExists(atPath: filepathconfirm) == true {
            print("존재")
        } else {
            print("존재안함")
        }
        
        // SQLite 생성하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpeData.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        print("\(fileURL.path)")
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS NoteSimpe(nId INTEGER PRIMARY KEY AUTOINCREMENT, nContent TEXT, nPassword TEXT, nDate TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
    }

    
    
    func InsetSqlite ( Content:String,Password:String, insertdate:String) {
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO NoteSimpe (nContent,nPassword,nDate) VALUES (?,?,?)"
  
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
  
            return
        }
        if sqlite3_bind_text(stmt, 1, Content, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding name: \(errmsg)")
  
            return
        }
        if sqlite3_bind_text(stmt, 2, Password, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding dept: \(errmsg)")
  
            return
        }
        if sqlite3_bind_text(stmt, 3, insertdate, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding phone: \(errmsg)")
  
            return
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error inserting student: \(errmsg)")
  
            return
        }
        print("성공")
        
    }
    
 func selectSqlite(onComplete: @escaping (Result<Data, Error>) -> Void) {
     //   studentsList.removeAll()
        
        let queryString = "SELECT * FROM student"
    
        var stmt : OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let dept = String(cString: sqlite3_column_text(stmt, 2))
            let phone = String(cString: sqlite3_column_text(stmt, 3))
           
            print(id, name, dept, phone)
            
            //studentsList.append(Students(id: Int(id), name: String(describing: name), dept: String(describing: dept), phone: String(describing: phone)))
            
        }
       // self.tv_ListView.reloadData()
    }
    
//    static func selectSqliteRx() -> Observable<Array<Any>> {
//        return Observable.create { emitter in
//
//            selectSqlite() { result in
//                switch result {
//                case let .success(data):
//                    emitter.onNext(data)
//                    emitter.onCompleted()
//                case let .failure(err):
//                    emitter.onError(err)
//
//                }
//
//            } as! Disposable
//
//        }
//
//        return Disposables.create() as! Observable<Array<Any>>
//   }
    
}
