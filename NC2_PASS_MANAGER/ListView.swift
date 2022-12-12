//
//  ListView.swift
//  NC2_PASS_MANAGER
//
//  Created by Matteo Altobello on 08/12/22.
//

import SwiftUI

struct ListView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Product.entity(), sortDescriptors: [])
    var products: FetchedResults<Product>
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(products) { product in
                    NavigationLink {
                        DetailsView(accountName: product.name!, email: product.quantity!, password: product.text!)
                        
                    } label: {
                        HStack {
                            Text(product.name ?? "Not found").padding().bold()
                            VStack{
                                Text(product.quantity ?? "Not found").fixedSize(horizontal: false, vertical: true).font(.system(size:15))
                                Text(hash(password:product.text!)).font(.system(size:15))
                            }
                        }.frame(height: 100)
                        
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
            offsets.map { products[$0] }.forEach(viewContext.delete)
                saveContext()
            }
    }
    
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
