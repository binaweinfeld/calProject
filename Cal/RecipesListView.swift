//
//  RecipesListView.swift
//  Cal
//
//  Created by Bina Walder on 06/10/2024.
//

import SwiftUI

struct RecipesListView: View {
    
    @State private var recipes: [Recipe] = []
    @State private var isActive = false
    
    var body: some View {
        NavigationStack{
            List(recipes) { recipe in
                NavigationLink(destination: RecipeView(id: recipe.id), isActive: $isActive) {
                    HStack{
                        AsyncImage(url: URL(string: recipe.image)) { result in
                            result.image?.resizable().scaledToFill().frame(width: 80,height: 80).cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        }
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                            Text("fats: \(recipe.fats)")
                            Text("calories: \(recipe.calories)")
                            Text("carbos: \(recipe.carbos)")
                        }
                    }.onTapGesture {
                        
                        BiometricAuthentication.authenticateUser{ success, error in
                            if success {
                                if let data = Converter.convertRecipeToData(recipe: recipe) {
                                    if KeychainHelper.save(key: recipe.id, data: data) {
                                        isActive = true
                                    } else {
                                        print("לא ניתן להצפין את המידע")
                                    }
                                }
                            } else {
                                print("Failed to authenticate user", error ?? "")
                            }
                        }
                    }
                    
                }
            }.onAppear{
                fetchRemoteData()
            }
        }
    }
    
    private func fetchRemoteData() {
        let url = URL(string: "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json")!
                var request = URLRequest(url: url)
                request.httpMethod = "GET"  // optional
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request){ data, response, error in
                    if let error = error {
                        print("Error while fetching data:", error)
                        return
                    }

                    guard let data = data else {
                        return
                    }

                    do {
                        let decodedData = try JSONDecoder().decode([Recipe].self, from: data)
                        // Assigning the data to the array
                        self.recipes = decodedData
                    } catch let jsonError {
                        print("Failed to decode json", jsonError)
                    }
                }

                task.resume()
    }
}

#Preview {
    RecipesListView()
}

