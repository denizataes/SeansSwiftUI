//
//  LoadingView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 12.02.2023.
//

import SwiftUI

struct LoadingView: View {
    @Binding var show: Bool
    
    var body: some View {
        if show{
            ZStack{
                Group{
                    Rectangle()
                        .fill(Color(.systemBackground).opacity(0.7))
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(.systemPurple)))
                        .padding(15)
                        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: show)
        }
    }
}
