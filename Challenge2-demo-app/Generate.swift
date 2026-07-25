//
//  Generate.swift
//  Challenge2-demo-app
//
//  Created by Ekansh Mishra on 25/7/26.
//

import Foundation
import FoundationModels

@Generable
struct Answer {
    @Guide(description: "Answer to the question")
    var title: String
    
    @Guide(description: "Fun Facts based on the question")
    var facts: String
    
    @Guide(description: "Recommended Follow up questions")
    var followUp: String
}
