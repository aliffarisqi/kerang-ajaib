//
//  ContentView.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 18/03/23.
//

import AVFoundation
import Foundation
import SwiftUI
import Speech
import AVKit


struct ContentView: View {
    let items = Array(1...6)
    let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
    @State var rotationFlowerAngle1: Double = 0.0
    @State var rotationFlowerAngle2: Double = 0.0
    @State var flowerScale1:CGFloat = 1.0
    @State var isAnimateFlower1: Bool = false
    
    let gradientColor = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom)
    
    @State private var currentIndex = 0
    @State private var currentIndexBg = -1
    @State private var showText1 = false
    @State private var showText2 = false
    @State private var showText3 = false
    @State private var showText4 = false
    @State private var rotationAngle: Double = 0.0
    @State private var rotationAngle1: Double = 60.0
    @State private var offset: CGSize = CGSize(width: 0, height: 0)
    @State private var splashText: Bool = false
    @State private var splashLogo: Bool = false
    @State private var splashButton: Bool = false
    @State private var hideSplashScreen: Bool = false
    @State private var showLogoShadow: Bool = false
    
    @State private var showButton : Bool = false
    @State private var showLogo2 : Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack {
                    VStack{
                        HStack{
                            Image("Flower-1")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.cyan.opacity(0.15))
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
                    //Splash screen
                    VStack{
                        Image("TextLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .opacity(hideSplashScreen ? 0 : 1)
                            .scaleEffect(splashText ? 1 : 0)
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                    withAnimation(.easeInOut(duration: 1)) {
                                        splashText = true
                                    }
                                }
                            }
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 215)
                            .opacity(hideSplashScreen ? 0 : 1)
                            .scaleEffect(splashLogo ? 1 : 0)
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                    withAnimation(.easeInOut(duration: 1)) {
                                        splashLogo = true
                                    }
                                }
                            }
                        Button(action: {
                            withAnimation {
                                hideSplashScreen = true
                                callTimer()
                            }
                        }, label:{
                            Text("Jelajahi Legenda \nKerang Ajaib")
                                .opacity(hideSplashScreen ? 0 : 1)
                                .foregroundColor(.white)
                                .shadow(radius: 50)
                                .font(.custom("Blob Spongey Lowercase", size: 30))
                                .scaleEffect(splashButton ? 1 : 0)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                                        withAnimation(.easeInOut(duration: 1)) {
                                            splashButton = true
                                        }
                                    }
                                    
                                }
                        })
                        
                        NavigationLink(destination: ViewPage2(), label:{
                            Text("Atau Lewati")
                                .padding()
                                .opacity(hideSplashScreen ? 0 : 1)
                                .scaleEffect(splashButton ? 1 : 0)
                                .font(.custom("Blob Spongey Lowercase", size: 18))
                                .foregroundColor(Color.white)
                                .underline()
                        })
                    }.padding(.vertical, 150)
                    //End of splash screen
                    // Start Story time
                    if hideSplashScreen == true{
                        VStack(spacing:30){
                            HStack{
                                Text("Dahulu kala terdapat sebuah kerang ajaib yang dipuja-puja segala bangsa...")
                                    .font(.custom("Blob Spongey Lowercase", size: 20))
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(10)
                                    .foregroundColor(.white)
                                    .opacity(showText1 ? 1 : 0)
                                    .frame(height: 200)
                                Image("Flower-4")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                                    .rotationEffect(.degrees(rotationAngle), anchor: .center)
                                    .offset(y:30)
                                    .onAppear {
                                        withAnimation(
                                            .linear(duration: 1)
                                            .speed(0.02).repeatForever(autoreverses: false)) {
                                                rotationAngle = 360.0
                                            }
                                    }
                            }.padding(.horizontal, 20)
                            Image("LogoShadow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                                .scaleEffect(showLogoShadow ? 1 : 0)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                        withAnimation(.easeInOut(duration: 1)) {
                                            showLogoShadow = true
                                        }
                                    }
                                    
                                }
                            HStack{
                                Image("Flower-2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                                    .rotationEffect(.degrees(rotationAngle1), anchor: .center)
                                    .offset(x:-70)
                                    .onAppear {
                                        withAnimation(
                                            .linear(duration: 1)
                                            .speed(0.02)
                                            .repeatForever(autoreverses: false)) {
                                                rotationAngle1 = -360.0
                                            }
                                    }
                                VStack{
                                    Text("Segala masalah dapat dipecahkan oleh kerang ajaib…")
                                        .font(.custom("Blob Spongey Lowercase", size: 20))
                                        .multilineTextAlignment(.leading)
                                        .lineSpacing(10)
                                        .foregroundColor(.white)
                                        .padding(.bottom)
                                        .offset(x:-70)
                                        .opacity(showText2 ? 1 : 0)
                                        .onAppear {
                                            Timer.scheduledTimer(withTimeInterval:5, repeats: false) { _ in
                                                withAnimation(.easeInOut(duration: 1)) {
                                                    self.showText2 = true
                                                }
                                            }
                                        }
                                    Text("Namun segalanya berubah ketika kerang ajaib menghilang…")
                                        .font(.custom("Blob Spongey Lowercase", size: 20))
                                        .multilineTextAlignment(.leading)
                                        .lineSpacing(10)
                                        .foregroundColor(.white)
                                        .opacity(showText2 ? 1 : 0)
                                        .padding(.trailing, 35)
                                }.frame(height: 250)
                            }
                            HStack{
                                Text("Ratusan tahun berlalu dan kini kerang ajaib kembali menampakkan dirinya di GOP 9")
                                    .font(.custom("Blob Spongey Lowercase", size: 20))
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(10)
                                    .foregroundColor(.white)
                                    .opacity(showText3 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText3 = true
                                            }
                                        }
                                    }.padding(.leading, 35)
                                Image("Flower-1")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.25)
                                    .frame(width: 100)
                                    .rotationEffect(.degrees(rotationAngle), anchor: .center)
                                    .offset(x:60)
                                    .onAppear {
                                        withAnimation(
                                            .linear(duration: 1)
                                            .speed(0.02)
                                            .repeatForever(autoreverses: false)) {
                                                rotationAngle = 360.0
                                            }
                                    }
                            }.padding()
                            HStack{
                                Image("Flower-5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                                    .opacity(0.35)
                                    .rotationEffect(.degrees(rotationAngle1), anchor: .center)
                                    .offset(y:-30)
                                    .onAppear {
                                        withAnimation(
                                            .linear(duration: 1)
                                            .speed(0.02)
                                            .repeatForever(autoreverses: false)) {
                                                rotationAngle1 = -360.0
                                            }
                                    }
                                Text("Apakah kamu siap untuk kembali memuja Sang Kerang Ajaib?")
                                    .padding()
                                    .font(.custom("Blob Spongey Lowercase", size: 20))
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(10)
                                    .foregroundColor(.white)
                                    .opacity(showText4 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText4 = true
                                            }
                                        }
                                    }.padding(.trailing, 25)
                            }
                            NavigationLink(destination: ViewPage2(), label:{
                                Text("PUJA KERANG AJAIB")
                                    .padding()
                                    .background(.white)
                                    .font(.custom("Blob Spongey Lowercase", size: 16))
                                    .cornerRadius(10)
                                    .shadow(radius: 8)
                                    .scaleEffect(showButton ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                showButton = true
                                            }
                                        }
                                    }
                            })
                            
                            ZStack{
                                Image("Ground")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y:39)
                                Image("Rock")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y:40)
                                Image("Logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:200)
                                    .offset(y:-40)
                                    .scaleEffect(showLogo2 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 18, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                showLogo2 = true
                                            }
                                        }
                                    }
                            }
                        }
                        .offset(y: CGFloat(currentIndex) * -180)
                        .onReceive(timer) { _ in
                            withAnimation {
                                if currentIndex < 3 {
                                    currentIndex = (currentIndex + 1) % items.count
                                    currentIndexBg = (currentIndexBg + 1) % items.count
                                }
                            }
                        }
                        //End of VStack Story Time
                    }
                }
            }.scrollDisabled(true)
            .background(
                Image("Ocean")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .offset(y: CGFloat(currentIndexBg) * -180)
                
            
            )
            
        }
    }
    
    func callTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 1)) {
                self.showText1 = true
            }
        }
        
        timer.fire()
        timer.invalidate()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
