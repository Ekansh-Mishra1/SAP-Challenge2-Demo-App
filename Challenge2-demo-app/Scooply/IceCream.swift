//
//  IceCream.swift
//  scooply
//
//  Created by Ekansh Mishra on 12/2/26.
//
import FoundationModels

@Generable
struct IceCream {
    @Guide(description: "Name of the IceCream flavour")
    var title: String
    
    @Guide(description: "Ingredients needed to create the IceCream, separated by commas")
    var ingredients: String
    
    @Guide(description: "A description of the IceCream, highlighting its unique qualities")
    var description: String
}
