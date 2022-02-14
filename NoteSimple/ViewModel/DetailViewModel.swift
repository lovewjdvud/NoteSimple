//
//  DetailViewModel.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import Foundation
import RxSwift

class DetailViewMdoel {
    
    var Sqllite = SqliteClass()

    
    
    
    
    func insertDetailViewModel(Content:String, Password:String)  {
      //  var insertdate = "2022-2-12"
        
        Sqllite.InsetSqlite(Content: Content, Password: "", insertdate: "2022-2-12")
        
    }
    
    

    
    
}
