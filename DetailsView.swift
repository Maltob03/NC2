//
//  DetailsView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI
import CryptoKit

struct DetailsView: View {
    @State var accountName: String
    @State var email: String
    @State var password: String
    let key = Singleton.shared
    
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle().fill(.blue).frame(width: 350, height: 200).cornerRadius(10)
                HStack{
                    Text(accountName).foregroundColor(.white).bold()
                    VStack{
                        Text(email).foregroundColor(.white)
                        Text(decrypto(password:password, key: key)).foregroundColor(.white)
                        //Text(hash(password: password)).foregroundColor(.white).fixedSize(horizontal: false, vertical: true)
                        
                    }
                }
                
            }
            
        }
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(accountName: "Apple", email: "Prova@prova.com", password: "FOZZANAPOLI")
    }
}
