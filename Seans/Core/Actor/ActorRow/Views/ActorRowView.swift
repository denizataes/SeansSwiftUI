//
//  ActorRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 4.12.2022.
//

import SwiftUI
import Kingfisher

struct ActorRowView: View {
    
    @StateObject var viewModel = ActorRowViewModel()
    
    var id: Int
    
    //init(id: Int){
     //   self.viewModel = ActorRowViewModel(id: id)
    //}
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            Text("Oyuncular")
                .font(.headline)
                .foregroundColor(.white)
                .bold()
                .padding(.bottom)
            if viewModel.actors.count == 0{
                HStack{
                    Spacer()
                    ProgressView()
                    Spacer()
                    
                }
            }
            else{
            ScrollView(.horizontal, showsIndicators: false) {
           
                    HStack(spacing: 15){
                        
                        ForEach(viewModel.actors){actorItem in
                            NavigationLink {
                                
                                NewActorView(id: actorItem.id)
                            } label: {
                                VStack{
                                    KFImage(URL(string: "\(Statics.URL)\(actorItem.profile_path)" ))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80,height: 80)
                                        .clipShape(Circle())
                                        
                                    
                                    Spacer()
                                    
                                    Text(actorItem.name ?? "")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .scaledToFit()
                                        .minimumScaleFactor(0.01)
                                        .lineLimit(1)
                                    
                                    
                                    Text(actorItem.character ?? "")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .scaledToFit()
                                        .minimumScaleFactor(0.01)
                                        .lineLimit(1)
                                    
                                }
                                .padding(.bottom)
                                .frame(width: 100,height: 130)
                          
                            }
                        }
                        .animation(.easeOut(duration: 1))
          
                    }
                }
            }
        }
        .onAppear{
            viewModel.fetchActors(id: id)
        }
        // .padding()
    }
}
