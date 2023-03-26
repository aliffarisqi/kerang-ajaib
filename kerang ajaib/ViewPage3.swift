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
import Combine
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
                              "kamu ngga tau ? Chuankss", "Chuanksss", "apa kepentingan anda bertanya ?", "kamu nenyee", "rrauww", "mungkin saja ya", "mungkin saja tidak", "jangan kebanyakan mikir", "sepertinya ya", "sepertinya tidak", "sepertinya kamu kurang aqua" , "iya kali", "bisa, bisa gila", "bangun dari mimpi", "bisa jadi", "mana mungkin", "gak tau, aku ngantuk" ,"dua tiga kucing berlari, bisa aja sih", "tau ah", "gak tau, ngopi aja yuk", "Maaf pertanyaan anda gaje", "maaf, lagi malas mikir"]
    
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
    
    //INISIALISASI AUDIO
    @State var audioPlayerTarikTuas: AVAudioPlayer?
    @State var audioMic: AVAudioPlayer?
    
    //INISIALISASI Bubble
    @State private var isAnimatedBubble1: Bool = true
    @State private var poSitionBubble = CGPoint(x: 210, y: 305)
    @State private var poSitionBubbleAfter = CGPoint(x: 235, y: -170)
    @State private var isAnimationKerang: Bool = true
    @State private var kerangRotationScale: Double = 0.0
    @State private var isAnimationTuas: Bool = true
    @State private var TuasRotationScale: Double = 0.0
    @State private var isAnimationTextLogo: Bool = true
    @State private var textLogoRotationScale: Double = 0.0
    
    var body: some View {
        ZStack{
            Image("Ocean")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .transition(AnyTransition.slide.animation(.easeIn))
            Rectangle()
                .fill(Color("layerDark"))
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            ViewFlowerPagePlay()
            VStack{
                Spacer(minLength: 80)
                Image("TextLogo3d")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(isAnimationTextLogo ? 0.0 : 5))
                    .frame(width: isAnimationTextLogo ? 170 : 175)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3,
                                              dampingFraction: 0.1,
                                              blendDuration: 3)){
                            isAnimationTextLogo.toggle()
                            playSound()
                        }
                    }
                Spacer(minLength: 300)
                ZStack{
                    Rectangle()
                        .fill(
                            Color("layerRectangle").opacity(0.5)
                        )
                        .frame(maxWidth: .infinity, minHeight: 400)
                        .cornerRadius(50)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        ZStack{
                            Rectangle()
                                .fill(
                                    Color("layerTextField")
                                )
                                .frame(width: 340, height: 200)
                                .cornerRadius(25)
                            
                            
                            TextEditor(text: $questionText)
                                .frame(width: 310, height: 160)
                                .font(.custom("Blob Spongey Lowercase", size: 20))
                                .baselineOffset(4)
                                .kerning(1.5)
                                .foregroundColor(Color("fontQuestion").opacity(0.7))
                                .overlay(alignment: .topLeading, content: {
                                    Text(questionText.isEmpty ? placeholderQuestion : "")
                                        .offset(x:10, y:10)                                        .kerning(1.5)
                                        .font(.custom("Blob Spongey Lowercase", size: 18))
                                        .foregroundColor(Color("fontQuestion").opacity(0.5))
                                }).focused($isFocused)
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                        Button(action: {
                            playSoundMic()
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
                                    Color("layerRectangle").opacity(0.4)
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
            Image("Kerang3d")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(isAnimationKerang ? 0.0 : 5))
                .frame(width: isAnimationKerang ? 270 : 275)
                .position(x:190,y: 250)
                .padding(.vertical, 30)
                .padding(.top, 0)
                .onTapGesture {
                    isFocused.toggle()
                    withAnimation(.spring(response: 0.3,
                                          dampingFraction: 0.1,
                                          blendDuration: 3)){
                        isAnimationKerang.toggle()
                        isAnimationTuas.toggle()
                        
                    }
                    withAnimation(.easeInOut(duration: isAnimatedBubble1 ? 6 : 2)){
                        hapticEfect()
                        playSound()
                        isAnimatedBubble1.toggle()
                        //                        isAnimatedBubble1.toggle()
                    }
                    
                }
            LineTuaskerangAjaib(endPoint: lineChange ? lineMoveCoordinate : CGPoint(x: 140, y: -115))
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 9, lineCap: .round, dash: [8]))
                .frame(width: 200, height: 150)
            LineTuaskerangAjaib(endPoint: lineChange ? lineMoveCoordinate : CGPoint(x: 140, y: -115))
                .stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
                .frame(width: 200, height: 150)
                .shadow(radius: 2)
            
            
            
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
                .rotationEffect(.degrees(isAnimationTuas ? 0.0 : 5))
                .frame(width: isAnimationTuas ? 40.0 : 43.0)
                .position(x:245,y: 230)
                .offset(offset)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3,
                                          dampingFraction: 0.1,
                                          blendDuration: 3)){
                        isAnimationKerang.toggle()
                        isAnimationTuas.toggle()
                        playSound()
                    }
                }
                .gesture(DragGesture(minimumDistance: 1)
                    .onChanged({ value in
                        
                        if !isFocused {
                            //
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
                                playSound()
                                
                                
                            }
                            withAnimation(.spring(response: 0.3,
                                                  dampingFraction: 0.1,
                                                  blendDuration: 3)){
                                isAnimationKerang.toggle()
                            }
                            let utterance = AVSpeechUtterance(string: "\(answerKerangAjaib)")
                            utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
                            utterance.rate = 0.3
                            synthesizer.speak(utterance)
                            
                        })
                )
            ZStack{
                Image("Bubbles-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isAnimatedBubble1 ? 0 : 200)
                    .position(isAnimatedBubble1 ? poSitionBubble: poSitionBubbleAfter)
                Image("Bubbles-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isAnimatedBubble1 ? 0 : 200)
                    .position(isAnimatedBubble1 ? poSitionBubble: poSitionBubbleAfter)
                Image("Bubbles-3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isAnimatedBubble1 ? 0 : 200)
                    .position(isAnimatedBubble1 ? poSitionBubble: poSitionBubbleAfter)
                Image("Bubbles-5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: isAnimatedBubble1 ? 0 : 200)
                    .position(isAnimatedBubble1 ? poSitionBubble: poSitionBubbleAfter)
            }
            
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
    func hapticEfect(){
        let generator = UINotificationFeedbackGenerator()
        return generator.notificationOccurred(.success)
    }
    
    //FUNCTION RECORDING
    func startRecording(){
        outputText = "";
        do{
            audioSession = AVAudioSession.sharedInstance()
            //            try? audioSession.setCategory(.playAndRecord, mode: .default, options: [.mixWithOthers, .allowBluetoothA2DP])
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }catch{
            print("ERROR: - Audio Session Failed!")
        }
        
        inputNode = audioEngine.inputNode
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
        
        //        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        try? audioSession.setMode(AVAudioSession.Mode.default)
        
        try? audioSession.setCategory(.playAndRecord, mode: .default, options: [.mixWithOthers])
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
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
    func playSound() {
        guard let url = Bundle.main.url(forResource: "Bubble", withExtension: "mp3") else { return }
        do {
            audioPlayerTarikTuas = try AVAudioPlayer(contentsOf: url)
            audioPlayerTarikTuas?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func playSoundMic() {
        guard let url = Bundle.main.url(forResource: "Bubble", withExtension: "mp3") else { return }
        do {
            audioMic = try AVAudioPlayer(contentsOf: url)
            audioMic?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct ViewPage3_Previews: PreviewProvider {
    static var previews: some View {
        ViewPage3()
    }
}
