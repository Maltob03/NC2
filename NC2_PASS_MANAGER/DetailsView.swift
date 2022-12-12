//
//  DetailsView.swift
//  NC2_PASS_MANAGER
//
//  Created by Matteo Altobello on 09/12/22.
//

import SwiftUI
import LocalAuthentication

struct DetailsView: View {
    @State var accountName: String
    @State var email: String
    @State var password: String
    @State private var isUnlocked = true
    
    
    var body: some View {
        VStack{
            if isUnlocked {
                ZStack{
                    Rectangle().fill(.blue).frame(width: 350, height: 200).cornerRadius(10)
                    HStack{
                        Text(accountName).foregroundColor(.white).bold()
                        VStack{
                            Text(email).foregroundColor(.white)
                            Text(password).foregroundColor(.white)
                        }
                    }
                    
                }
                
            } else {
                Text("Locked")
            }
        }//.onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(accountName: "Apple", email: "Prova@prova.com", password: "FOZZANAPOLI")
    }
}
