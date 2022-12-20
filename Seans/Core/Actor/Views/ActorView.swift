////
////  Home.swift
////  BottomSheetNew (iOS)
////
////  Created by Balaji on 23/05/21.
////
//
//import SwiftUI
//import Kingfisher
//
//struct ActorView: View {
//
//    // Gesture Properties...
//    @State var offset: CGFloat = 0
//    @State var lastOffset: CGFloat = 0
//    @GestureState var gestureOffset: CGFloat = 0
//    @ObservedObject var viewModel: ActorViewModel
//    @Environment(\.presentationMode) var mode
//
//    init(id: Int){
//        self.viewModel = ActorViewModel(id: id)
//    }
////
////
//
//    var body: some View {
////        VStack{
////            Button {
////                mode.wrappedValue.dismiss()
////            } label: {
////                Image(systemName: "arrow.left")
////                    .resizable()
////                    .frame(width: 20,height: 18)
////                    .bold()
////            }
////
////        }
//
//        ZStack{
//
//
//           // if viewModel.loaded {
//
//                // For getting Frame For Image...
//                GeometryReader{proxy in
//
//                    let frame = proxy.frame(in: .global)
//
//
//                                            KFImage(URL(string: "\(Statics.URL)\(viewModel.actor.profile_path!)"))
//                      //  Image("alpacino")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: frame.width, height: frame.height)
//                            //.saturation(0.0)
//
//
//                }
//                .blur(radius: getBlurRadius())
//                .ignoresSafeArea()
//
//                // Bottom Sheet....
//
//                // For Getting Height For Drag Gesture...
//                GeometryReader{proxy -> AnyView in
//
//                    let height = proxy.frame(in: .global).height
//
//                    return AnyView(
//
//                        ZStack{
//
//                            BlurView(style: .systemThinMaterialDark)
//                                .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 30))
//
//                            VStack{
//
//                                VStack(spacing: 10){
//                                    Capsule()
//                                        .fill(Color.white)
//                                        .frame(width: 60, height: 5)
//                                        .padding(.top,3)
//
//
//                                    //                                HStack{
//                                   // Text(viewModel.actor.name ?? "")
//                                    HStack{
////                                        Text("Al Pacino")
//                                         Text(viewModel.actor.name ?? "")
//                                            .font(.title)
//                                            .bold()
//                                            .foregroundColor(.white)
//
//                                        Spacer()
//
//                                        VStack(alignment: .trailing, spacing: 2){
////                                            Text("25 Nisan 1940")
//                                            Text(viewModel.actor.birthday ?? "")
//                                                .font(.system(size: 14))
//                                                .foregroundColor(.white)
//                                            Text(viewModel.actor.place_of_birth ?? "")
//                                                .font(.system(size: 12))
//                                                .bold()
//
//                                        }
//                                        .foregroundColor(.white)
//
//                                    }
//                                    .padding(.trailing)
//                                    .padding(.leading)
//                                    //                                    Spacer()
//                                    //                                    Text("25 Nisan 1940 (82 yıl yaşında)")
//                                    //                                        .font(.system(size: 9))
//                                    //                                        .foregroundColor(.white)
//                                    //                                        .padding(.trailing)
//                                    //                                }
//                                }
//                                .frame(height: 100)
//
//                                // SCrollView Content....
//                                ScrollView(.vertical, showsIndicators: false, content: {
//
//                                    BottomContent
//                                        .padding(.bottom)
//                                        .padding(.bottom,offset == -((height - 100) / 3) ? ((height - 100) / 1.5) : 0)
//                                })
//                            }
//                            .padding(.horizontal)
//                            .frame(maxHeight: .infinity, alignment: .top)
//                        }
//                            .offset(y: height - 100)
//                            .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
//                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
//
//                                out = value.translation.height
//                                onChange()
//                            }).onEnded({ value in
//
//                                let maxHeight = height - 100
//                                withAnimation{
//
//                                    // Logic COnditions For Moving States...
//                                    // Up down or mid....
//                                    if -offset > 100 && -offset < maxHeight / 2{
//                                        // Mid....
//                                        offset = -(maxHeight / 3)
//                                    }
//                                    else if -offset > maxHeight / 2{
//                                        offset = -maxHeight
//                                    }
//                                    else{
//                                        offset = 0
//                                    }
//                                }
//
//                                // Storing Last Offset..
//                                // So that the gesture can contiue from the last position...
//                                lastOffset = offset
//
//                            }))
//                    )
//                }
//
//                .ignoresSafeArea(.all, edges: .bottom)
//
//            }
////            else
////            {
////                EmptyView()
////            }
//
//
//
//      //  .navigationBarHidden(true)
////        .onAppear{
////            viewModel.fetchActor(id: self.id)
////
////        }
//
//    }
//
//    func onChange(){
//        DispatchQueue.main.async {
//            self.offset = gestureOffset + lastOffset
//        }
//    }
//
//    // Blur Radius For BG>..
//    func getBlurRadius()->CGFloat{
//
//        let progress = -offset / (UIScreen.main.bounds.height - 100)
//
//        return progress * 30 <= 30 ? progress * 30 : 30
//    }
//}
//
//extension ActorView{
//    var BottomContent: some View{
//        VStack{
//
//            HStack{
//
//                Text("Hakkında 🤔")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//
//                Spacer()
//            }
//            .padding(.top,20)
//
//            Divider()
//                .background(Color.white)
//
//
//            Text(viewModel.actor.biography ?? "")
////            Text("Alfredo James Pacino, 25 Nisan 1940 yılında New York,ABD'de doğdu. Hollywood'un baş aktörlerinden olan Pacino, genç yaşta oyunculuk eğitimi almaya başladı ve pek çok oyunda ödüller de kazanarak yer aldı. Broadway'de sahneye çıktığı ilk oyun Does the Tiger Wear a Necktie? ile Tony Ödülü'nün sahibi oldu. Kariyerindeki ilk filmi, 1969 yılında çevirdiği Me, Natalie oldu. Bu filmdeki performansı ile yapımcılığını Paramount'un üstlendiği, Francis Ford Coppola'nın efsane The Godfather (Baba) filminde Michael Corleone rolünü oynamaya hak kazandı. Bu filmdeki performansı ile En İyi Yardımcı Erkek Oyuncu Oscar'ına aday gösterildi ve dünya çapında hızlıca üne kavuştu. Baba 2 ile üçüncü defa Oscar'a aday gösterilen Al Pacino, 1975 yılında çekilen  da, homoseksüel sevgilisinin cinsiyet değiştirme ameliyatının parasını karşılamak için banka soymaya kalkan bir aşığı canlandırdı. Broadway oyunlarına döndü ve başrolünü oynadığı The Basic Training of Pavlo Hummel ile ikinci kez Tony ödülünün sahibi oldu. 1983 yılında Brian De Palma'nın yönettigi, şiddeti bol Scarface (Yaralı Yüz) filminde başrol Tony Montana'yı canlandırdı. Film, sinemanın kült filmleri arasındaki yerini aldı. Bir süre başarısız filmlerde yer alan aktörün dönüşü, 1989'da çekilen Sea of Love (Aşk Denizi) filmi ile oldu. Film büyük sükse yaptı. 1990'da gösterişli bir gangsteri oynadığı Dick Tracy ile 6. kez Oscar'a aday olan Pacino, aynı yıl")
//                .foregroundColor(.white)
//
//
//
////            Divider()
////                .background(Color.white)
////            HStack{
////
////                Text("Bu filmlerde bir başkaydı... 🔥")
////                    .fontWeight(.bold)
////                    .foregroundColor(.white)
////
////                Spacer()
////            }
////            .padding(.top,20)
////
////            Divider()
////                .background(Color.white)
////
////            Text("")
////
////
////            HStack{
////
////                Text("Editor's Pick")
////                    .fontWeight(.bold)
////                    .foregroundColor(.white)
////
////                Spacer()
////
////                Button(action: {}, label: {
////                    Text("See All")
////                        .fontWeight(.bold)
////                        .foregroundColor(.gray)
////                })
////            }
////            .padding(.top,25)
////
////            Divider()
////                .background(Color.white)
//        }
//    }
//}
//
////struct ActorPreviews_Previews: PreviewProvider {
////    static var previews: some View {
////        ActorView()
////    }
////}
//
////struct BottomContent: View {
////
////    var body: some View{
////
////        VStack{
////
////            HStack{
////
////                Text("Biyografi")
////                    .fontWeight(.bold)
////                    .foregroundColor(.white)
////
////                Spacer()
////            }
////            .padding(.top,20)
////
////            Text(viewModel.actor.biography)
////
////            Divider()
////                .background(Color.white)
////
////            ScrollView(.horizontal, showsIndicators: false, content: {
////
////                HStack(spacing: 15){
////
////                    VStack(spacing: 8){
////
////                        Button(action: {}, label: {
////                            Image(systemName: "house.fill")
////                                .font(.title)
////                                .frame(width: 65, height: 65)
////                                .background(BlurView(style: .dark))
////                                .clipShape(Circle())
////                        })
////
////                        Text("Home")
////                            .foregroundColor(.white)
////                    }
////
////                    VStack(spacing: 8){
////
////                        Button(action: {}, label: {
////                            Image(systemName: "briefcase.fill")
////                                .font(.title)
////                                .frame(width: 65, height: 65)
////                                .background(BlurView(style: .dark))
////                                .clipShape(Circle())
////                        })
////
////                        Text("Work")
////                            .foregroundColor(.white)
////                    }
////
////                    VStack(spacing: 8){
////
////                        Button(action: {}, label: {
////                            Image(systemName: "plus")
////                                .font(.title)
////                                .frame(width: 65, height: 65)
////                                .background(BlurView(style: .dark))
////                                .clipShape(Circle())
////                        })
////
////                        Text("Add")
////                            .foregroundColor(.white)
////                    }
////                }
////            })
////            .padding(.top)
////
////            HStack{
////
////                Text("Editor's Pick")
////                    .fontWeight(.bold)
////                    .foregroundColor(.white)
////
////                Spacer()
////
////                Button(action: {}, label: {
////                    Text("See All")
////                        .fontWeight(.bold)
////                        .foregroundColor(.gray)
////                })
////            }
////            .padding(.top,25)
////
////            Divider()
////                .background(Color.white)
////
//////            ForEach(1...6,id: \.self){index in
//////
//////                Image("p\(index)")
//////                    .resizable()
//////                    .aspectRatio(contentMode: .fill)
//////                    .frame(width: UIScreen.main.bounds.width - 30, height: 250)
//////                    .cornerRadius(15)
//////                    .padding(.top)
//////            }
////        }
////    }
////}
