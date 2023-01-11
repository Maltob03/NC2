//
//  ModalView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//
import SwiftUI
import CoreData
import CryptoKit


struct ModalView: View {
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var text: String = ""
    @State var title: String = "Insert your information"
    let key = SymmetricKey(size: .bits256)
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    private var acounts: FetchedResults<Account>
    
    var body: some View {
            VStack {
                Text(title).bold().font(.system(size:25)).padding()
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                SecureField("Add your password", text: $text)
                
                HStack {
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                        text = ""
                    }
                    Spacer()
                    Button("Add") {
                        addProduct()
                    }.buttonStyle(.borderedProminent)
                    Spacer()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
    
    private func addProduct() {
            
            withAnimation {
                let savedKey = key.withUnsafeBytes {Data(Array($0)).base64EncodedString()}
                let account = Account(context: viewContext)
                account.name = name
                account.mail = quantity
                account.key = savedKey
                account.pass = crypto(password: text, key: key)
                saveContext()
                title="Account Added"
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
    
    
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}

