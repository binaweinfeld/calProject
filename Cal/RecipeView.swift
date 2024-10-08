//
//  RecipeView.swift
//  Cal
//
//  Created by Bina Walder on 06/10/2024.
//

import SwiftUI

struct RecipeView: View {
    
    var id: String
    @State private var item: Recipe?
    
    var body: some View {
        VStack{
            Text(item?.name ?? "")
            AsyncImage(url: URL(string: item?.image ?? "")) { result in
                result.image?.resizable().scaledToFit()
            }
            Text(item?.fats ?? "")
            Text(item?.calories ?? "")
            Text(item?.carbos ?? "")
            Text(item?.description ?? "")
        }.padding(30)
            .onAppear{
                BiometricAuthentication.authenticateUser{ success, error in
                    if success {
                        if let data = KeychainHelper.load(key: id) {
                            self.item = Converter.convertDataToRecipe(data: data)
                        }
                    } else {
                        print("Failed to authenticate user", error ?? "")
                    }
                }
            }
    }
}

#Preview {
    RecipeView(id: "")
}
