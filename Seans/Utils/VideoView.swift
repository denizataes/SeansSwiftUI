//
//  VideoView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 21.12.2022.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "\(Statics.youtubeURL)\(videoID)") else {return}
        uiView.scrollView.isScrollEnabled = false
        DispatchQueue.main.async {

            uiView.load(URLRequest(url: youtubeURL))
        }
    }
}
