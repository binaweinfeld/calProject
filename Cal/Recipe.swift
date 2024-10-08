//
//  Recipe.swift
//  Cal
//
//  Created by Bina Walder on 06/10/2024.
//

import SwiftUI

struct Recipe: Codable, Identifiable {
    var calories: String
    var carbos: String
    var description: String
    var difficulty: Int
    var fats: String
    var headline: String
    var id: String
    var image: String
    var name: String
    var proteins: String
    var thumb: String
    var time: String
}
