//
//  ContentView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI
import FoundationModels

struct Intelligence {
    private let instructions = """
            You are a _____. Write a recommendation. Keep it short, positive and inspiring. Respond only with the final recommendation, no explanations.
        """
    public func generate(_ input: String) async throws -> String {
        guard SystemLanguageModel.default.isAvailable else {
            return input
        }
        
        let session = LanguageModelSession()
        
        let seed = UInt64(Calendar.current.component(.dayOfYear, from: .now))
        let sampling = GenerationOptions.SamplingMode.random(top: 10, seed: seed)
        let options = GenerationOptions(sampling: sampling, temperature: 0.7)
        
        let response = try await session.respond(to: input)
        return response.content
    }
}

struct ContentView: View {
    var body: some View {
        VStack{
            
        }
    }
}

#Preview {
    ContentView()
}
