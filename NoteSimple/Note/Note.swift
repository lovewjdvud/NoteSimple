//
//  Note.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/14.
//

import Foundation

struct Note : Decodable {
    var Content : String?
    var Id: Int?
    var Password: String?
    var Date: String?
    
}


extension Note {
    static  func fromMenuItems(id: Int, item: NoteItem) -> Note {
        return Note(Content: item.Content!, Id: item.Id!, Password: item.Password!, Date: item.Date!)    }
}

