//
//  NewActorView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import SwiftUI
import Kingfisher

struct NewActorView: View {
    @ObservedObject var viewModel: ActorViewModel
    @Environment(\.presentationMode) var mode
    
        init(id: Int){
            self.viewModel = ActorViewModel(id: id)
        }
    
    var body: some View {
        
        ZStack {
            filmBackground
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center){
                    
                        KFImage(URL(string: "\(Statics.URL)\(viewModel.actor.profile_path ?? "")"))
                        .resizable()
                        .saturation(viewModel.actor.deathday != nil && viewModel.actor.deathday != "" ? 0.0 : 1.0)
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .cornerRadius(10)
                    
                    VStack{
                        Text(viewModel.actor.name ?? "")
                            .font(.largeTitle)
                            .foregroundColor(Color("mode"))
                            .bold()
                            .multilineTextAlignment(.leading)
                        if viewModel.actor.deathday != nil && viewModel.actor.deathday != ""{
                            Text("😔 \(viewModel.actor.birthday ?? "") /  \(viewModel.actor.deathday ?? "")")
                                .font(.callout)
                                .foregroundColor(Color(red: 54/255, green: 26/255, blue: 31/255))
                                .bold()
                        }
                            
                    }
                    
                    
                    HStack{
                        //Text(viewModel.actor.name ?? "")

                        VStack(spacing: 10){
                            Image(systemName: "calendar")
                            Text(viewModel.actor.birthday ?? "Belirtilmemiş")
                                .bold()
                            //                        Text("\(viewModel.actor.birthday ?? "") (82 yaşında)")
                                .font(.system(size: 14))
                        }.frame(width: 100)
                        
                        
                        VStack(spacing: 10){
                            Image(systemName: "house")
                            //                        Text(viewModel.actor.place_of_birth ?? "")
                            Text(viewModel.actor.place_of_birth ?? "Belirtilmemiş")
                                .font(.system(size: 14))
                                .bold()
                            
                        }
                        .frame(width: 100)
                        
                        VStack(spacing: 10){
                            Image(systemName: "star")
                            Text(String(viewModel.actor.popularity ?? 0) ?? "Belirtilmemiş")
                                .bold()
                            //                        Text("\(viewModel.actor.birthday ?? "") (82 yaşında)")
                                .font(.system(size: 14))
                        }.frame(width: 100)
                    }
                    .padding()
                    
                    
                    Divider()
                        .padding(.leading,80)
                        .padding(.trailing,80)
                        .foregroundColor(Color(.white))
                    
                    
                    //            Divider()
                    //                .background(Color("mode"))
                    //   25 Nisan 1940 (82 yaşında)
                    //  New York City, New York, ABD
                    
                    if  viewModel.actor.biography != nil && viewModel.actor.biography != "" {
                        VStack(alignment: .leading,spacing: 20){
                            
                            HStack{
                                Text("Hakkında")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                            }
                            
                            //                Text(viewModel.actor.biography ?? "")
                            Text(viewModel.actor.biography!)
                        }
                        .padding()
                    }
                    
                    //            VStack(alignment: .leading,spacing: 5){
                    //                Text("25 Nisan 1940 (82 yaşında)")
                    //                Text("New York City, New York, ABD")
                    //            }
                    //            .padding(.leading)
                    
                    //            Divider()
                    //                .background(Color("mode"))
                    Spacer()
                    ActorMoviesView(id: viewModel.id)
                }
                
            }
        }
        
        
    }
}

//struct NewActorView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewActorView()
//    }
//}


extension NewActorView{
    var filmBackground: some View{

        GeometryReader{proxy in
            let size = proxy.size
            
//            KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
            KFImage(URL(string: "\(Statics.URL)\(viewModel.actor.profile_path ?? "")"))
                .resizable()
                .saturation(viewModel.actor.deathday != nil && viewModel.actor.deathday != "" ? 0.0 : 1.0)
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
                

               // .tag(index)
            
            
            let color: Color = .black
            // Custom Gradient
            LinearGradient(colors: [
                .black.opacity(0.1),
                .black.opacity(0.8),
                //.black.opacity(0.4),
                //color.opacity(0.1),
                //color.opacity(0.1),
                    .black.opacity(0.1),
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.9))
        }
        .ignoresSafeArea()
    }
}
