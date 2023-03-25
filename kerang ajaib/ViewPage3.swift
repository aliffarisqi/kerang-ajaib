//
//  ViewPage3.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//
import Foundation
import SwiftUI
import Speech
import AVKit
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
        let start = CGPoint(x: 135.0, y: -120.0)
        let end = CGPoint(x: endPoint.x ,
                          y: endPoint.y )
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}

struct ViewPage3: View {
    init(){
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    break
                case .denied:
                    break
                case .restricted:
                    break
                case .notDetermined:
                    break
                default:
                    break
                }
            }
        }
        recognitionTask?.cancel()
        self.recognitionTask = nil
    }
    
    
    // INISIALISASI TUAS DAN TALI
    @State private var offset = CGSize.zero
    @State private var lastDragPosition: DragGesture.Value?
    @State private var lineMoveCoordinate = CGPoint(x: 135, y: -105)
    @State private var lineChange = false
    @State private var linePosition: CGPoint = .zero
    
    //INISIALISASI TEXT TO SPEEXH
    @FocusState private var isFocused: Bool
    @State private var response = ""
    @FocusState private var responseIsFocussed: Bool // dismiss response editor keyboard when hit Return
    
    @State private var questionText: String = ""
    @State private var answerKerangAjaib: String = ""
    let answersKerangAjaib = ["Iya aja deh biar seneng",
                              "Yo ndak tau, kok tanya saya",
                              "Mimpi aja", "Chuanksss",
                              "ya", "Mustahil lah", "Ga usah dipikirin, sirem taneman aja", "Chuankksss",
                              "tentu saja", "Jangan halu", "Pasrah aja",
                              "tentu saja tidak", "kamu nanya, kamu bertanya tanya", "iya", "tidak", "yoo ndak tau",
                              "kamu ngga tau ? Chuankss", "Chuanksss", "apa kepentingan anda bertanya ?", "kamu nenyee", "rrauww"]
    
    //INISIALISASI SPEECH TO TEXT
    @State private var isRecording:Bool = false
    @State private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var authStat = SFSpeechRecognizer.authorizationStatus()
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()
    @State private var outputText:String = "";
    
    @State private var audioSession: AVAudioSession!
    @State private var inputNode: AVAudioInputNode!
    
    @State var placeholderQuestion = "ketik pertanyaan ..."
    
    var body: some View {
        ZStack{
            Image("Ocean")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .transition(AnyTransition.slide.animation(.easeIn))
            ViewFlowerPagePlay()
            VStack{
                Spacer(minLength: 80)
                Image("TextLogo3d")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                
                Spacer(minLength: 300)
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
                                    Text(questionText.isEmpty ? placeholderQuestion : "")
                                        .offset(x:10, y:10)                                        .kerning(1.5)
                                        .font(.custom("Blob Spongey Lowercase", size: 18))
                                        .foregroundColor(Color.gray.opacity(0.5))
                                }).focused($isFocused)
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                        Button(action: {
                            placeholderQuestion = "mendengarkan ..."
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){
                                self.isRecording.toggle()
                            }
                            self.isRecording ? self.startRecording() : self.stopRecording()
                        }, label:{
                            Image(systemName: "mic.fill")
                                .font(.largeTitle)
                                .foregroundColor(isRecording ? Color.red : Color.blue)
                                .padding(20)
                                .background(
                                    Color.white.opacity(0.4)
                                        .cornerRadius(50)
                                )
                        })
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationBarItems(trailing: ButtonMuteView())
            .padding(.bottom)
            Image("Kerang")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .position(x:196,y: 260)
                .padding(.vertical, 30)
                .padding(.top, 0)
                .onTapGesture {
                    isFocused.toggle()
                }
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
                .position(x:245,y: 230)
                .offset(offset)
                .gesture(DragGesture(minimumDistance: 1)
                    .onChanged({ value in
                        if !isFocused {
                            self.offset = value.translation
                            self.lastDragPosition = value
                            self.linePosition.x =  value.location.x
                            self.linePosition.y =  value.location.y
                            self.lineMoveCoordinate = CGPoint(x: self.linePosition.x - 100.0, y: self.linePosition.y - 360.0)
                            lineChange = true
                            self.answerKerangAjaib = ""
                        }
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
    
    //FUNCTION ANSWER
    func questionIsApproval() -> Bool {
        if self.questionText.count >= 1 {
            return true
        }
        return false
    }
    func getAnswer() {
        self.answerKerangAjaib = self.answersKerangAjaib.randomElement() ?? "Error"
    }
    
    //FUNCTION RECORDING
    func startRecording(){
        outputText = "";
        inputNode = audioEngine.inputNode
        do{
            audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }catch{
            print("ERROR: - Audio Session Failed!")
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do{
            try audioEngine.start()
        }catch{
            print("ERROR: - Audio Engine failed to start")
        }
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ result, error in
            if (result != nil){
                self.questionText = (result?.transcriptions[0].formattedString)!
            }
            if let result = result{
                self.questionText = result.transcriptions[0].formattedString
            }
            if error != nil {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        }
    }
    func stopRecording(){
        audioEngine.stop()
        recognitionRequest?.endAudio()
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        
        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        try? audioSession.setMode(AVAudioSession.Mode.default)
        try? audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        try? AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        
        audioSession = nil
        
        
    }
    func getSpeechStatus()->String{
        switch authStat{
        case .authorized:
            return "Authorized"
        case .notDetermined:
            return "Not yet Determined"
        case .denied:
            return "Denied - Close the App"
        case .restricted:
            return "Restricted - Close the App"
        default:
            return "ERROR: No Status Defined"
        }
    }
}

struct ViewPage3_Previews: PreviewProvider {
    static var previews: some View {
        ViewPage3()
    }
}
