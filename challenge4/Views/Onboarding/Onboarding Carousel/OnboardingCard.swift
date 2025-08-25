import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Card
struct OnboardingCard: View {
    let page: OnboardingPage
    let isLast: Bool
    let onNext: () -> Void
    
    var body: some View {
        ZStack {
            // Card frame
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .strokeBorder(Color.cardBorder, lineWidth: 8)
                )
                .shadow(color: .black.opacity(0.35), radius: 18, y: 8)
            
            // Overlay (e.g., dice)
            if page.overlay == .dice {
                Image("DiceImage")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top, 30)
                    .padding(.leading, 15)
            }
            
            // Main content with consistent layout
            VStack(spacing: 0) {
                
                // Main illustration area with fixed height
                ZStack {
                    switch page.main {
                    case .single(let name, let width, let height, let offsetX, let offsetY):
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width, height: height)
                            .offset(x: offsetX, y: offsetY)
                        
                    case .duo(let leftName, let rightName,
                              let leftWidth, let leftHeight, let leftOffsetX, let leftOffsetY,
                              let rightWidth, let rightHeight, let rightOffsetX, let rightOffsetY):
                        
                        Image(leftName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: leftWidth, height: leftHeight)
                            .offset(x: leftOffsetX, y: leftOffsetY)
                        
                        Image(rightName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: rightWidth, height: rightHeight)
                            .offset(x: rightOffsetX, y: rightOffsetY)
                    }
                }
                .frame(height: 220)
                .padding(.top, 10)
                
                // Face cluster area with fixed height
                ZStack {
                    if let faces = page.faces, !faces.isEmpty {
                        ForEach(faces.indices, id: \.self) { index in
                            let face = faces[index]
                            Image(face.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: face.width, height: face.height)
                                .offset(x: face.offsetX, y: face.offsetY)
                        }
                    } else {
                        Color.clear
                    }
                }
                .frame(height: 120)
                .padding(.top, 10)
                
                // Text area with TIGHTER spacing (changed from 10 to 6)
                VStack(spacing: 6) {
                    Text(page.title)
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(page.subtitle)
                        .font(.caption)
                        .fontDesign(.rounded)
                        .foregroundColor(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: 320)
                .padding(.top, 16) // Reduced from 20 to 16
                
                Spacer() // This Spacer will now push the content to the top
            }
            .padding(0)
        }
        // Permission buttons for microphone screen
        .overlay(alignment: .bottom) {
            if page.hasPermissionButtons {
                PermissionButtons(onAllow: onNext)
                    .padding(.bottom, 56)
                    .zIndex(10)
            } else {
                NextButton(action: onNext)
                    .padding(.bottom, 56)
                    .zIndex(10)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let samplePage = OnboardingPage(
        main: .single("onb_feelings", width: 250, height: 200, offsetY: -50),
        faces: [
            .init("OnboardingSadFace", width: 82, offsetX: -92, offsetY: -38),
            .init("OnboardingAngryFace", width: 100, offsetX: 0, offsetY: -10),
            .init("OnboardingHappyFace", width: 92, offsetX: 87, offsetY: -48)
        ],
        overlay: .dice,
        title: "Share your feelings",
        subtitle: "Reflect on your day with your child using NVC framework"
    )
    
    OnboardingCard(
        page: samplePage,
        isLast: false,
        onNext: { print("Next tapped") }
    )
    .frame(width: 380, height: 571)
    .background(Color.buttonBlueDropShadow)
}
