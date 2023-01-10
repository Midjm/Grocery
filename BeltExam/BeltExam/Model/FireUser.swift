//
//  FireUser.swift
//  BeltExam
//
//  Created by maram  on 16/06/1444 AH.
//

import Foundation
import Firebase

//FUswerListner
class FireUser {
    
    static let shared = FireUser()
    
    private init () {}
    
    
    //MARK:- Login
    func loginUserWith(email: String, pasword: String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool)->Void){
        
        Auth.auth().signIn(withEmail: email, password: pasword) {  (authResults, error) in
            
            if error == nil && authResults!.user.isEmailVerified{
                completion(error,true)
                self.downloadUserFromFirestore(userId: authResults!.user.uid)
            }else {
                completion(error,false)
            }
        }
    }
    
    
    
    
    
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
    
    //MARK:- Downlaod user from firestore
    
    private func downloadUserFromFirestore (userId: String) {
        FirestoreReference(.User).document(userId).getDocument { document, error in
            
            guard let userDocument = document else {
                print("No data found")
                return
            }
            let result = Result {
               try?  userDocument.data (as: User.self)
            }
            switch result {
            case .success(let userObj):
                if let user = userObj {
                    saveUserLocally(user)
                }else{
                    print("Document dose not exist")
                }
            case .failure(let error):
                print("error decoding user",error.localizedDescription)
            }
        }
    }
    
}
