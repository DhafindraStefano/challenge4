//
//  StoryView.swift
//  challenge4
//
import SwiftUI
import AVFAudio

struct RandomizeView: View {
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    @Binding var answerGame: FeelingObject?
    @Binding var child: Bool
    
    @State var gameName: String = ""
    @State var game: String = "game"
    @State private var isNextActive: Bool = false
    @State private var currentQuestion: Question? = nil
    
    @State private var currentQuestion: Question? = nil   // <-- now stores text + audio
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            GeometryReader { geo in
                ZStack {
                    RabbitsTalkingView()
                    
                    VStack {
                        Text(currentQuestion?.text ?? "Loading...")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: geo.size.width * 0.95)
                            .accessibilityLabel(currentQuestion?.text ?? "Loading question")
                            .accessibilityAddTraits(.isHeader)
                        
                        if let audioName = currentQuestion?.audioName {
                            Button {
                                AudioPlayer.shared.playAudio(named: audioName)
                            } label: {
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .accessibilityLabel("Play question audio")
                            .accessibilityHint("Plays a recording of the question")
                        }
                        
                        Button {
                            let questions = QuestionLoader.loadQuestions()
                            if let randomQ = questions.randomElement() {
                                currentQuestion = randomQ
                                gameName = randomQ.text
                            }
                            UIAccessibility.post(
                                notification: .announcement,
                                argument: "New question: \(gameName)"
                            )
                        } label: {
                            HStack {
                                Text("Randomize")
                                Image(systemName: "dice")
                            }
                            .font(.title)
                            .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
                            .padding(.top, 4)
                        }
                        .accessibilityLabel("Randomize question")
                        .accessibilityHint("Selects a new random question")
                    }
                    .position(x: geo.size.width/2, y: geo.size.height * 0.27)
                    
                    // --- Record Button pinned near bottom ---
                    RecordButton(
                        feelingParent: $feelingParent,
                        feelingChild: $feelingChild,
                        answerGame: $answerGame,
                        game: $game,
                        gameName: $gameName,
                        child: $child,
                        onNext: {
                            let logController = LogController(modelContext: modelContext)
                            if observationParent != nil || feelingParent != nil || needsParent != nil ||
                               observationChild != nil || feelingChild != nil || needsChild != nil ||
                               answerGame != nil {
                                logController.addLog(
                                    observationParent: observationParent,
                                    feelingParent: feelingParent,
                                    needsParent: needsParent,
                                    observationChild: observationChild,
                                    feelingChild: feelingChild,
                                    needsChild: needsChild,
                                    answerGame: answerGame
                                )
                            }
                            isNextActive = true
                        }
                    )
                    .accessibilityLabel("Record your answer")
                    .accessibilityHint("Tap to start recording your response to the question")
                    .position(x: geo.size.width/2, y: geo.size.height * 0.9)
                    
                    VStack {
                        HStack {
                            Button(action: { dismiss() }) {
                                BackButton()
                            }
                            .padding(.leading, 16)
                            .padding(.top, 46)

                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            let questions = QuestionLoader.loadQuestions()
            if let randomQ = questions.randomElement() {
                currentQuestion = randomQ
                gameName = randomQ.text
            }
        }
        .navigationDestination(isPresented: $isNextActive) {
            MemoryStarView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct RandomizeView: View {
//    @Binding var observationParent: RabitFaceObject?
//    @Binding var feelingParent: FeelingObject?
//    @Binding var needsParent: NeedObject?
//    
//    @Binding var observationChild: RabitFaceObject?
//    @Binding var feelingChild: FeelingObject?
//    @Binding var needsChild: NeedObject?
//    
//    @Binding var answerGame: FeelingObject?
//    @Binding var child: Bool
//    
//    @State var gameName: String = ""
//    @State var game: String = "game"
//    @State private var isNextActive: Bool = false
//    @State private var currentQuestion: Question? = nil
//    
//    @Environment(\.dismiss) private var dismiss
//    @Environment(\.modelContext) private var modelContext
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.background.ignoresSafeArea()
//                
//                GeometryReader { geo in
//                    ZStack {
//
//                        RabbitsTalkingView()
//                        VStack{
//                            Text(currentQuestion?.text ?? "Loading...")
//                                .font(.largeTitle)
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(.white)
//                                .padding(.horizontal)
//                                .frame(maxWidth: geo.size.width * 0.95)
//                                .accessibilityLabel(currentQuestion?.text ?? "Loading question")
//                                .accessibilityAddTraits(.isHeader)
////                            HStack(spacing: 0) {
//                                
//                                if let audioName = currentQuestion?.audioName {
//                                    Button {
//                                        AudioPlayer.shared.playAudio(named: audioName)
//                                    } label: {
//                                        Image(systemName: "speaker.wave.3.fill")
//                                            .font(.title)
//                                            .foregroundColor(.white)
//                                    }
//                                    .accessibilityLabel("Play question audio")
//                                    .accessibilityHint("Plays a recording of the question")
//                                }
//                                Button {
//                                    let questions = QuestionLoader.loadQuestions()
//                                    if let randomQ = questions.randomElement() {
//                                        currentQuestion = randomQ
//                                        gameName = randomQ.text
//                                    }
//                                    UIAccessibility.post(
//                                        notification: .announcement,
//                                        argument: "New question: \(gameName)"
//                                    )
//                                } label: {
//                                    HStack {
//                                        Text("Randomize")
//                                        Image(systemName: "dice")
//                                    }
//                                    .font(.title)
//                                    .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
//                                    .padding(.top, 4)
//                                }
//                                .accessibilityLabel("Randomize question")
//                                .accessibilityHint("Selects a new random question")
//                        }
//                        
//                        .position(x: geo.size.width/2, y: geo.size.height * 0.27)
//                        
//                        // --- Record Button pinned near bottom ---
//                        RecordButton(
//                            feelingParent: $feelingParent,
//                            feelingChild: $feelingChild,
//                            answerGame: $answerGame,
//                            game: $game,
//                            gameName: $gameName,
//                            child: $child,
//                            onNext: {
//                                let logController = LogController(modelContext: modelContext)
//                                if observationParent != nil || feelingParent != nil || needsParent != nil ||
//                                    observationChild != nil || feelingChild != nil || needsChild != nil ||
//                                    answerGame != nil {
//                                    
//                                    logController.addLog(
//                                        observationParent: observationParent,
//                                        feelingParent: feelingParent,
//                                        needsParent: needsParent,
//                                        observationChild: observationChild,
//                                        feelingChild: feelingChild,
//                                        needsChild: needsChild,
//                                        answerGame: answerGame
//                                    )
//                                }
//                                isNextActive = true
//                            }
//                        )
//                        .accessibilityLabel("Record your answer")
//                        .accessibilityHint("Tap to start recording your response to the question")
//                        .position(x: geo.size.width/2, y: geo.size.height * 0.9)
//                    }
//                }
//            }
//            .onAppear {
//                let questions = QuestionLoader.loadQuestions()
//                if let randomQ = questions.randomElement() {
//                    currentQuestion = randomQ
//                    gameName = randomQ.text
//                }
//            }
//            .navigationDestination(isPresented: $isNextActive) {
//                MemoryStarView()
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: { dismiss() }) {
//                    BackButton()
//                        .accessibilityLabel("Back")
//                        .accessibilityHint("Goes back to the previous screen")
//                }
//            }
//        }
//    }
//}

#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = RabitFaceObject(name: "Parent Rabbit", image: "RabbitImage")
    @Previewable @State var feelingParent: FeelingObject? = FeelingObject(name:"",AudioFilePath: "parent_feeling.m4a")
    @Previewable @State var needsParent: NeedObject? = NeedObject(needs: ["Care", "Support"])
    
    @Previewable @State var observationChild: RabitFaceObject? = RabitFaceObject(name: "Child Rabbit", image: "RabbitImage")
    @Previewable @State var feelingChild: FeelingObject? = FeelingObject(name:"" ,AudioFilePath: "child_feeling.m4a")
    @Previewable @State var needsChild: NeedObject? = NeedObject(needs: ["Play", "Fun"])
    
    @Previewable @State var answerGame: FeelingObject? = FeelingObject(name:"",AudioFilePath: "game_answer.m4a")
    
    @Previewable @State var child: Bool = false
    
    RandomizeView(
        observationParent: $observationParent,
        feelingParent: $feelingParent,
        needsParent: $needsParent,
        
        observationChild: $observationChild,
        feelingChild: $feelingChild,
        needsChild: $needsChild,
        
        answerGame: $answerGame,
        child: $child
    )
    .modelContainer(
        for: [LogObject.self, NeedObject.self, RabitFaceObject.self, FeelingObject.self, Item.self],
        inMemory: true
    )

    
}
