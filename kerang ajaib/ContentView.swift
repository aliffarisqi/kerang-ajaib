//
//  ContentView.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 18/03/23.
//

import SwiftUI

struct ContentView: View {
    let items = Array(1...6)
    let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
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
                            Text("Jelajahi Legenda Kerang Ajaib")
                                .font(.title3)
                                .opacity(hideSplashScreen ? 0 : 1)
                                .scaleEffect(splashButton ? 1 : 0)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                                        withAnimation(.easeInOut(duration: 1)) {
                                            splashButton = true
                                        }
                                    }
                                    
                                }
                        })
                        
                        NavigationLink(destination: ViewPage3(), label:{
                            Text("Atau Lewati")
                                .padding()
                                .opacity(hideSplashScreen ? 0 : 1)
                                .scaleEffect(splashButton ? 1 : 0)
                        })
                    }.padding(.vertical, 150)
                    //End of splash screen
                    // Start Story time
                    if hideSplashScreen == true{
                        VStack(spacing:30){
                            HStack{
                                Text("Dahulu kala terdapat sebuah kerang ajaib yang dipuja-puja segala bangsa...")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText1 ? 1 : 0)
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
                            }
                            Image("LogoShadow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                                .scaleEffect(showLogoShadow ? 1 : 0)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
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
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .padding(.bottom)
                                        .offset(x:-70)
                                        .opacity(showText2 ? 1 : 0)
                                        .onAppear {
                                            Timer.scheduledTimer(withTimeInterval:8, repeats: false) { _ in
                                                withAnimation(.easeInOut(duration: 1)) {
                                                    self.showText2 = true
                                                }
                                            }
                                        }
                                    Text("Namun segalanya berubah ketika kerang ajaib menghilang…")
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .opacity(showText2 ? 1 : 0)
                                }.frame(height: 250)
                            }
                            HStack{
                                Text("Ratusan tahun berlalu dan kini kerang ajaib kembali menampakkan dirinya di GOP 9")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText3 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 12, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText3 = true
                                            }
                                        }
                                    }
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
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText4 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText4 = true
                                            }
                                        }
                                    }
                            }
                            NavigationLink(destination: ViewPage2(), label:{
                                Text("PUJA KERANG AJAIB")
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 20)
                                    .scaleEffect(showButton ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 32, repeats: false) { _ in
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
                                    .offset(y:175)
                                Image("Rock")
                                    .resizable()
                                    .scaledToFit()
                                    .offset(y:175)
                                Image("Logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:200)
                                    .offset(y:75)
                                    .scaleEffect(showLogo2 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 25, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                showLogo2 = true
                                            }
                                        }
                                    }
                            }
                        }
                        .offset(y: CGFloat(currentIndex) * -200)
                        .onReceive(timer) { _ in
                                withAnimation {
                                    if currentIndex < 3 {
                                        currentIndex = (currentIndex + 1) % items.count
                                    }
                                }
                            }
                        //End of VStack Story Time
                    }
                }
            }.background(
                Image("Ocean")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
