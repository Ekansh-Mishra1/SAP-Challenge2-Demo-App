//
//  SettingsView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 31/7/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var tonePersonality: String
    @Binding var lengthPersonality: String
    @Binding var levelOfEmotionsPersonality: String
    @Binding var wordComplicationPersonality: String
    @Binding var emojiUsePersonality: String
    
    @State private var toneValue: Double = 1
    @State private var lengthValue: Double = 1
    @State private var emotionValue: Double = 2
    @State private var wordValue: Double = 2
    @State private var emojiValue: Double = 1
    
    var body: some View {
        NavigationStack {
            Text("Personalize response:")
                .foregroundStyle(.secondary)
                .padding(.top, 10)
            List {
                
                // Tone
                Section {
                    VStack(spacing: 6) {
                        HStack {
                            Text("Rude")
                                .frame(width: 55, alignment: .leading)
                            
                            Slider(value: $toneValue, in: 0...1, step: 1)
                                .frame(width: 200)
                            
                            Text("Friendly")
                                .frame(width: 65, alignment: .trailing)
                        }
                        
                        sliderDots(count: 2)
                    }
                    .padding(.vertical, 6)
                } header: {
                    Text("Tone")
                }
                .onChange(of: toneValue) {
                    tonePersonality = toneValue == 0
                    ? "Generate answer in a rude tone"
                    : "Generate answer in a friendly tone"
                }
                
                // Length
                Section {
                    VStack(spacing: 6) {
                        HStack {
                            Text("Short")
                                .frame(width: 55, alignment: .leading)
                            
                            Slider(value: $lengthValue, in: 0...2, step: 1)
                                .frame(width: 200)
                            
                            Text("Long")
                                .frame(width: 65, alignment: .trailing)
                        }
                        
                        sliderDots(count: 3)
                    }
                    .padding(.vertical, 6)
                } header: {
                    Text("Length")
                }
                .onChange(of: lengthValue) {
                    switch lengthValue {
                    case 0:
                        lengthPersonality = "Generate a very short answer"
                    case 2:
                        lengthPersonality = "Generate a long answer"
                    default:
                        lengthPersonality = "Generate a medium-length answer"
                    }
                }
                
                // Emotion
                Section {
                    VStack(spacing: 6) {
                        HStack {
                            Text("Robotic")
                                .frame(width: 55, alignment: .leading)
                            
                            Slider(value: $emotionValue, in: 0...4, step: 1)
                                .frame(width: 200)
                            
                            Text("Emotional")
                                .frame(width: 65, alignment: .trailing)
                        }
                        
                        sliderDots(count: 5)
                    }
                    .padding(.vertical, 6)
                } header: {
                    Text("How emotional it should be")
                }
                .onChange(of: emotionValue) {
                    switch emotionValue {
                    case 0:
                        levelOfEmotionsPersonality =
                        "Generate answer with as little emotion as possible"
                    case 1:
                        levelOfEmotionsPersonality =
                        "Generate answer with very little emotion"
                    case 3:
                        levelOfEmotionsPersonality =
                        "Generate answer with a lot of emotion"
                    case 4:
                        levelOfEmotionsPersonality =
                        "Generate answer with an extremely emotional tone"
                    default:
                        levelOfEmotionsPersonality =
                        "Generate answer with a moderate amount of emotion"
                    }
                }
                
                // Word
                Section {
                    VStack(spacing: 6) {
                        HStack {
                            Text("Simple")
                                .frame(width: 55, alignment: .leading)
                            
                            Slider(value: $wordValue, in: 0...4, step: 1)
                                .frame(width: 200)
                            
                            Text("Complicated")
                                .frame(width: 65, alignment: .trailing)
                        }
                        
                        sliderDots(count: 5)
                    }
                    .padding(.vertical, 6)
                } header: {
                    Text("Complication of word choice")
                }
                .onChange(of: wordValue) {
                    switch wordValue {
                    case 0:
                        wordComplicationPersonality =
                        "Generate answer with very simple and easy-to-understand words"
                    case 2:
                        wordComplicationPersonality =
                        "Generate answer with moderately complex words"
                    case 3:
                        wordComplicationPersonality =
                        "Generate answer with advanced vocabulary"
                    case 4:
                        wordComplicationPersonality =
                        "Generate answer with very complicated and philosophical words"
                    default:
                        wordComplicationPersonality =
                        "Generate answer with simple words"
                    }
                }
                
                // Emoji
                Section {
                    VStack(spacing: 6) {
                        HStack {
                            Text("None")
                                .frame(width: 55, alignment: .leading)
                            
                            Slider(value: $emojiValue, in: 0...2, step: 1)
                                .frame(width: 200)
                            
                            Text("A LOT")
                                .frame(width: 65, alignment: .trailing)
                        }
                        
                        sliderDots(count: 3)
                    }
                    .padding(.vertical, 6)
                } header: {
                    Text("Emoji usage")
                }
                .onChange(of: emojiValue) {
                    switch emojiValue {
                    case 0:
                        emojiUsePersonality = "Do not use emojis"
                    case 2:
                        emojiUsePersonality =
                        "Generate answer with as many emojis as possible"
                    default:
                        emojiUsePersonality =
                        "Generate answer with some emojis but do not use too many. Only keep it to 2-3 for short answers and 4-5 for long answers"
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func sliderDots(count: Int) -> some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .frame(width: 5, height: 5)
                
                if index < count - 1 {
                    Spacer()
                }
            }
        }
        .frame(width: 175)
    }
}

#Preview {
    SettingsView(
        tonePersonality: .constant("Generate answer in a friendly tone"),
        lengthPersonality: .constant("Generate a medium-length answer"),
        levelOfEmotionsPersonality: .constant("Generate answer with a moderate amount of emotion"),
        wordComplicationPersonality: .constant("Generate answer with moderately complex words"),
        emojiUsePersonality: .constant("Generate answer with some emojis but do not use too many")
    )
}
