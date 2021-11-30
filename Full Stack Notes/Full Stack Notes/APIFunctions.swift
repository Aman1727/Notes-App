//
//  APIFunctions.swift
//  Full Stack Notes
//
//  Created by Aman on 01/12/21.
//

import Foundation
import Alamofire

struct Note:Decodable {
    var title:String
    var date:String
    var _id:String
    var note:String
}



protocol DataDelegate {
    func updateArray(newArray: String)
}

class APIFunctions {
    
    var delegate:DataDelegate?
    
    func fetchNotes() {
        AF.request("http://192.168.135.21:3000/fetch").response { response in
            let data = String(data: response.data!, encoding: .utf8)
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func AddNote(date: String, title:String, note:String) {
        AF.request("http://192.168.135.21:3000/create",method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date":date, "note":note]).responseJSON { response in
            
        }
    }
    
    func updateNote(date: String, title: String, note:String,id: String) {
        AF.request("http://192.168.135.21:3000/update",method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON { response in
        }
    }
    
    func deleteNote(id: String) {
        AF.request("http://192.168.135.21:3000/delete",method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON { response in
        }
    }
    
}
