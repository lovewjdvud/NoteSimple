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
  
   // var noteitem = NoteItem()
    var noteitem: [NoteItem] = []
    var db: OpaquePointer?
    var filepathconfirm = "/Users/songjeongpyeong/Library/Developer/CoreSimulator/Devices/0053FC45-93A1-4CA1-AB3C-FFFD8FD6FB7B/data/Containers/Data/Application/84454F95-3333-4F71-8FC1-C38F5619E134/Documents/NoteSimpeData2.sqlite"
    var test: Int?
    var filemanager: FileManager?
    var nilvalue = false
   // var tableviewmodel =  TableViewMdoel()
    //var disposbag = DisposeBag()

    
    func createSqlite()   {
        
        if filemanager?.fileExists(atPath: filepathconfirm) == true {
        
        } else {
       
        }
        
        // SQLite 생성하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        print("\(fileURL.path)")
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS NoteSimpe11 (nId INTEGER PRIMARY KEY, nNumber INTEGER, nContent TEXT, nPassword TEXT, nDate TEXT, nColor TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
        
       
    }
    
    func DeleteSqlite (Id:String) {
        //delete from TABLE_NAME;
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
          var stmt: OpaquePointer?
          let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)   //잊지말기
          let queryString = "DELETE FROM NoteSimpe11 WHERE nId = ? "
        
       // "UPDATE Test SET DN_title = '\(DN_title!)', DN_subline = '\(DN_subline!)' WHERE id == \(idNum!)"
        
               
        // != SQLITE_OK 가 아니면 {  } 실행
               if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error preparing insert : \(errmsg)")
                   return    // return 할께 없는게 이게 있으면? 그냥 함수를 빠져나가는 것이다!
               }

               // 2번째 VALUES(?) 처리
               if sqlite3_bind_text(stmt, 1, Id, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error binding dept : \(errmsg)")
                   return
               }
        
        // 실행시키기
       if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting student : \(errmsg)")
            return
        }
    }
    
    
    func allDeleteSqlite () {
        //delete from TABLE_NAME;
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
          var stmt: OpaquePointer?
        _ = unsafeBitCast(-1, to: sqlite3_destructor_type.self)   //잊지말기
          let queryString = "DELETE FROM NoteSimpe11"
        
       // "UPDATE Test SET DN_title = '\(DN_title!)', DN_subline = '\(DN_subline!)' WHERE id == \(idNum!)"
        
               
        // != SQLITE_OK 가 아니면 {  } 실행
               if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error preparing insert : \(errmsg)")
                   return    // return 할께 없는게 이게 있으면? 그냥 함수를 빠져나가는 것이다!
               }
        
        // 실행시키기
       if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting student : \(errmsg)")
            return
        }
    }
    
    func UpdateSqlite (Id:String,Content:String,Password:String, Updatedate:String, Color:String) {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
          var stmt: OpaquePointer?
          let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)   //잊지말기
          let queryString = "UPDATE NoteSimpe11 SET nContent = ?, nPassword = ?, nDate = ? , nColor = ?  WHERE nId = ?"
        
          // != SQLITE_OK 가 아니면 {  } 실행
                 if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                     let errmsg = String(cString: sqlite3_errmsg(db)!)
                     print("error preparing insert : \(errmsg)")
                     return    // return 할께 없는게 이게 있으면? 그냥 함수를 빠져나가는 것이다!
                 }

                 // 2번째 VALUES(?) 처리
                 if sqlite3_bind_text(stmt, 1, Content, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                     let errmsg = String(cString: sqlite3_errmsg(db)!)
                     print("error binding dept : \(errmsg)")
                     return
                 }
        
                 // 4번째 VALUES(?) 처리
                 if sqlite3_bind_text(stmt, 2, Password, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                     let errmsg = String(cString: sqlite3_errmsg(db)!)
                     print("error binding id : \(errmsg)")
                     return
                 }
                // 5번째 VALUES(?) 처리
                if sqlite3_bind_text(stmt, 3, "2022-02-21", -1, SQLITE_TRANSIENT) != SQLITE_OK{
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("error binding id : \(errmsg)")
                    return
                }
        
                if sqlite3_bind_text(stmt, 4, Color, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error binding name : \(errmsg)")
                   return
               }
        if sqlite3_bind_text(stmt, 5, Id, -1, SQLITE_TRANSIENT) != SQLITE_OK{
           let errmsg = String(cString: sqlite3_errmsg(db)!)
           print("error binding name : \(errmsg)")
           return
       }
                 
                 // 실행시키기
                if sqlite3_step(stmt) != SQLITE_DONE{
                     let errmsg = String(cString: sqlite3_errmsg(db)!)
                     print("failure inserting student : \(errmsg)")
                     return
                 }
    }
    
    
    func SelectChangeUpdateSqlite (allnoteitem: [NoteItem]) {
        
        var idarray : [String] = []
        
      
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
          var stmt: OpaquePointer?
          let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)   //잊지말기
        
        let queryString = "INSERT INTO NoteSimpe11 (nContent,nPassword,nDate,nColor) VALUES (?,?,?,?)"
        

        
        for i in 0...allnoteitem.count-1 {
            
            let Content = allnoteitem[i].Content
            let Password = allnoteitem[i].Password
            let insertdate = allnoteitem[i].Date
            let Color = allnoteitem[i].Color
            
         
            
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
            
            if sqlite3_bind_text(stmt, 4, Color, -1, SQLITE_TRANSIENT) != SQLITE_OK{
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
    }
    
    func InsetSqlite ( Content:String,Password:String, insertdate:String) {
       
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")
   
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
     
        
        
        let queryString = "INSERT INTO NoteSimpe11 (nContent,nPassword,nDate,nColor) VALUES (?,?,?,?)"
  
        
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
        if sqlite3_bind_text(stmt, 4, "0", -1, SQLITE_TRANSIENT) != SQLITE_OK{
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
    
    
    func sqlselect(onComplete: @escaping (Result<[NoteItem], Error>)-> Void) {
        //   studentsList.removeAll()
        createSqlite()
        
       let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("NoteSimpe9.sqlite")

       if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
           print("error opening database")
       }
       
           let queryString = "SELECT * FROM NoteSimpe11"
           var stmt : OpaquePointer?
        
           if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("error preparing select: \(errmsg)")
            onComplete(.failure(sqlite3_errmsg(db)! as! Error))
            
            return
          
           }
       
           while(sqlite3_step(stmt) == SQLITE_ROW){
            
               let id = Int(sqlite3_column_int(stmt, 0))
               let number = Int(sqlite3_column_int(stmt, 1))
               let Content = String(cString: sqlite3_column_text(stmt, 2))
               let Password = String(cString: sqlite3_column_text(stmt, 3))
               let SelectDate = String(cString: sqlite3_column_text(stmt, 4))
               let Color = String(cString: sqlite3_column_text(stmt, 5))
            
             
             //let noteite =  NoteItem.fromMenuItems(Content: Content, Id: id, Password: Password, Date: SelectDate)
         
            noteitem.append(NoteItem(Content: Content, Id: id, Number: number, Password: Password, Date: SelectDate, Color: Color))
        
            
    }
      
        
        print("number wwwwwwwwwww wwwwwww www   == = = == = = = = \(noteitem)")
        onComplete(.success(noteitem))

        
    }
    
    
    func fetchAllMenus() -> Observable<[NoteItem]>  {
       
         
        
         return Observable.create { emitter in
            
            self.sqlselect() {  result in
                switch result {
                case let .success(note):
                    emitter.onNext(note)
                    self.noteitem.removeAll()
                    emitter.onCompleted()
                case let .failure(err):
                    emitter.onError(err)
                
                }
                
            }
            
            
            return Disposables.create()
         }
            
    }
    
    
    

}
