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
    var Number: Int?
    var Password: String?
    var Date: String?
    var Color: String?
    
    
    init(Content:String, Id:Int, Number:Int, Password:String,Date:String,Color:String) {

        self.Content = Content
        self.Id = Id
        self.Password = Password
        self.Date = Date
        self.Number = Number
        self.Color = Color

        
        
    }
    
}

extension NoteItem {
    static let EMPTY = NoteItem(Content: "", Id: 0, Number: 0, Password: "", Date: "", Color: "0")
    
    static  func fromMenuItemsss(id: Int, item: NoteItem) -> NoteItem {
        return NoteItem(Content: item.Content!, Id: item.Id!, Number: item.Number!, Password: item.Password!, Date: item.Date!, Color: item.Color!)    }
}




