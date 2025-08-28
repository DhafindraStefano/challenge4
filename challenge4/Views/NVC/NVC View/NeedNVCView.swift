//
//  NeedNVCView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//
import SwiftUI
import SwiftData

struct NeedNVCView: View {
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    @Binding var answerGame: FeelingObject?
    @Binding var child: Bool
    
    @State private var selectedNeeds: [String] = []
    @State private var customNeed: String = ""
    @State private var isNextActive: Bool = false
    @State private var keyboardHeight: CGFloat = 0

    @Environment(\.dismiss) private var dismiss
    
    var audioName : String = "What_do_you_need"
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.background.ignoresSafeArea()
                
                // 🔹 Rabbits background
                RabbitsTalkingView()
                
                // 🔹 Question text
                HStack(spacing: 4) {
                    Text("What do you need?")
                        .font(.largeTitle)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .accessibilityLabel("Question: What do you need?")
                        .accessibilityAddTraits(.isHeader)
                        .multilineTextAlignment(.center)

                    Button {
                        AudioPlayer.shared.playAudio(named: audioName)
                    } label: {
                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: geo.size.width * 0.06))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Play question audio")
                    .accessibilityHint("Plays 'What do you need?'")
                }
                .accessibilityElement(children: .combine)
                .frame(maxWidth: geo.size.width * 0.9)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.33)
                
                // 🔹 NeedCard
                NeedCard(
                    selectedNeeds: $selectedNeeds,
                    customNeed: $customNeed,
                    child: $child,
                    needChild: $needsChild,
                    needParent: $needsParent,
                    onNext: {
                        selectedNeeds = []
                        child.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isNextActive = true
                        }
                    }
                )
                .frame(width: geo.size.width, height: geo.size.height)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.85 + 20 - keyboardHeight / 2 )
                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            BackButton()
                        }
                        .accessibilityLabel("Back")
                        .accessibilityHint("Goes back to the previous screen")
                        .padding(.leading, 16)
                        .padding(.top, 46)

                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                withAnimation(.easeOut(duration: 0.25)) {
                    keyboardHeight = keyboardFrame.height - 200
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.easeOut(duration: 0.25)) {
                keyboardHeight = 0
            }
        }
        // 🔹 Next step in the SAME navigation stack
        .navigationDestination(isPresented: $isNextActive) {
            if child {
                HowNVCView(
                    observationParent: $observationParent,
                    feelingParent: $feelingParent,
                    needsParent: $needsParent,
                    observationChild: $observationChild,
                    feelingChild: $feelingChild,
                    needsChild: $needsChild,
                    answerGame: $answerGame,
                    child: $child
                )
                .transaction { $0.disablesAnimations = true }
            } else {
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
                .transaction { $0.disablesAnimations = true }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: { dismiss() }) {
//                    BackButton()
//                        .accessibilityLabel("Back")
//                        .accessibilityHint("Goes back to the previous screen")
//                }
//            }
//        }
    }
}




#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = RabitFaceObject(name: "Parent Rabbit", image: "RabbitImage")
    @Previewable @State var feelingParent: FeelingObject? = FeelingObject(name: "" , AudioFilePath: "parent_feeling.m4a")
    @Previewable @State var needsParent: NeedObject? = NeedObject(needs: [""])
    
    @Previewable @State var observationChild: RabitFaceObject? = RabitFaceObject(name: "Child Rabbit", image: "RabbitImage")
    @Previewable @State var feelingChild: FeelingObject? = FeelingObject(name:"" ,AudioFilePath: "child_feeling.m4a")
    @Previewable @State var needsChild: NeedObject? = NeedObject(needs: ["Play"])
    
    @Previewable @State var answerGame: FeelingObject? = FeelingObject(name: "" , AudioFilePath: "game_answer.m4a")
    
    @Previewable @State var child: Bool = false
    
    NeedNVCView(
        observationParent: $observationParent,
        feelingParent: $feelingParent,
        needsParent: $needsParent,
        
        observationChild: $observationChild,
        feelingChild: $feelingChild,
        needsChild: $needsChild,
        
        answerGame: $answerGame,
        child: $child
    )
}
