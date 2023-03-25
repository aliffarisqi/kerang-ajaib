//
//  ViewFlower.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//
import SwiftUI
struct ViewFlowerPagePlay: View{
    //FLOWER PAGE 3
    @State private var p3RotationFlowerAngle1: Double = 0.0
    @State private var p3RotationFlowerAngle2: Double = 0.0
    @State private var p3RotationFlowerAngle3: Double = 0.0
    @State private var p3RotationFlowerAngle4: Double = 0.0
    @State private var p3RotationFlowerAngle5: Double = 0.0
    @State private var p3FlowerScale1:CGFloat = 1.0
    @State private var p3IsAnimateFlower1: Bool = false
    @State private var p3IsAnimateFlower2: Bool = false
    @State private var p3IsAnimateFlower3: Bool = false
    @State private var p3IsAnimateFlower4: Bool = false
    @State private var p3IsAnimateFlower5: Bool = false
    
    var body: some View{
        VStack{
            HStack{
                Image("Flower-1")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(p3IsAnimateFlower1 ? Color.green.opacity(0.5) : Color.cyan.opacity(0.2))
                    .frame(width: 200)
                    .rotationEffect(.degrees(p3RotationFlowerAngle1))
                    .onTapGesture{
                        withAnimation(
                            .linear(duration: 1)
                            .speed(0.05)
                            .repeatForever(autoreverses: false)) {
                                p3RotationFlowerAngle1 = -360
                                p3IsAnimateFlower1.toggle()
                            }
                    }
                Spacer()
                Image("Flower-2")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundColor(p3IsAnimateFlower2 ? Color.blue.opacity(0.3) : Color.green.opacity(0.4))
                    .rotationEffect(.degrees(p3RotationFlowerAngle2))
                    .scaleEffect(p3FlowerScale1)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 1).speed(0.08)) {
                            p3RotationFlowerAngle2 = p3IsAnimateFlower2 ? -360 : 0.0
                            p3IsAnimateFlower2.toggle()
                        }
                    }
                    .offset(x: 40, y:20)
            }
            HStack{
                ZStack{
                    Image("Flower-1")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(p3RotationFlowerAngle3))
                        .frame(width: p3IsAnimateFlower3 ? 210 : 150)
                        .position(x: 30, y: 90)
                        .foregroundColor(p3IsAnimateFlower3 ? Color.purple.opacity(0.3) : Color.yellow.opacity(0.5))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5,
                                                  dampingFraction: 0.3,
                                                  blendDuration: 1)) {
                                p3RotationFlowerAngle3 = !p3IsAnimateFlower3 ? -360.0 : 0.0
                                p3IsAnimateFlower3.toggle()
                            }
                        }
                    
                    Spacer()
                    Image("Flower-1")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundColor(p3IsAnimateFlower4 ? Color.green.opacity(0.3) : Color.orange.opacity(0.3))
                        .rotationEffect(.degrees(p3RotationFlowerAngle4))
                        .position(x: 90, y: 260)
                        .onTapGesture{
                            withAnimation(
                                .linear(duration: 1)
                                .speed(0.09)
                                .repeatForever(autoreverses: false)) {
                                    p3RotationFlowerAngle4 = -360
                                    p3IsAnimateFlower4.toggle()
                                }
                            
                        }
                    Spacer()
                    Image("Flower-1")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(p3RotationFlowerAngle5))
                        .frame(width: p3IsAnimateFlower5 ? 170 : 100)
                        .position(x: 300, y: 140)
                        .foregroundColor(p3IsAnimateFlower5 ? Color.pink.opacity(0.3) : Color.purple.opacity(0.3))
                        .onTapGesture {
                            withAnimation(.spring(response: 2,
                                                  dampingFraction: 0.2,
                                                  blendDuration: 1)) {
                                p3RotationFlowerAngle5 = !p3IsAnimateFlower5 ? -360.0 : 0.0
                                p3IsAnimateFlower5.toggle()
                            }
                        }
                }
                
                    
            }
            .padding(0)
            Spacer()
        }
    }
}

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
//        ViewFlower()
        ViewFlowerPagePlay()
    }
}
