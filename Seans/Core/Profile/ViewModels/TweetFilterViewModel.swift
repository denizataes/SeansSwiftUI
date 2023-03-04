import Foundation


enum TweetFilterViewModel: Int, CaseIterable{
    
    case feeds
    case favourites
    
    var title: String{
        switch self {
        case .feeds: return "Gönderiler"
        case .favourites: return "Beğeniler"
        
        }
    }
}
