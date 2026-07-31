//
//  ContentView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    @State var responseContent: Answer?
    @State private var isLoading = false
    
    @State private var prompt = ""
    
    @Binding var tone: String
    @Binding var length: String
    @Binding var emotion: String
    @Binding var word: String
    @Binding var emoji: String
    
    var body: some View {
        TabView {
            Tab("AI", systemImage: "apple.intelligence") {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Enter a Question", text: $prompt)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .keyboardType(.default)
                    Button("Generate Answer") {
                        answerQN(prompt: prompt)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if isLoading {
                        ProgressView("Generating...")
                    } else if let content = responseContent {
                        Text(content.title)
                        Text(content.facts)
                        Text(content.followUp)
                    } else {
                        Text("No response yet")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            Tab("Settings", systemImage: "gearshape.2") {
                SettingsView(tonePersonality: $tone, lengthPersonality: $length, levelOfEmotionsPersonality: $emotion, wordComplicationPersonality: $word, emojiUsePersonality: $emoji)
            }
            
        }
    }
    func answerQN(prompt: String) {
        responseContent = nil
        isLoading = true
        Task {
            let preferences = """
            User Preferences:
            - Tone: \(tone)           
            - Response length: \(length)
            - Emotion level: \(emotion)
            - Readabiltiy: \(word)
            - Use emojis: \(emoji)
            """
            
            let instructions = """
            You are a personalization assistant. 
            Your role is to generate responses tailored to the individual user using the profile and context provided at runtime.
            
            You will receive:
            1. A user's request.
            2. The following are a list of user preferences which you are to follow at all costs.
            
            \(preferences)
            
            When generating a response: 
            - Use the user's preferences as much as possible and use other provided context when they are relevant. 
            - Personalize naturally without mentioning internal data unless the user asks. 
            - Never invent user information. If required information is missing, state the limitation or ask for clarification. 
            - Prioritize recent and relevant user data over older information. 
            - Maintain the user's preferred tone and level of detail. 
            - If personalization is not applicable, provide the best general response instead. 
            - Respect user privacy and only use the information explicitly supplied in the current context.
            
            Always adapt your response to the personalization profile whenever it is relevant.
            
            Do not invent user information.
            Do not mention the profile unless the user asks.
            
            Your objective is to make every response feel relevant, helpful, and specific to the user. Do not hallucinate.
            
            """
            
            let model = LanguageModelSession(instructions: instructions)
            do {
                let response = try await model.respond(to: prompt, generating: Answer.self)
                // Assign the generated content to our state
                self.responseContent = response.content
                self.isLoading = false
            } catch {
                // On error, clear content
                self.responseContent = nil
                self.isLoading = false
                print("Model respond error: \(error)")
            }
        }
    }
}

#Preview {
    ContentView(
        tone: .constant("Generate answer in a friendly tone"),
        length: .constant("Generate a medium-length answer"),
        emotion: .constant("Generate answer with a moderate amount of emotion"),
        word: .constant("Generate answer with simple words"),
        emoji: .constant("Generate answer with some emojis but do not use too many")
    )
}
