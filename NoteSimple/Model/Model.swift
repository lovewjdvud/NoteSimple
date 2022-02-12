//
//  Model.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import Foundation

struct NoteItem : Any {
    var Content : String?
    var Id: String?
    var Password: Int?
    var Date: String?
    
    
}



extension NoteItem {
    static  func fromMenuItems(Content: String ) -> NoteItem {
        return NoteItem(Content: Content)
    }
}
