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
    
    var body: some View {
        VStack{
            HStack(spacing:275){
                Text("Skip")
                Image(systemName: "speaker.slash") //speaker.wave.2
            }
            ScrollView {
                VStack(spacing:40) {
                    Image(systemName: "camera")
                        .frame(height:150)
                        .padding(.vertical, 300)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
