//
//  ApartmentsVTApp.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI
import SwiftData
import SteadmanUI

@main
struct ApartmentsVTApp: App {
    @ObservedObject var defaults = ObservableDefaults.shared
    @ObservedObject var screen = Screen.shared
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                NavigationStack {
                    ContentView()
                        .environmentObject(screen)
                        .environmentObject(defaults)
                        .onAppear {
                            screen.width = geometry.size.width
                            screen.height = geometry.size.height
                            screen.safeAreaInsets = geometry.safeAreaInsets
                            screen.initialSafeAreaInsets = geometry.safeAreaInsets
                        }.onChange(of: geometry.size) { _, newValue in
                            screen.width = geometry.size.width
                            screen.height = geometry.size.height
                            screen.safeAreaInsets = geometry.safeAreaInsets
                        }
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

