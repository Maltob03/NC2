//
//  ListView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI
import CryptoKit
import LocalAuthentication

struct ListView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    var accounts: FetchedResults<Account>
    @State private var isUnlocked = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(accounts) { account in
                    HStack {
                        Text(account.name ?? "Not found").padding().bold()
                        VStack{
                            Text(account.mail ?? "Not found").fixedSize(horizontal: false, vertical: true).font(.system(size:15))
                            Text(hash(password: account.pass!)).font(.system(size:15))
                        }.sheet(isPresented: $isUnlocked) {
                            DetailsView(accountName: account.name!, email: account.mail!, password: account.pass!).ignoresSafeArea() .presentationDetents([.medium])
                        }
                    }.frame(height: 100)
                        .onTapGesture {
                            authenticate()
                            
                        }
                    
                }.onDelete(perform: deleteProducts)
            }.navigationTitle("Order List")
            
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
    
    
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { accounts[$0] }.forEach(viewContext.delete)
                saveContext()
            }
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
