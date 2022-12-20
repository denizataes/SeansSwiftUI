import Foundation


enum SearchFilterViewModel: Int, CaseIterable{
    
    case users
    case films
    case actors
    
    var title: String{
        switch self {
        case .users: return "Kullanıcı"
        case .films: return "Film"
        case .actors : return "Aktör"
        
        }
    }
}
