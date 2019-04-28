//
//  AccountManager.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/04/09.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import Foundation
import Firebase

final class AccountManager {
    static let manager = AccountManager()
    
    private let auth = Auth.auth()
    
    private init() {
    }
    
    func didSetUp(listener: @escaping AuthStateDidChangeListenerBlock) {
        auth.addStateDidChangeListener(listener)
    }
    
    func signIn(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signUp(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        auth.createUser(withEmail: email, password: password, completion: completion)
    }
    
    @discardableResult
    func signOut() -> Bool {
        do {
           try auth.signOut()
            
            return true
        } catch {
            return false
        }
    }
    
    func currentUser() -> User? {
        return auth.currentUser
    }
}
