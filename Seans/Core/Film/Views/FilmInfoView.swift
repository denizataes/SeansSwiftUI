//
//  FilmInfoView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmInfoView: View {
    @State private var backgroundColor: Color = .clear
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: 0){
                    Image("godfather")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.2)
                    Image("godfather")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.2)
                }
                VStack(alignment: .center){
                    HStack{
                        VStack(alignment: .leading,spacing: 15){
                            HStack{
                                Image(systemName: "calendar")
                                    .foregroundColor(.white)
                                Text("19 Ekim 1973")
                                    .font(.system(size: 8))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            
                            HStack{
                                Image(systemName: "clock")
                                    .foregroundColor(.white)
                                Text("2 Saat 55 Dakika")
                                    .font(.system(size: 8))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        Image("godfather")
                            .resizable()
                            .frame(width: 200,height:280)
                            .shadow(radius: 50)
                            .cornerRadius(15)
                            .padding(.top,80)
                        Spacer()
                        VStack{
                            HStack{
                                ZStack{
                                    Color(red: 245/255, green: 222/255, blue: 80/255)
                                        .frame(width: 32,height:32 )
                                        .clipShape(Circle())
                                    
                                    VStack{
                                        Text("IMDb")
                                            .font(.system(size: 9))
                                            .bold()
                                            .foregroundColor(.black)
                                    }
                                }
                                Text("9.2")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.system(size: 12))
                            }
                            
                            HStack{
                                Image(systemName: "star")
                                    .resizable()
                                    .frame(width: 32,height: 32)
                                    .foregroundColor(.purple)
                                Text("9.6")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
   
                    
                    VStack{
                        Text("The Godfather")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        HStack{
                            FilmCategoryButton(buttonName: "Aksiyon")
                            FilmCategoryButton(buttonName: "Suç")
                            FilmCategoryButton(buttonName: "Drama")
                        }
                        Text("Sicilya'dan göç eden Corleone ailesi, Amerika'da yerleşme çabalarını sürdürürken kendilerine kaba kuvvet kullanmaya kalkan ve yapmaya kalktıkları her işten haraç isteyen bir takım kimliği belirsiz kişilere karşı onlar da kaba kuvvet kullanmaya ve bunda da başarılı olmaya başlayınca kendilerini tahmin bile edemeyecekleri bir yaşantının içinde bulurlar. Bir taraftan son derece katı örf ve aile yaşantısı diğer tarafta ise acımasızca önlerine çıkanları yok etmeye başlayan Corleone ailesi bir müddet sonra Amerika'nın en korkulan mafya topluluğu haline gelmiştir. Kendileri her ne kadar mafya değil bir aile olduklarını söyleseler de.")
                            .multilineTextAlignment(.center)
                            .padding()
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    
                            Spacer()
                        
                    }
                        
                    
                    Spacer()
                }
                .padding()
                    
                
            }

        }
        .edgesIgnoringSafeArea(.all)
        .background(backgroundColor)
        .onAppear {
            self.setAverageColor()
        }
 
        
    }
    
    private func setAverageColor() {
        let uiColor = UIImage(named: "godfather")?.averageColor ?? .clear
        backgroundColor = Color(uiColor)
    }
    
}


struct FilmInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmInfoView()
    }
}


