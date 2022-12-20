//
//  BlurView.swift
//  BottomSheetNew (iOS)
//
//  Created by Balaji on 23/05/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
