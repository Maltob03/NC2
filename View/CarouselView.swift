//
//  CarouselView.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import SwiftUI

struct CarouselView: View {
    @State private var index = 0
    var body: some View {
            TabView(selection: $index) {
                ZStack{
                    Rectangle().fill(.blue).frame(width: 350,height: 250).cornerRadius(15).padding()
                    VStack{
                        Text("Tips & Tricks").bold().foregroundColor(.white).padding(.vertical)
                        Text("Use different password for each account").bold().foregroundColor(.white).padding(.vertical)
                    }
                }.tag(1)
                
                
                ZStack{
                    Rectangle().fill(.blue).frame(width: 350,height: 250).cornerRadius(15).padding()
                    VStack{
                        Text("Tips & Tricks").bold().foregroundColor(.white).padding(.vertical)
                        Text("Use different password for each account").bold().foregroundColor(.white).padding(.vertical)
                    }
                }.tag(2)
                
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}

