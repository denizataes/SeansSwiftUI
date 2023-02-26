//
//  CustomLoadingView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.02.2023.
//

import SwiftUI

struct CustomLoadingView: View {
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Image(systemName: "popcorn")
                    .font(.system(size: 30))
                    .rotationEffect(Angle(degrees: rotationAngle))
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
                    .foregroundColor(Color(.systemPurple))
            }
        }
        .onAppear {
            rotationAngle = 360
        }
    }
}
