//
//  Converter.swift
//  Cal
//
//  Created by Bina Walder on 06/10/2024.
//

import SwiftUI

class Converter {
    static func convertRecipeToData(recipe: Recipe) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(recipe)
            return data
        } catch {
            print("Error encoding user: \(error)")
            return nil
        }
    }
    
    static func convertDataToRecipe(data: Data) -> Recipe? {
        let encoder = JSONDecoder()
        do {
            let decodedData = try encoder.decode(Recipe.self, from: data)
            return decodedData
            
        } catch let jsonError {
            print("Failed to decode json", jsonError)
            return nil
        }
    }
}
