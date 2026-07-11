//
//  ContentView.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 11/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Group 14pm")
            HStack {
                Text("Elvia and")
                    .font(.largeTitle)
                    .bold()
                Text("Ekansh")
                    .font(.largeTitle)
                    .bold()
            }
            Image("Ethan")
                .clipShape(Circle())
            Text("Mentorman: Ethan")
            Text("He sick")
        }
    }
}

#Preview {
    ContentView()
}
