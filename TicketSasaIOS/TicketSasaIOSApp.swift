//
//  TicketSasaIOSApp.swift
//  TicketSasaIOS
//
//  Created by Samuel Nyamai on 21/03/2024.
//

import SwiftUI
import SwiftData

@main
struct TicketSasaIOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var network = Network()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
