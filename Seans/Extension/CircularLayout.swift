import SwiftUI

struct MiniCircle : View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 24,height: 24)
            .scaledToFill()
            .clipShape(Circle())
            .shadow(radius: 5)
           
            
    }
}

struct CircularLayout : View {
    var radius: CGFloat;
    var name: [String];
    var body: some View {
        let angle = 1.0 / CGFloat(self.name.count) * .pi
        return ZStack {
            ForEach((0...self.name.count-1), id: \.self) { index in
                MiniCircle(imageName: name[index])
                    .position(x: self.radius + cos(angle * CGFloat(index) + .pi/3) * self.radius, y: self.radius - sin(angle * CGFloat(index) + .pi/3) * self.radius)
                    .animation(Animation.easeOut(duration: 0.6).delay(0.1))
            }
        }

    }
}
