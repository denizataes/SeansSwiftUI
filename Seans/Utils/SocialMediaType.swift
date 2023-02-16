//
//  SocialMediaType.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.02.2023.
//

import Foundation

enum SocialMediaType: Int, CaseIterable{
    case instagram
    case twitter
    case snapchat
    case youtube
    case tiktok
    
    var imageName: String{
        switch self{
        case .instagram: return "instagram"
        case .twitter: return "twitter"
        case .snapchat: return "snapchat"
        case .tiktok: return "tiktok"
        case .youtube: return "youtube"
        }
        
    }
}
