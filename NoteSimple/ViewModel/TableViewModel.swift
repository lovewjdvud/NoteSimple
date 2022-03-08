//
//  TableViewModel.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import Foundation
import RxSwift
import RxCocoa



class TableViewMdoel {
    
    
   lazy var TableViewObservable = BehaviorSubject<[NoteItem]>(value: [])
    
   var Sqllite = SqliteClass()
   
  //  var noteitem: [NoteItem] = []
    var disposbag = DisposeBag()
   
    init() {
    
        loadData()
    }
    
    
    func loadData()  {
        
        _ = Sqllite.fetchAllMenus()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .map{ menusItem in
                return menusItem!
            }
            .take(1)
            .subscribe(onNext: { self.TableViewObservable.onNext($0)})
          
        
    }
    
    
    
    
    func insertTavleViewModelsds(Content:String, Password:String)  {
        
        
        Sqllite.InsetSqlite(Content: Content, Password: Password, insertdate: "2022-2-21")
}
        
    
    func updateTavleViewModelsds(Content:String, Password:String,id: String,updatedate: String)  {
        
        
        Sqllite.UpdateSqlite(Id: id, Content: Content, Password: Password, Updatedate: updatedate)
}
    func deleteTavleViewModelsds(Id:String)  {
        
        
        Sqllite.DeleteSqlite(Id: Id)
}
    func SelectChangeupdateTavleViewModelsds(Id_1:String,id_2:String)  {
        
        Sqllite.SelectChangeUpdateSqlite(Id_1: Id_1, Id_2: id_2)
    
    }
    
}
        
        
        
        
