//
//  User.swift
//  BeltExam
//
//  Created by maram  on 16/06/1444 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    
    var id = ""
    var email: String
    var pushId = ""
    
}


func saveUserLocally(_ user: User) {
    
    let econder = JSONEncoder()
    
    do{
        let data = try econder.encode(user)
        UserDefault.set(data, forKey: KCURRENTUSER)
    } catch {
        print(error.localizedDescription)
    }
    
}
