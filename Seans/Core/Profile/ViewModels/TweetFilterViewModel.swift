import Foundation


enum TweetFilterViewModel: Int, CaseIterable{
    
    case feeds
    case favourites
    case statistics
    
    var title: String{
        switch self {
        case .feeds: return "Gönderiler"
        case .favourites: return "Favoriler"
        case .statistics : return "İstatistik"
        
        }
    }
}
