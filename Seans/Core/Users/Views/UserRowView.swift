import SwiftUI
import Kingfisher

struct UserRowView: View {
    var user: User
    
    init(user: User){
        self.user = user
    }
    
    var body: some View {
        HStack(spacing: 12){
            KFImage(URL(string: user.userProfileURL))
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4){
                Text("\(user.firstName) \(user.lastName)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color("mode"))
                    
                Text("@\(user.userName)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading, spacing: 4){
                        Text("Takip")
                        Text("Takipçi")
                    }

                    
                    VStack(alignment: .trailing, spacing: 4){
                        Text("\(user.follow.count)")
                        Text("\(user.follower.count)")
                    }
                    .bold()
                }
                .font(.caption2)
                .foregroundColor(Color(.systemGray))
            }
            .foregroundColor(Color(.white))
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
