//
//  ContentView.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI
import SwiftData
import SteadmanUI

struct ContentView: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let navigationItems = [
        NavigationItem(name: "Discover",
                       from: Image(.compass),
                       to: Image(.compassFill)),
        NavigationItem(name: "Search",
                       from: Image(.magnifyingglass),
                       to: Image(.magnifyingglassFill)),
        NavigationItem(name: "Messages",
                       from: Image(.envelope),
                       to: Image(.envelopeFill)),
        NavigationItem(name: "Profile",
                       from: Image(.person),
                       to: Image(.personFill)),
    ]
    
    var body: some View {
        CustomNavigationBar(items: navigationItems) {
            DiscoverPage()
                .frame(maxWidth: screen.width)
            SearchView()
                .frame(maxWidth: screen.width)
            MessagesPage()
                .frame(maxWidth: screen.width)
            ProfilePage()
                .frame(maxWidth: screen.width)
        }.onAppear {
            guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
            guard let backendHostAddress: String = infoDictionary["BackendHostName"] as? String else { return }
            defaults.host = backendHostAddress
        }
    }
}

#Preview {
    ContentView()
}
