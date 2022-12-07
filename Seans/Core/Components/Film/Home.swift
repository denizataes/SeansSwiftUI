//
//  Home.swift
//  AnimationChallenge3 (iOS)
//
//  Created by Balaji on 29/03/22.
//

import SwiftUI

struct Home: View {
    // MARK: Animated View Properties
    
    var movies: [Movie] = [
        
        Movie(movieTitle: "Godfather", releaseDate: "19 Ekim 1972", movieTime: "2 Saat 55 Dakika", movieDescription: "Baba, 40’lar ve 50’lerin Amerika’sında, bir İtalyan mafya ailesinin destansı öyküsünü konu alıyor. Don Corleone’nin kızı Connie’nin düğününde, ailenin en küçük oğlu ve bir savaş gazisi olan Michael babasıyla barışır. Bir suikast girişimi, Don’u artık işleri yönetemeyecek duruma düşürünce, ailenin başına Michael ve ağabeyi Sonny geçer. Danışmanları Tom Hagen’in de yardımlarıyla diğer ailelere savaş açan Corleone ailesi, eski moda yöntemleri de değiştirmeye başlar.", artwork: "godfather"),
        
        Movie(movieTitle: "Ad Astra", releaseDate: "20 Eylül 2019", movieTime: "2 Saat 4 Dakika", movieDescription: "Yıldızlara Doğru, astronot Roy McBride'ın gerçekleştirdiği uzay yolculuğunu konu ediyor. Astronot Roy McBride’nın babası, 20 yıl önce uzayda hayat olup olmadığını araştırmakla görevlendirilmiştir. Ancak bu görev sırasında kaybolan adamdan bir daha haber alınamaz. Kaybolan babasını galakside aramak isteyen Roy, gezegeni tehdit eden bir gizemi de çözmek amacıyla güneş sisteminin dışına yolculuk eder. Bu yolculuk Roy’un beklediğinde de farklı şeyler öğrenmesine neden olur. Yolculuk sayesinde astronot, insan varlığının doğasına ve kozmostaki yerimize meydan okuyan sırların ortaya çıkmasını sağlar.", artwork: "Movie1"),
        
        Movie(movieTitle: "Starwars", releaseDate: "21 Aralık 2019", movieTime: "2 Saat 22 Dakika", movieDescription: "Kylo Ren, Büyük Lider Snoke'u öldürmesinin ardından İlk Düzen'in yeni Büyük Lider'i olmuştur. Acımasız yönetiminin altında galaksi yavaş yavaş umutsuzluğa kapılmaktadır. Luke Skywalker'ın Güç'le birleşmesinden sonra Rey kendi içindeki gücü benimsemiş, onu geçmişte tutan bağlarını kesmeyi başarmıştır.", artwork: "Movie2"),
        
        
        Movie(movieTitle: "Toy Story 4 ", releaseDate: "21 Haziran 2019", movieTime: "1 Saat 40 Dakika", movieDescription: "Oyuncak Hikayesi 4, kaşıktan yapılma bir oyuncak olan Forky’nin atıldığı macerayı konu ediyor. Bir geri dönüşüm projesi ile yaratılan Forky, oyuncak olduğunu asla kabul etmez. Tek kullanımlık bir kaşıktan yapılma bir oyuncak olsa da o oyuncak olmadığı konusunda ısrarcıdır. Kendisini Bonnie’nin odasına ait hissetmeyen Forky, dünyadaki amacının ne olduğunu düşünmeye başlar. Kendisini oyuncaklardan biri olarak görmediği için Bonnie’nin yanında kalmak zorunda hissetmeyen Forky, dünyadaki amacını kaşık olarak yerine getirmeye karar verir. Ancak onun oyuncak olarak üstesinden gelmesi gereken bambaşka bir görevi vardır.", artwork: "Movie3"),
        
        
        Movie(movieTitle: "Lion King", releaseDate: "19 Temmuz 2019", movieTime: "1 Saat 58 Dakika", movieDescription: "Baba, 40’lar ve 50’lerin Amerika’sında, bir İtalyan mafya ailesinin destansı öyküsünü konu alıyor. Don Corleone’nin kızı Connie’nin düğününde, ailenin en küçük oğlu ve bir savaş gazisi olan Michael babasıyla barışır. Bir suikast girişimi, Don’u artık işleri yönetemeyecek duruma düşürünce, ailenin başına Michael ve ağabeyi Sonny geçer. Danışmanları Tom Hagen’in de yardımlarıyla diğer ailelere savaş açan Corleone ailesi, eski moda yöntemleri de değiştirmeye başlar.", artwork: "Movie4"),
        
        Movie(movieTitle: "Spider Man No Way Home", releaseDate: "2 Eylül 2022", movieTime: "2 Saat 28 Dakika", movieDescription: "Örümcek-Adam Eve Dönüş Yok, kimliği açığa Örümcek-Adam'ın, sırrını geri vermesi için Doktor Strange'den yardım istemesiyle birlikte yaşananları konu ediyor. Örümcek-Adam'ın kimliği ifşa edilerek onun ve sevdiklerinin hayatı, halkın gözü önüne serilir. Kendisini büyük bir kaosun ortasında bulan Peter, aynı zamanda suç ortakları olarak lanse edilen MJ ve Ned'in hayatının da olumsuz etkilenmesine şahit olur. Arkadaşların üniversiteye girme şanslarının yok olmasına seyirci kalmak istemeyen Peter, sırrını geri vermesi için Doktor Strange'den yardım ister. Peter'ın yakarışından etkilenip ona yardım etmeyi kabul eden Strange, Unutma Büyüsü'nü yapmaya başlar. Ancak bu büyü, MJ, Ned, May ve Happy'nin de Örümcek-Adam'ın kim olduğunu unutmasına neden olacaktır. Arkadaşlarının kim olduğunu hatırlamasını, diğer kişilerin unutmasını isteyen Peter, Strange büyüyü yaparken parametreleri değiştirir. Ancak bu durum beklenmedik olaylara neden olur.", artwork: "Movie5"),
        
        Movie(movieTitle: "Shang Chi", releaseDate: "3 Eylül 2021", movieTime: "2 Saat 12 Dakika", movieDescription: "Shang-Chi and the Legend of the Ten Rings, babası tarafından suikastçı olmak üzere yetiştirilen Shang-Chi’nin hikayesini konu ediyor. Shang-Chi'nin babası ölümsüz bir büyücüdür. Babası tarafından suikatçı olmak üzere eğitilen Shang-Chi aynı zamanda simya ve insanüstü güçlerle dövüş tekniklerini geliştirir. Babasının yıkıcı güçlere sahip biri olduğunu öğrenen Shang-Chi, güçlerini onun imparatorluğunu yıkmak için kullanacaktır. Babasının düşmanıyla dost olan kahraman, dünyayı gezecek ve birçok süper kahramanla yolları kesişecektir...", artwork: "Movie6"),
        
        Movie(movieTitle: "Joker", releaseDate: "4 Ekim 2019", movieTime: "2 Saat 2 Dakika", movieDescription: "Joker, başarısız bir komedyen olan Arthur Fleck'in hayatına odaklanıyor. Toplum tarafından dışlanan bir adam olan Arthur, hayatta yapayalnızdır. Sürekli bir bağ kurma arayışında olan Arthur, yaşamını taktığı iki maske ile geçirir. Gündüzleri, geçimini sağlamak için palyaço maskesini yüzüne takan Arthur, geceleri ise asla üzerinden silip atamayacağı bir maske takar. Babasız büyüyen Arthur’u en yakın arkadaşı olan annesi Happy adıyla çağırır. Bu lakap, Arthur’un içindeki acıyı gizlemesine yardımcı olur. Ancak maruz kaldığı zorbalıklar, onun gitgide toluma aykırı bir adam haline gelmesine neden olur. Yavaş yavaş psikolojik olarak tekinsiz sulara yelken açılan Arthur, bir süre sonra kendisini Gotham Şehri’nde suç ve kaosun içinde bulur. Arthur, zamanla kendi kimliğinden uzaklaşıp Joker karakterine bürünür.", artwork: "joker")
    ]
    
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Film"
    
    // MARK: Detail View Properties
    @State var detailMovie: Movie?
    @State var showDetailView: Bool = false
    // FOR MATCHED GEOMETRY EFFECT STORING CURRENT CARD SIZE
    @State var currentCardSize: CGSize = .zero
    
    // Environment Values
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            // BG
            BGView()
            
            // MARK: Main View Content
            VStack{
                
                // Custom Nav Nar
                NavBar()
                
                // Check out the Snap Carousel Video
                // Link in Description
                SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: movies) { movie in
                    
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        
                        
                        Image(movie.artwork)
                            .resizable()
                            .scaledToFill()
                          //  .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .onTapGesture {
                                currentCardSize = size
                                detailMovie = movie
                                withAnimation(.easeInOut){
                                    showDetailView = true
                                }
                            }
                        
                    }
                }
                .frame(height: 360)
                // Since Carousel is Moved The current Card a little bit up
                // Using Padding to Avoid the Undercovering the top element
                .padding(.top,60)
                
                // Custom Indicator
                CustomIndicator()
                
                HStack{
                    Text("Popüler")
                        .font(.title3.bold())
                    
                    Spacer()
                    
                    NavigationLink {
                        
                    } label: {
                        Button("Daha Fazlası"){}
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }

                  
                }
                .padding(.leading)
                .padding(.trailing)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15){
                        ForEach(movies){movie in
                            Image(movie.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                }
                Spacer()
             
            }
            .overlay {
                if let movie = detailMovie,showDetailView{
                    DetailView(movie: movie, showDetailView: $showDetailView, detailMovie: $detailMovie, currentCardSize: $currentCardSize, animation: animation)
                }
            }
        }
    }
    
    // MARK: Custom Indicator
    @ViewBuilder
    func CustomIndicator()->some View{
        HStack(spacing: 5){
            ForEach(movies.indices,id: \.self){index in
                Circle()
                    .fill(currentIndex == index ? .purple : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    // MARK: Custom Nav Bar
    @ViewBuilder
    func NavBar()->some View{
        HStack(spacing: 0){
            ForEach(["Film","Dizi"],id: \.self){tab in
                Button {
                    withAnimation{
                        currentTab = tab
                    }
                } label: {
                 
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background{
                            if currentTab == tab{
                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }
            }
        }
        .padding()
    }
    
    // MARK: Blurred BG
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                ForEach(movies.indices,id: \.self){index in
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color: Color = (scheme == .dark ? .black : .white)
            // Custom Gradient
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
         //   .preferredColorScheme(.dark)
    }
}
