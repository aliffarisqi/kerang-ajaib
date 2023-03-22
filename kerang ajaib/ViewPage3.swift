//
//  ViewPage3.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//

import SwiftUI

struct ViewPage3: View {
    @State var rotationFlowerAngle1: Double = 0.0
    @State var rotationFlowerAngle2: Double = 0.0
    @State var flowerScale1:CGFloat = 1.0
    @State var isAnimateFlower1: Bool = false
    
    @State var offset = CGSize.zero
    @State var lastDragPosition: DragGesture.Value?
    @State private var lineMoveCoordinate = CGPoint(x: 235, y: 275)
    
    var body: some View {
        ZStack{
            Image("Ocean")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .transition(AnyTransition.slide.animation(.easeIn))
            VStack{
                Spacer(minLength: 100)
                Image("TextLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                Image("Kerang")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.vertical, 30)
                    .padding(.top)
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(
                            Color.white.opacity(0.5)
                        )
                        .frame(maxWidth: .infinity, minHeight: 400)
                        .cornerRadius(50)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Spacer()
                        Rectangle()
                            .fill(
                                Color.white
                            )
                            .frame(width: 320, height: 200)
                            .cornerRadius(25)
                        Spacer()
                        Image(systemName: "mic.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.blue)
                            .padding(20)
                            .background(
                                Color.white.opacity(0.4)
                                    .cornerRadius(50)
                            )
                        Spacer()
                    }
                    .padding()
                }
            }
            Path { path in
                path.move(to: CGPoint(x: 230, y:280))
                path.addLine(to: lineMoveCoordinate)
            }
            .stroke(Color.gray, style: StrokeStyle(lineWidth: 7, lineCap: .round, dash: [7]))
                        Image("Tuas")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40.0)
                            .position(x:240,y: 270)
                            .offset(offset)
                            .gesture(DragGesture(minimumDistance: 1)
                                .onChanged({ value in
                                    self.offset = value.translation
                                    self.lastDragPosition = value
                                    self.lineMoveCoordinate = value.location
                                })
                                    .onEnded({value in
                                        withAnimation(.spring(response: 2.0,
                                                              dampingFraction: 0.7,
                                                              blendDuration: 1.0)) {
                                            self.offset = CGSize.zero
                                            self.lineMoveCoordinate = CGPoint(x: 235, y: 275)
                                        }
                                    })
            
                            )
        }
        .transition(AnyTransition.slide.animation(.easeIn))
    }
}

struct ViewPage3_Previews: PreviewProvider {
    static var previews: some View {
        ViewPage3()
    }
}
