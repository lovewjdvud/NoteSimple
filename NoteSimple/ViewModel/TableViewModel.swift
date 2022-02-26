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
    
   var Sqllite = SqliteClass()
   
  //  var noteitem: [NoteItem] = []
    var disposbag = DisposeBag()
   
    init() {
    
        loadData()
    }
    
    
    func loadData()  {
        
        _ = Sqllite.fetchAllMenus()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .map{ menusItem -> [NoteItem] in
                return menusItem
            }
            .take(1)
            .subscribe(onNext: { self.TableViewObservable.accept($0)})
          
    }
    
    
    
    
    func insertTavleViewModelsds(Content:String, Password:String)  {
        
        
        Sqllite.InsetSqlite(Content: Content, Password: Password, insertdate: "2022-2-21")
}
        
}
        
        
        
        
