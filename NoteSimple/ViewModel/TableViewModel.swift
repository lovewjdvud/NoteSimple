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
          
            //.take(1)
          
            .subscribe(onNext: { self.TableViewObservable.accept($0)})
           .disposed(by: disposbag)
    }
    
    
    
    
    func insertTavleViewModelsds(Content:String, Password:String)  {
        
      
        Sqllite.InsetSqlite(Content: Content, Password: "", insertdate: "2022-2-12")
       // disposeBag = DisposeBag()
        loadData()
    
}
        
            
            
        
}
        
        
        
        
        
//            .map{ menusItem -> [Note] in
//                var menus: [Note] = []
//                menusItem.enumerated().forEach { index ,item in
//                    print("정평1 \(item)")
//                    let menu = Note.fromMenuItems(id: index, item: item as! NoteItem )
//                    menus.append(menu)
//                }
//                return menus
//            }
        
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





