//
//  ReviewRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 4.12.2022.
//

import SwiftUI

struct ReviewRowView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                NavigationLink {
                    
                } label: {
                    HStack{
                        Image("idil")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40,height: 40)
                            .clipShape(Circle())
                        VStack(alignment: .leading){
                            Text("İdil GÜL")
                                .foregroundColor(.black)
                                .font(.callout)
                                .bold()
                            Text("@zidilgul")
                                .font(.caption2)
                                .foregroundColor(.black)
                                .bold()
                            
                        }
                    }
                }
                Spacer()
                HStack(spacing: 0){
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("10")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.yellow)
                }
            }
            Text("Açıkçası filme karşı ön yargılıydım. Sevgilimin tavsiyesi ile başladım ve gerçekten bayıldım. Bu zamana kadar izlemediğim için biraz da pişmanım. Ancak filmin uzunluğu ...")
                .frame(width: 300, alignment: .leading)
                .font(.footnote)
                .foregroundColor(.black)
                .bold()
        }
        .padding()
        .background(.purple.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius:10)
    }
    
    
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView()
    }
}
