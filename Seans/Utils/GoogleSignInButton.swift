//import SwiftUI
//import GoogleSignIn
//import Foundation
//import Firebase
//import GoogleSignInSwift
//// Button
//struct GoogleSignInButton: UIViewRepresentable {
//    func makeUIView(context: Context) -> GIDSignInButton {
//        return GIDSignInButton()
//    }
//
//    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
//    }
//}
//
//// Sign-In flow UI of the provider
//struct GoogleLogin: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<GoogleLogin>) -> UIView {
//        return UIView()
//    }
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GoogleLogin>) {
//    }
//
//    func attemptLoginGoogle() {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let sceneDelegate = windowScene.delegate as? SceneDelegate,
//              let presentingViewController = sceneDelegate.window?.rootViewController else {
//            return
//        }
//        GIDSignIn.sharedInstance.signIn(with: presentingViewController)
//    }
//
//    func signOutGoogleAccount() {
//        GIDSignIn.sharedInstance.signOut()
//    }
//
//
//}
