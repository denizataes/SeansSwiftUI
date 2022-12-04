//
//  ActorRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 4.12.2022.
//

import SwiftUI

struct ActorRowView: View {
    var body: some View {
        VStack{
            Image("alpacino")
                .resizable()
                .scaledToFill()
                .frame(width: 80,height: 80)
                .clipShape(Circle())
            Text("Al Pacino")
                .font(.system(size: 16))
                .foregroundColor(.white)
            Text("82 Yaşında")
                .font(.system(size: 10))
                .foregroundColor(.white)
            
                
        }
        
    }
}

struct ActorRowView_Previews: PreviewProvider {
    static var previews: some View {
        ActorRowView()
    }
}
