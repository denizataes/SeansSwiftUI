//
//  Application.swift
//  Seans
//
//  Created by Deniz Ata Eş on 17.02.2023.
//

import SwiftUI

final class ApplicationUtility{
    
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
