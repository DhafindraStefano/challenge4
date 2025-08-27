//
//  challenge4App.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 13/08/25.
//

import SwiftUI
import SwiftData
import AVFoundation

@main
struct challenge4App: App {
    @State private var backgroundAudioPlayer: AVAudioPlayer?
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

    // Create a persistent ModelContainer
    var sharedModelContainer: ModelContainer = {
        do {
            let schema = Schema([
                LogObject.self,
                NeedObject.self,
                RabitFaceObject.self,
                FeelingObject.self,
                Item.self
                
            ])
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
            } else {
                OnboardingViewStart()
            }
        }
        .modelContainer(sharedModelContainer)
        
    }
}

// MARK: For Exhibition Only
//import SwiftUI
//import SwiftData
//import AVFoundation
//
//@main
//struct challenge4App: App {
//    @State private var backgroundAudioPlayer: AVAudioPlayer?
//    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
//
//    // Create an in-memory ModelContainer
//    var sharedModelContainer: ModelContainer = {
//        do {
//            let schema = Schema([
//                LogObject.self,
//                NeedObject.self,
//                RabitFaceObject.self,
//                FeelingObject.self,
//                Item.self
//            ])
//            
//            // 👇 Create a config that only keeps data in memory
//            let config = ModelConfiguration(isStoredInMemoryOnly: true)
//            
//            return try ModelContainer(for: schema, configurations: [config])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//    var body: some Scene {
//        WindowGroup {
//            if hasSeenOnboarding {
//                ContentView()
//            } else {
//                OnboardingViewStart()
//            }
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}


