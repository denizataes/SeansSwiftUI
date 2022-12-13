import Foundation


enum SearchFilterViewModel: Int, CaseIterable{
    
    case users
    case films
    case series
    
    var title: String{
        switch self {
        case .users: return "Kullanıcı"
        case .films: return "Film"
        case .series : return "Dizi"
        
        }
    }
}
