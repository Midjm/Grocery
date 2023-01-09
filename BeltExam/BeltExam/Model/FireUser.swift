//
//  FireUser.swift
//  BeltExam
//
//  Created by maram  on 16/06/1444 AH.
//

import Foundation
import Firebase


class FireUser {
    
    static let shared = FireUser()
    
    private init () {}
    
    
    //MARK:- Login
    
    
    
    
    
    
    //MARK:- Register
    
    func registerUserWith (email: String, password: String, completion: @escaping(_ error: Error?)->Void) {
        
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//          // ...
//        }
        Auth.auth().createUser(withEmail: email, password: password) { [self] (authResults, error) in
            
             completion(error)
            
            if error == nil {
                authResults!.user.sendEmailVerification {(error) in
                    completion(error)
                    
                }
            }
            if authResults?.user != nil {
                let user = User(id: authResults!.user.uid, email: email, pushId: "")
                
                
                saveUserToFirestor(user)
                saveUserLocally(user)
            }
        }
    }
    
    private func saveUserToFirestor(_ user: User) {
        
        do {
            
            try FirestoreReference(.User).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
