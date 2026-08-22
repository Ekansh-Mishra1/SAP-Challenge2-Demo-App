//
//  Challenge2_demo_appApp.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI

import SwiftUI

@main
struct Challenge2_demo_appApp: App {
    //remove tone, emoji
    @State private var tone = "Generate answer in a friendly tone"
    @State private var length = "Generate a medium-length answer"
    @State private var emotion = "Generate answer with a moderate amount of emotion"
    @State private var word = "Generate answer with simple words"
    @State private var emoji = "Generate answer with some emojis but do not use too many"

    var body: some Scene {
        WindowGroup {
            //remove tone, emoji
            ContentView(
                tone: $tone,
                length: $length,
                emotion: $emotion,
                word: $word,
                emoji: $emoji
            )
        }
    }
}
