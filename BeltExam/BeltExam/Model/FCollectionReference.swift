//
//  FCollectionReference.swift
//  BeltExam
//
//  Created by maram  on 16/06/1444 AH.
//

import Foundation
import Firebase

enum FCRefrence: String {
    case User
    
}
func FirestoreReference(_ collectionRef: FCRefrence) -> CollectionReference {
    return Firestore.firestore().collection(collectionRef.rawValue)
}


