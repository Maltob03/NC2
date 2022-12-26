//
//  SingleCardView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI

struct SingleCardView: View {
    var body: some View {
        ZStack{
            Rectangle().fill(.yellow).frame(width: 180,height: 100).cornerRadius(15).padding()
            Image("apple").resizable().scaledToFit()
                .frame(width: 128, height: 128)
        }
    }
}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView()
    }
}
