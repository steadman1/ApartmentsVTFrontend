//
//  ContentView.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            Text("hello world")
        }
    }
}

#Preview {
    ContentView()
}
