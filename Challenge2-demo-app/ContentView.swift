//
//  ContentView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Ekansh!")
            Text("I pushed this and you pulled it")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
