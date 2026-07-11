//
//  ContentView.swift
//  scooply
//
//  Created by Ekansh Mishra on 12/2/26.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    @State var responseContent: IceCream?
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    
                    Button("Make it Sweet"){
                        generateIceCream(prompt: "Make it Sweet")
                    }
                    Button("Make it Sour"){
                        generateIceCream(prompt: "Make it Sour")
                    }
                    Button("Make it Salty"){
                        generateIceCream(prompt: "Make it Salty")
                    }
                    Button("Make it Random"){
                        generateIceCream(prompt: "Make it Random")
                    }
                }
                Section{
                    Text("Output")
                        .font(.title2)
                    if let responseContent {
                        VStack(alignment: .leading) {
                            Text(responseContent.title)
                                .font(.headline)
                            Text(responseContent.ingredients)
                                .font(.subheadline)
                            Text(responseContent.description)
                        }
                    } else {
                        ProgressView()
                    }
                }
                
                .navigationTitle("Scooply IceCream Generator")
            }
        }
    }
    
    func generateIceCream(prompt: String) {
        responseContent = nil
        Task {
            let instructions = "You are an Ice-Cream generator. Your only purpose is to come up with creative Ice-Cream Flavours. You will only output Ice-Cream flavours based on a prompt supplied by the user. You should not ask any questions and just suggest Ice-Cream flavours. You will return only a title, ingredients, and description."
            
            let model = LanguageModelSession(instructions: instructions)
            
            let response = try? await model.respond(to: prompt, generating: IceCream.self)
            
            self.responseContent = response?.content
        }
    }
}


#Preview {
    ContentView()
}

