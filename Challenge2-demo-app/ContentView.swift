//
//  ContentView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI
import FoundationModels

struct MainContentView: View {
    @State var responseContent: Answer?
    @State var prompt: String = ""
    @State private var isLoading = false
    @State private var tonePersonality = ""
    @State private var lengthPersonality = ""
    @State private var levelOfEmotionsPersonality = ""
    @State private var wordComplicationPersonality = ""
    @State private var emojiUsePersonality = ""
    var body: some View {
        TabView {
            Tab("AI", systemImage: "waveform.circle.fill") {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Enter username", text: $prompt)
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
                VStack{
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("Personalize response:")
                        .multilineTextAlignment(.center)
                    //for selecting tone
                    Text("Tone:")
                        .fontWeight(.bold)
                    Button ("rude"){
                        tonePersonality = "Generate answer in a rude tone"
                    }
                    Button ("friendly"){
                        tonePersonality = "Generate answer in a friendly tone"
                    }
                    //for selecting length
                    Text("Length:")
                        .fontWeight(.bold)
                    Button ("long"){
                        lengthPersonality = "Generate long answer"
                    }
                    Button ("short"){
                        lengthPersonality = "Generate short answer"
                    }
                    //for selecting emotional level
                    Text("How emotional it should be:")
                        .fontWeight(.bold)
                    Button ("Emotional"){
                        levelOfEmotionsPersonality = "Generate answer with a lot of emotion"
                    }
                    Button ("Detached"){
                        levelOfEmotionsPersonality = "Generate answer with as little emotion as possible"
                    }
                    //for selecting word complication
                    Text("Complication of word choice:")
                    Button("Complicated") {
                        wordComplicationPersonality = "Generate answer with very complicated and philosophical words"
                    }
                    Button("Simple") {
                        wordComplicationPersonality = "Generate answer with very simple and easy-to-understand words"
                    }
                    //for selecting how much you use emoji
                    Text("Emoji usage:")
                    Button("A LOT") {
                        emojiUsePersonality = "Generate answer with as many emojis as possible"
                    }
                    Button("Moderate") {
                        emojiUsePersonality = "Generate answer with some emojis but do not use too many. Only keep it to 2-3 for short answers and 4-5m for long answers"
                    }
                }
            }
        }
        
    }
    func answerQN(prompt: String) {
        responseContent = nil
        isLoading = true
        Task {
            let preferences = """
            User Preferences:
            - Tone: \(tonePersonality)           
            - Response length: \(lengthPersonality)
            - Emotion level: \(levelOfEmotionsPersonality)
            - Readabiltiy: \(wordComplicationPersonality)
            - Use emojis: \(emojiUsePersonality)
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
    MainContentView(prompt: "Tell me about SwiftUI")
}
