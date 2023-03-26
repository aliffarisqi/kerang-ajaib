//
//  ViewPage2.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//

import AVFoundation
import Foundation
import SwiftUI
import Speech
import AVKit


struct ViewPage2: View {
    
    @State var showKerangView: Bool = false
    @State var showTextFieldView: Bool = false
    @State var showMicView: Bool = false
    //INISIALISASI AUDIO
    @State var audioPlayerTarikTuas: AVAudioPlayer?
    
    var body: some View {
        ZStack{
//                ViewFlower()
            BackgroundViewObject()
            
            //            LAYER DEEP
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .foregroundColor(Color.black.opacity(0.4))
                .foregroundStyle(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                if showKerangView{
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .transition(AnyTransition.scale.animation(.easeInOut))
                    VStack{
                        Text("3/3")
                            .font(.custom("Blob Spongey Lowercase", size: 18))
                            .baselineOffset(4)
                            .kerning(1.5)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(Color.white)
                            .transition(AnyTransition.scale.animation(.easeInOut))
                        Text("setelah memasukkan pertanyaan, tarik tuas kerang ajaib untuk mendengar jawabannya. ")
                            .font(.custom("Blob Spongey Lowercase", size: 18))
                            .baselineOffset(4)
                            .kerning(1.5)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.yellow)
                            .padding()
                        HStack{
                            Button(action: {
                                playSound()
                                showKerangView.toggle()
                                showTextFieldView.toggle()
                            }, label:{
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundColor(Color.white.opacity(0.4))
                            })
                            Spacer()
                            NavigationLink(
                                destination: ViewPage3(),
                                label: {
                                    Text("Ask Now".uppercased())
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .padding(.horizontal, 10)
                                        .background(
                                            Capsule()
                                                .stroke(Color.white.opacity(0.3), lineWidth: 2.0)
                                        )
                                }
                            )
                        }
                        .padding(.horizontal)
                        
                    }
                    .padding()
                    .background(
                        Color.black.opacity(0.1)
                    )
                    .cornerRadius(25)
                    .padding(16)
                    .transition(AnyTransition.scale.animation(.easeInOut))
                    Spacer()
                } else if showTextFieldView {
                    VStack{
                        Text("2/3")
                            .font(.custom("Blob Spongey Lowercase", size: 18))
                            .baselineOffset(4)
                            .kerning(1.5)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(Color.white)
                        Text("selain dengan mikrofon, kamu juga bisa mengetik pertanyaan di bagian ini")
                            .font(.custom("Blob Spongey Lowercase", size: 18))
                            .baselineOffset(4)
                            .kerning(1.5)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.yellow)
                            .padding()
                        HStack{
                            Button(action: {
                                playSound()
                                showMicView.toggle()
                                showTextFieldView.toggle()
                            }, label:{
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundColor(Color.white.opacity(0.4))
                            })
                            Spacer()
                            Button(action: {
                                playSound()
                                showKerangView.toggle()
                                showTextFieldView.toggle()
                            }, label:{
                                Image(systemName: "arrow.right")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                                    .bold()
                            })
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(
                        Color.black.opacity(0.1)
                    )
                    .cornerRadius(25)
                    .padding(16)
                    .transition(AnyTransition.scale.animation(.easeInOut))
                    
                    //TEXT FIEELD
                    Rectangle()
                        .fill(
                            Color.white
                        )
                        .frame(width: 320, height: 200)
                        .cornerRadius(25)
                        .overlay(alignment: .topLeading, content: {
                            Text("ketik pertanyaan ...")
                                .offset(x:10, y:10)                                        .kerning(1.5)
                                .font(.custom("Blob Spongey Lowercase", size: 18))
                                .foregroundColor(Color.gray.opacity(0.5))
                                .offset(x:15, y:15)
                        })
                        .transition(AnyTransition.scale.animation(.easeInOut))
                    
                } else if !showMicView{
                    Spacer()
                    VStack{
                        Text("1/3")
                            .font(.custom("Blob Spongey Lowercase", size: 18))
                            .baselineOffset(4)
                            .kerning(1.5)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(Color.white)
                        VStack{
                            Text("tekan tombol mikrofon untuk memasukkan pertanyaan.")
                                .font(.custom("Blob Spongey Lowercase", size: 18))
                                .baselineOffset(4)
                                .kerning(1.5)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.yellow)
                                .padding(.bottom, 5)
                            Text(" pertanyaan harus berupa \n YES / NO question ")
                                .font(.custom("Blob Spongey Lowercase", size: 18))
                                .baselineOffset(4)
                                .kerning(1.5)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.yellow)
                        }.padding()
                       
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                playSound()
                                showTextFieldView.toggle()
                                showMicView.toggle()
                            }, label:{
                                Image(systemName: "arrow.right")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                                    .bold()
                            })
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(
                        Color.black.opacity(0.1)
                    )
                    .cornerRadius(25)
                    .padding(16)
                    .transition(AnyTransition.scale.animation(.easeInOut))
                    Image(systemName: "mic.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.blue)
                        .padding(20)
                        .background(
                            Color.white
                                .cornerRadius(50)
                        )
                        .padding(.bottom, 50)
                }
            }
            .navigationBarItems(trailing: ButtonMuteView())
        }
        .background(
            Image("Ocean")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
        .edgesIgnoringSafeArea(.all)
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "button2", withExtension: "mp3") else { return }
        do {
            audioPlayerTarikTuas = try AVAudioPlayer(contentsOf: url)
            audioPlayerTarikTuas?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct BackgroundViewObject: View{
    var body: some View{
        VStack{
            Spacer(minLength: 100)
            Image("TextLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 170)
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            Spacer()
            ZStack{
                Rectangle()
                    .fill(
                        Color.white.opacity(0.5)
                    )
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .cornerRadius(50)
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
            }
        }
    }
    
}

struct ViewPage2_Previews: PreviewProvider {
    static var previews: some View {
        ViewPage2()
    }
}
