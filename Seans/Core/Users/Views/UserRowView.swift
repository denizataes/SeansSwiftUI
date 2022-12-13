import SwiftUI


struct UserRowView: View {
    
    var body: some View {
        HStack(spacing: 12){
            Image("ugur")
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4){
                Text("Uğur Şahin")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color("mode"))
                    
                Text("@ugursahin")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
