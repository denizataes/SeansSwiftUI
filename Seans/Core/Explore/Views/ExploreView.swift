//
//  ExploreView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct ExploreView: View {
    @State var searchText: String = ""
    @State private var selectedFilter: SearchFilterViewModel  = .films
    @Namespace var animation
    
    var movies: [Movie] = [
        
        Movie(movieTitle: "Godfather", releaseDate: "1972", movieTime: "2 Saat 55 Dakika", movieDescription: "Baba, 40’lar ve 50’lerin Amerika’sında, bir İtalyan mafya ailesinin destansı öyküsünü konu alıyor. Don Corleone’nin kızı Connie’nin düğününde, ailenin en küçük oğlu ve bir savaş gazisi olan Michael babasıyla barışır. Bir suikast girişimi, Don’u artık işleri yönetemeyecek duruma düşürünce, ailenin başına Michael ve ağabeyi Sonny geçer. Danışmanları Tom Hagen’in de yardımlarıyla diğer ailelere savaş açan Corleone ailesi, eski moda yöntemleri de değiştirmeye başlar.", artwork: "godfather"),
        
        Movie(movieTitle: "Ad Astra", releaseDate: "2019", movieTime: "2 Saat 4 Dakika", movieDescription: "Yıldızlara Doğru, astronot Roy McBride'ın gerçekleştirdiği uzay yolculuğunu konu ediyor. Astronot Roy McBride’nın babası, 20 yıl önce uzayda hayat olup olmadığını araştırmakla görevlendirilmiştir. Ancak bu görev sırasında kaybolan adamdan bir daha haber alınamaz. Kaybolan babasını galakside aramak isteyen Roy, gezegeni tehdit eden bir gizemi de çözmek amacıyla güneş sisteminin dışına yolculuk eder. Bu yolculuk Roy’un beklediğinde de farklı şeyler öğrenmesine neden olur. Yolculuk sayesinde astronot, insan varlığının doğasına ve kozmostaki yerimize meydan okuyan sırların ortaya çıkmasını sağlar.", artwork: "Movie1"),
        
        Movie(movieTitle: "Starwars", releaseDate: "2019", movieTime: "2 Saat 22 Dakika", movieDescription: "Kylo Ren, Büyük Lider Snoke'u öldürmesinin ardından İlk Düzen'in yeni Büyük Lider'i olmuştur. Acımasız yönetiminin altında galaksi yavaş yavaş umutsuzluğa kapılmaktadır. Luke Skywalker'ın Güç'le birleşmesinden sonra Rey kendi içindeki gücü benimsemiş, onu geçmişte tutan bağlarını kesmeyi başarmıştır.", artwork: "Movie2"),
        
        
        Movie(movieTitle: "Toy Story 4 ", releaseDate: "2019", movieTime: "1 Saat 40 Dakika", movieDescription: "Oyuncak Hikayesi 4, kaşıktan yapılma bir oyuncak olan Forky’nin atıldığı macerayı konu ediyor. Bir geri dönüşüm projesi ile yaratılan Forky, oyuncak olduğunu asla kabul etmez. Tek kullanımlık bir kaşıktan yapılma bir oyuncak olsa da o oyuncak olmadığı konusunda ısrarcıdır. Kendisini Bonnie’nin odasına ait hissetmeyen Forky, dünyadaki amacının ne olduğunu düşünmeye başlar. Kendisini oyuncaklardan biri olarak görmediği için Bonnie’nin yanında kalmak zorunda hissetmeyen Forky, dünyadaki amacını kaşık olarak yerine getirmeye karar verir. Ancak onun oyuncak olarak üstesinden gelmesi gereken bambaşka bir görevi vardır.", artwork: "Movie3"),
        
        
        Movie(movieTitle: "Lion King", releaseDate: "2019", movieTime: "1 Saat 58 Dakika", movieDescription: "Baba, 40’lar ve 50’lerin Amerika’sında, bir İtalyan mafya ailesinin destansı öyküsünü konu alıyor. Don Corleone’nin kızı Connie’nin düğününde, ailenin en küçük oğlu ve bir savaş gazisi olan Michael babasıyla barışır. Bir suikast girişimi, Don’u artık işleri yönetemeyecek duruma düşürünce, ailenin başına Michael ve ağabeyi Sonny geçer. Danışmanları Tom Hagen’in de yardımlarıyla diğer ailelere savaş açan Corleone ailesi, eski moda yöntemleri de değiştirmeye başlar.", artwork: "Movie4"),
        
        Movie(movieTitle: "Spider Man No Way Home", releaseDate: "2022", movieTime: "2 Saat 28 Dakika", movieDescription: "Örümcek-Adam Eve Dönüş Yok, kimliği açığa Örümcek-Adam'ın, sırrını geri vermesi için Doktor Strange'den yardım istemesiyle birlikte yaşananları konu ediyor. Örümcek-Adam'ın kimliği ifşa edilerek onun ve sevdiklerinin hayatı, halkın gözü önüne serilir. Kendisini büyük bir kaosun ortasında bulan Peter, aynı zamanda suç ortakları olarak lanse edilen MJ ve Ned'in hayatının da olumsuz etkilenmesine şahit olur. Arkadaşların üniversiteye girme şanslarının yok olmasına seyirci kalmak istemeyen Peter, sırrını geri vermesi için Doktor Strange'den yardım ister. Peter'ın yakarışından etkilenip ona yardım etmeyi kabul eden Strange, Unutma Büyüsü'nü yapmaya başlar. Ancak bu büyü, MJ, Ned, May ve Happy'nin de Örümcek-Adam'ın kim olduğunu unutmasına neden olacaktır. Arkadaşlarının kim olduğunu hatırlamasını, diğer kişilerin unutmasını isteyen Peter, Strange büyüyü yaparken parametreleri değiştirir. Ancak bu durum beklenmedik olaylara neden olur.", artwork: "Movie5"),
        
        Movie(movieTitle: "Shang Chi", releaseDate: "2021", movieTime: "2 Saat 12 Dakika", movieDescription: "Shang-Chi and the Legend of the Ten Rings, babası tarafından suikastçı olmak üzere yetiştirilen Shang-Chi’nin hikayesini konu ediyor. Shang-Chi'nin babası ölümsüz bir büyücüdür. Babası tarafından suikatçı olmak üzere eğitilen Shang-Chi aynı zamanda simya ve insanüstü güçlerle dövüş tekniklerini geliştirir. Babasının yıkıcı güçlere sahip biri olduğunu öğrenen Shang-Chi, güçlerini onun imparatorluğunu yıkmak için kullanacaktır. Babasının düşmanıyla dost olan kahraman, dünyayı gezecek ve birçok süper kahramanla yolları kesişecektir...", artwork: "Movie6"),
        
        Movie(movieTitle: "Joker", releaseDate: "2019", movieTime: "2 Saat 2 Dakika", movieDescription: "Joker, başarısız bir komedyen olan Arthur Fleck'in hayatına odaklanıyor. Toplum tarafından dışlanan bir adam olan Arthur, hayatta yapayalnızdır. Sürekli bir bağ kurma arayışında olan Arthur, yaşamını taktığı iki maske ile geçirir. Gündüzleri, geçimini sağlamak için palyaço maskesini yüzüne takan Arthur, geceleri ise asla üzerinden silip atamayacağı bir maske takar. Babasız büyüyen Arthur’u en yakın arkadaşı olan annesi Happy adıyla çağırır. Bu lakap, Arthur’un içindeki acıyı gizlemesine yardımcı olur. Ancak maruz kaldığı zorbalıklar, onun gitgide toluma aykırı bir adam haline gelmesine neden olur. Yavaş yavaş psikolojik olarak tekinsiz sulara yelken açılan Arthur, bir süre sonra kendisini Gotham Şehri’nde suç ve kaosun içinde bulur. Arthur, zamanla kendi kimliğinden uzaklaşıp Joker karakterine bürünür.", artwork: "joker")
    ]
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding()
            
            searchFilterBar
            
            ScrollView{
                LazyVStack(spacing: 0){
                    ForEach(movies){movie in
                        NavigationLink {
                            
                            if(selectedFilter == .users){
                                ProfileView()
                            }
                            else{
                                FilmInfoView()
                            }
                          
                        } label: {
                            if(selectedFilter == .users){
                                UserRowView()
                            }
                            else{
                                FilmSearchRowView(movie: movie)
                            }
                        }
                        

                    }
                    
                }
            }
        }

    }
}

struct ExploreView_Previews: PreviewProvider {
    @Binding var searchText: String
    
    static var previews: some View {
        ExploreView(searchText: "")
    }
}

extension ExploreView{
    
    var searchFilterBar: some View{
        HStack{
            
            ForEach(SearchFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("mode") : .gray)
                    
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.systemPurple))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
}
