//
//  ContentView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI
import FoundationModels


@Generable
struct Answer {
    @Guide(description: "Answer to the question")
    var title: String
    
    @Guide(description: "Fun Facts based on the question")
    var ingredients: String
    
    @Guide(description: "Recommended Follow up questions")
    var description: String
}

struct MainContentView: View {
    @State var responseContent: Answer?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button("Generate Answer") {
                answerQN(prompt: "Tell me something about SwiftUI")
            }
            .buttonStyle(.borderedProminent)

            if let content = responseContent {
                Text(content.title)
                    .font(.headline)
                Text(content.ingredients)
                    .font(.subheadline)
                Text(content.description)
                    .font(.body)
            } else {
                Text("No response yet")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        
    }
    func answerQN(prompt: String) {
        responseContent = nil
        Task {
            let instructions = """
                        You are a personalization assistant.
                    
                        Your role is to generate responses tailored to the individual user using the profile and context provided at runtime.
                    
                        When generating a response:
                        - Use the user's preferences, interests, goals, communication style, history, and other provided context when they are relevant.
                        - Personalize naturally without mentioning internal data unless the user asks.
                        - Never invent user information. If required information is missing, state the limitation or ask for clarification.
                        - Prioritize recent and relevant user data over older information.
                        - Maintain the user's preferred tone and level of detail.
                        - If personalization is not applicable, provide the best general response instead.
                        - Respect user privacy and only use the information explicitly supplied in the current context.
                    
                        Your objective is to make every response feel relevant, helpful, and specific to the user.
                    
                        Do not hallucinate.
                    """
            
            let model = LanguageModelSession(instructions: instructions)
            do {
                let response = try await model.respond(to: prompt, generating: Answer.self)
                // Assign the generated content to our state
                self.responseContent = response.content
            } catch {
                // On error, clear content
                self.responseContent = nil
                print("Model respond error: \(error)")
            }
        }
    }
}

#Preview {
    MainContentView()
}
