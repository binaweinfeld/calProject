//
//  BiometricAuthentication.swift
//  Cal
//
//  Created by Bina Walder on 06/10/2024.
//

import LocalAuthentication
import SwiftUI

class BiometricAuthentication {
    
    static func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // בודקים אם המכשיר תומך בזיהוי ביומטרי
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // מבקשים מהמשתמש לזהות את עצמו
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "אנא הזדהה על מנת לגשת למידע המוגן") { success, evaluationError in
                DispatchQueue.main.async {
                    completion(success, evaluationError)
                }
            }
        } else {
            // לא תומך בזיהוי ביומטרי
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}
