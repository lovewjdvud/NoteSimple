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
    
    
   lazy var TableViewObservable = BehaviorRelay<[NoteItem]>(value: [])
    var noteitem: [NoteItem] = []
    var noteitemcount : Int?
   var Sqllite = SqliteClass()
   
  //  var noteitem: [NoteItem] = []
    var disposbag = DisposeBag()
   
    init() {
    
        loadData()
        
    }
    
    
    func loadData()  {
        
        _ = Sqllite.fetchAllMenus()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .map{ [weak self] menusItem in
                self?.noteitem = menusItem
                return menusItem
                
            }
            .take(1)
            .subscribe(onNext: { self.TableViewObservable.accept($0)})
          
        
    }
    
    
    
    
    func insertTavleViewModelsds(Content:String, Password:String)  {
   

        
        Sqllite.InsetSqlite(Content: Content, Password: Password, insertdate: "2022-2-21")
}
        
    
    func updateTavleViewModelsds(Content:String, Password:String, id: String, updatedate: String, color: String)  {
        
        Sqllite.UpdateSqlite(Id: id, Content: Content, Password: Password, Updatedate: updatedate, Color: color)
        
}
    func deleteTavleViewModelsds(Id:String)  {
        
        
        Sqllite.DeleteSqlite(Id: Id)
}
    func SelectChangeupdateTavleViewModelsds(noteitem: [NoteItem])  {
        
        Sqllite.SelectChangeUpdateSqlite(allnoteitem: noteitem)
    
    }
    func alldeleteTavleViewModelsds()  {
        
        
        Sqllite.allDeleteSqlite()
}
    
}
        
        
        
        
