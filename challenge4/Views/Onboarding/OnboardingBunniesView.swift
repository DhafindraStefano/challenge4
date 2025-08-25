import SwiftUI

struct OnboardingBunniesView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("bunnies_bed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width + 2)
                    .ignoresSafeArea(edges: .bottom)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .bottom)
            }
            .allowsHitTesting(false)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    OnboardingBunniesView()
        .background(Color.black)
}