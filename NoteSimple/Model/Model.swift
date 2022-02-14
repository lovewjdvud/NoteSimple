//
//  Model.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import Foundation

struct NoteItem : Any {
    var Content : String?
    var Id: Int?
    var Password: String?
    var Date: String?
    
    
    init(Content:String, Id:Int, Password:String,Date:String) {
      
        self.Content = Content
        self.Id = Id
        self.Password = Password
        self.Date = Date
        
        
    }
    
}




