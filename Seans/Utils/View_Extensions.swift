//
//  View_Extensions.swift
//  SocialMediaApp
//
//  Created by Deniz Ata Eş on 13.02.2023.
//

import SwiftUI

extension View{
    
    // Closing All Active Keyboards
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //MARK: Disabling with Opacity
    func disableWithOpacity(_ condition: Bool) -> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ alignment: Alignment) -> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
            
        
    }
    
    func vAlign(_ alignment: Alignment) -> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
        
    }
    
    
    //MARK: Custom Border View Width Padding
    
    func border(_ width: CGFloat, _ color: Color) -> some View{
        
        self.padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    // MARK: Custom fill View With Padding
    func fillView(_ color: Color) -> some View{
        
        self.padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(color)
            }
    }
}
