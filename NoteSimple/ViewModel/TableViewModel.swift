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
    
  
    
    var TableViewObservable = BehaviorSubject<[Note]>(value: [])
    
   var Sqllite = SqliteClass()
   
    var noteitem: [NoteItem] = []
    var disposbag = DisposeBag()
   
    init() {
    
        _ = Sqllite.fetchAllMenus()
           
            .map{ menusItem -> [Note] in
                var menus: [Note] = []
                menusItem.enumerated().forEach { index ,item in
                
                    let menu = Note.fromMenuItems(id: index, item: item as! NoteItem)
                    menus.append(menu)
                    
                }
                print("정평 \(menus)")
                return menus
            }
            .bind(to: TableViewObservable)
           
         
            
    }
            

}
        
            
            
        
        
        
        
        
        
        
        
        
      //Sqllite.createSqlite()
      
     //let menu = NoteItem.fromMenuItems(Content: "test이다", Id: 1, Password: "", Date: "")
        
     //noteitem.append(menu)
        
     // TableViewObservable.onNext(noteitem)
        
        
//        _ = APIService.fetchAllRx()
//         .map { data -> [MenuItem] in
//                 struct Reponse: Decodable {
//                     let menus: [MenuItem]
//                 }
//
//                 let response = try! JSONDecoder().decode(Reponse.self, from: data)
//
//                 return response.menus
//             }
//             .map{ menusItem -> [Menu] in
//                 var menus: [Menu] = []
//                 menusItem.enumerated().forEach { index ,item in
//
//                     let menu = Menu.fromMenuItems(id: index, item: item)
//                     menus.append(menu)
//                 }
//                 return menus
//             }
//         .take(1)
//         .bind(to: menuObservable)





