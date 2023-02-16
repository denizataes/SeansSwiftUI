//
//  SocialMediaTextView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.02.2023.
//

import SwiftUI

struct SocialMediaTextView: View {
    @State var text: String = ""
    var socialMediaName: SocialMediaType
    var body: some View {
        HStack {
            Image(socialMediaName.imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
            
            TextFieldWrapper(text: $text, placeholder: "\(socialMediaName.imageName.prefix(1).capitalized + socialMediaName.imageName.dropFirst()) Kullanıcı Adı")
                .textContentType(.emailAddress)
            .border(1, Color(.systemPurple).opacity(0.5))                    }
    }
}

struct SocialMediaTextView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaTextView(socialMediaName: SocialMediaType.twitter)
        
    }
}

struct TextFieldWrapper: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
               if let text = textField.text,
                  let textRange = Range(range, in: text) {
                   var updatedText = text.replacingCharacters(in: textRange, with: string)
                   
                   if updatedText.isEmpty {
                       self.text = updatedText
                       return true
                   }
                   
                   if !updatedText.hasPrefix("@") {
                       updatedText = "@\(updatedText)"
                   }
                   
                   textField.text = updatedText
                   self.text = updatedText
                   
                   return false
               }
               
               return true
           }
    }
}
