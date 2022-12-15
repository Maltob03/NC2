//
//  LockerView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI

struct LockerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: [])
    var accounts: FetchedResults<Account>
    
    @State private var isPresented = false
    var body: some View {
        NavigationView{
            VStack{
                CarouselView().padding()
                VStack{
                    HStack{
                        Text("Recently Used").bold().padding().font(.system(size:30))
                        Spacer()
                    }
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            
                            ForEach(accounts) { account in
                                NavigationLink {
                                    DetailsView(accountName: account.name!, email: account.mail!, password: account.pass!)
                                    
                                } label: {
                                    SingleCardView()
                                    
                                }
                                
                            }
                            /*NavigationLink(destination: DetailsView(accountName: "Apple", email: "altobellomatteo@gmail.com", password: "Maltob03")) {
                                SingleCardView()
                            }
                            NavigationLink(destination: DetailsView(accountName: "Apple", email: "altobellomatteo@gmail.com", password: "Maltob03")) {
                                SingleCardView()
                            }
                            NavigationLink(destination: DetailsView(accountName: "Apple", email: "altobellomatteo@gmail.com", password: "Maltob03")) {
                                SingleCardView()
                            }
                            NavigationLink(destination: DetailsView(accountName: "Apple", email: "altobellomatteo@gmail.com", password: "Maltob03")) {
                                SingleCardView()
                            }
                            NavigationLink(destination: DetailsView(accountName: "Apple", email: "altobellomatteo@gmail.com", password: "Maltob03")) {
                                SingleCardView()
                            }*/
                        }
                        
                    }
                    Button("New Account") {
                        isPresented.toggle()
                    }.buttonStyle(.borderedProminent).padding().font(.system(size:25))
                    Spacer()
                }
            }.navigationTitle("StrongBox")
            .sheet(isPresented: $isPresented) {
                ModalView().ignoresSafeArea() .presentationDetents([.medium])
            }
        }
    }
}

struct LockerView_Previews: PreviewProvider {
    static var previews: some View {
        LockerView()
    }
}
