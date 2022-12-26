//
//  ListView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI
import CryptoKit

struct ListView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    var accounts: FetchedResults<Account>
    @State var showDetails = false
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(accounts) { account in
                    NavigationLink {
                        DetailsView(accountName: account.name!, email: account.mail!, password: account.pass!, sharedKey: account.key!)
                        
                    } label: {
                        HStack {
                            Text(account.name ?? "Not found").padding().bold()
                            VStack{
                                Text(account.mail ?? "Not found").fixedSize(horizontal: false, vertical: true).font(.system(size:15))
                                Text(hash(password: account.pass!)).font(.system(size:15))
                            }
                            }
                        }.frame(height: 100)
                    
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
    
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
