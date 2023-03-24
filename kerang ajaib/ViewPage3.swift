//
//  ViewPage3.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//

import SwiftUI
import AVFoundation
let synthesizer = AVSpeechSynthesizer()

struct LineTuaskerangAjaib: Shape {
    var endPoint: CGPoint
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(endPoint.x, endPoint.y) }
        set {
            endPoint.x = newValue.first
            endPoint.y = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: 135.0, y: -115.0)
        let end = CGPoint(x: endPoint.x ,
                          y: endPoint.y )
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}
struct ViewPage3: View {
    @State private var rotationFlowerAngle1: Double = 0.0
    @State private var rotationFlowerAngle2: Double = 0.0
    @State private var flowerScale1:CGFloat = 1.0
    @State private var isAnimateFlower1: Bool = false
    
    @State private var offset = CGSize.zero
    @State private var lastDragPosition: DragGesture.Value?
    @State private var lineMoveCoordinate = CGPoint(x: 135, y: -105)
    @State private var lineChange = false
    @State private var linePosition: CGPoint = .zero
    
    @State private var questionText: String = ""
    @State private var answerKerangAjaib: String = ""
    let answersKerangAjaib = ["Iya aja deh biar seneng",
                              "Yo ndak tau kok tanya saya",
                              "Mimpi aja",
                              "ya", "Mustahil lah", "Ga usah dipikirin, sirem taneman aja",
                              "tentu saja", "Jangan halu", "Pasrah aja",
                              "tentu saja tidak", "kamu nanya kamu bertanya tanya",
                              "kamu ngga tau ? Chuankss", "coba tanya bawah gue","Chuanksss", "apa kepentingan anda bertanya ?"]
    
    
    
    var body: some View {
        ZStack{
            Image("Ocean")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .transition(AnyTransition.slide.animation(.easeIn))
            VStack{
                Spacer(minLength: 80)
                Image("TextLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                Image("Kerang")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.vertical, 30)
                    .padding(.top, 0)
                Spacer(minLength: 50)
                ZStack{
                    Rectangle()
                        .fill(
                            Color.white.opacity(0.5)
                        )
                        .frame(maxWidth: .infinity, minHeight: 400)
                        .cornerRadius(50)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        ZStack{
                            Rectangle()
                                .fill(
                                    Color.white
                                )
                                .frame(width: 340, height: 200)
                                .cornerRadius(25)
                            
                            TextEditor(text: $questionText)
                                .frame(width: 310, height: 160)
                                .font(.custom("Blob Spongey Lowercase", size: 20))
                                .baselineOffset(4)
                                .kerning(1.5)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .overlay(alignment: .topLeading, content: {
                                    Text(questionText.isEmpty ? "ketik pertanyaan ..." : "")
                                        .offset(x:10, y:10)                                        .kerning(1.5)
                                        .font(.custom("Blob Spongey Lowercase", size: 18))
                                        .foregroundColor(Color.gray.opacity(0.5))
                                })
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 10)
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
            .padding(.bottom)
            LineTuaskerangAjaib(endPoint: lineChange ? lineMoveCoordinate : CGPoint(x: 140, y: -115))
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 7, lineCap: .round, dash: [7]))
                .frame(width: 200, height: 150)
            if answerKerangAjaib != ""{
                VStack{
                    Text("\(answerKerangAjaib)")
                        .font(.headline)
                        .baselineOffset(4)
                        .kerning(1.5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.yellow)
                        .padding()
                        .padding(.horizontal, 5)
                        .offset(x:0, y:5)
                }
                
                .background(
                    Color.black.opacity(0.3)
                )
                .cornerRadius(25)
                .overlay(alignment: .top, content: {
                    Image(systemName: "waveform")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color.white)
                    
                    .padding(.all, 4)
                        .background(
                            Color.black.opacity(0.3)
                        )
                        .cornerRadius(25)
                        .offset(x:0, y:-10)
                })
                .offset(x:0, y:-55)
                .transition(AnyTransition.scale.animation(.easeInOut))
                
            }
            Image("Tuas")
                .resizable()
                .scaledToFit()
                .frame(width: 40.0)
                .position(x:240,y: 235)
                .offset(offset)
                .gesture(DragGesture(minimumDistance: 1)
                    .onChanged({ value in
                        self.offset = value.translation
                        self.lastDragPosition = value
                        self.linePosition.x =  value.location.x
                        self.linePosition.y =  value.location.y
                        self.lineMoveCoordinate = CGPoint(x: self.linePosition.x - 100.0, y: self.linePosition.y - 360.0)
                        lineChange = true
                        self.answerKerangAjaib = ""
                    })
                        .onEnded({value in
                            withAnimation(.spring(response: 2,
                                                  dampingFraction: 0.5,
                                                  blendDuration: 1.0)) {
                                self.offset = CGSize.zero
                                lineChange = false
                                if questionIsApproval(){
                                    getAnswer()
                                } else{
                                    self.questionText = questionText
                                }
                            }
                            let utterance = AVSpeechUtterance(string: "\(answerKerangAjaib)")
                            utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
                            utterance.rate = 0.3
                            synthesizer.speak(utterance)
                        })
                )
        }
        .transition(AnyTransition.slide.animation(.easeIn))
    }
    func questionIsApproval() -> Bool {
        if self.questionText.count >= 1 {
            return true
        }
        return false
    }
    func getAnswer() {
        self.answerKerangAjaib = self.answersKerangAjaib.randomElement() ?? "Error"
    }
    
}

struct ViewPage3_Previews: PreviewProvider {
    static var previews: some View {
        ViewPage3()
    }
}
