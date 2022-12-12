//
//  ModalView.swift
//  NC2_PASS_MANAGER
//
//  Created by Matteo Altobello on 08/12/22.
//

import SwiftUI
import CoreData


struct ModalView: View {
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var text: String = ""
    @State var title: String = "Insert your information"
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Product.entity(), sortDescriptors: [])
    private var products: FetchedResults<Product>
    
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
                let product = Product(context: viewContext)
                product.name = name
                product.quantity = quantity
                product.text = text
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

