//
//  ViewFlower.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//
import SwiftUI

struct ViewFlower: View {
    @State var rotationFlowerAngle1: Double = 0.0
    @State var rotationFlowerAngle2: Double = 0.0
    @State var flowerScale1:CGFloat = 1.0
    @State var isAnimateFlower1: Bool = false
    
    let gradientColor = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom)
    
    var body: some View{
        VStack{
            HStack{
                Image("Flower-1")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.cyan.opacity(0.5))
                    .frame(width: 200)
                    .rotationEffect(.degrees(rotationFlowerAngle1))
                    .onAppear{
                        withAnimation(
                            .linear(duration: 1)
                            .speed(0.05)
                            .repeatForever(autoreverses: false)) {
                                rotationFlowerAngle1 = -360
                            }
                    }
                Spacer()
                Image("Flower-2")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundColor(isAnimateFlower1 ? Color.accentColor.opacity(0.4) : Color.yellow.opacity(0.7))
                    .rotationEffect(.degrees(rotationFlowerAngle2))
                    .scaleEffect(flowerScale1)

                    .onAppear{
                        withAnimation(
                            .linear(duration: 1)
                            .speed(0.05)
                            .repeatForever(autoreverses: false)) {
                                rotationFlowerAngle2 = 360
                            }
                    }
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 1)) {
                            isAnimateFlower1.toggle()
                        }
                    }
                    .offset(x: 40, y:20)
            }
            HStack{
                Image("Flower-1")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(Color.yellow.opacity(0.6))
                    .offset(x: -50)
                Spacer()
                Image("Flower-1")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(Color.purple.opacity(0.4))
                    .offset(y: 50)
                    
            }
            .padding(0)
            Spacer()
        }
    }
}

struct ViewFlower_Previews: PreviewProvider {
    static var previews: some View {
        ViewFlower()
    }
}
