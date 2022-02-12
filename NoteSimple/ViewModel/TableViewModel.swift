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
   
    var noteitem: [NoteItem] = []
    let menu = NoteItem.fromMenuItems(Content: "정평아")
    init() {
        

      Sqllite.createSqlite()
      
      noteitem.append(menu)
        
      TableViewObservable.onNext(noteitem)
    
       
    }
    


}

