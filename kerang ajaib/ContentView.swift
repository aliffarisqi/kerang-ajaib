//
//  ContentView.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 18/03/23.
//

import SwiftUI

struct ContentView: View {
    let items = Array(1...6)
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    //every: durasinya
    
    @State private var currentIndex = 0
    @State private var showText1 = false
    @State private var showText2 = false
    @State private var showText3 = false
    @State private var showText4 = false
    @State private var rotationAngle: Double = 0.0
    
    var body: some View {
        ZStack {

            VStack{
                ForEach(0..<3) { index in
                    Image("Flower-1")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    
//                                .rotationEffect(.degrees(rotationAngle))
//                                .onAppear {
//                                    withAnimation(Animation.linear(duration: 10.0).repeatForever(autoreverses: false)) {
//                                        rotationAngle = 360.0
//                                    }
//                                }
                    Image("Flower-2")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                }
            }.edgesIgnoringSafeArea(.all)
            VStack{
                HStack(spacing:275){
                    Text("Skip")
                    Image(systemName: "speaker.slash") //speaker.wave.2
                }
                ScrollView {
                    ZStack{
                        Image("Ocean")
                            .resizable()
                        VStack(spacing:40) {
                            VStack{
                                HStack{
                                    Image("Flower-1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120)
                                        .offset()
                                    Image("Flower-2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120)
                                }
                                Image("TextLogo")
                                    .resizable()
                                    .scaledToFit()
                                Image("Logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:150)
                                Text("Jelajahi Legenda Kerang Ajaib")
                                Text("Atau Lewati")
                            }
                            HStack{
                                Text("Dahulu kala terdapat sebuah kerang ajaib yang dipuja-puja segala bangsa")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText1 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText1 = true
                                            }
                                        }
                                    }
                                Image(systemName: "camera").frame(width: 150)
                            }.frame(height: 150)
                            HStack{
                                Image(systemName: "camera")
                                    .frame(width: 150)
                                Text("Segala masalah dapat dipecahkan kerang ajaib, namun segalanya berubah ketika kerang ajaib tiba-tiba menghilang")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText2 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 11, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText2 = true
                                            }
                                        }
                                    }
                            }.frame(height: 170)
                            HStack{
                                Text("Ratusan tahun berlalu dan kini kerang ajaib kembali menampakkan dirinya di GOP 9")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText3 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText3 = true
                                            }
                                        }
                                    }
                                Image(systemName: "camera")
                                    .frame(width: 150)
                            }.frame(height: 150)
                            HStack{
                                Image(systemName: "camera")
                                    .frame(width: 150)
                                Text("Apakah kamu siap untuk kembali memuja kerang ajaib?")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .opacity(showText4 ? 1 : 0)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 19, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 1)) {
                                                self.showText4 = true
                                            }
                                        }
                                    }
                            }.frame(height: 150)
                            Button("Ready"){
                                
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: CGFloat(currentIndex) * -200) // -angka yg spacenya
                        .onReceive(timer) { _ in
                            withAnimation {
                                if currentIndex < 5 {
                                    currentIndex = (currentIndex + 1) % items.count
                                }
                            }
                    }
                    }
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
