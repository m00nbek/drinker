import Foundation
import SwiftUI

class DrinksViewModel: ObservableObject {
    @Published var drinks: [Drink] = []
    private let userDefaults = UserDefaults.standard
    private let drinksKey = "savedDrinks"
    
    init() {
        loadDrinks()
    }
    
    func addDrink(name: String, imageName: String) {
        let newDrink = Drink(name: name, imageName: imageName)
        drinks.append(newDrink)
        saveDrinks()
    }
    
    func incrementDrinkCount(_ drink: Drink) {
        if let index = drinks.firstIndex(where: { $0.id == drink.id }) {
            drinks[index].incrementCount()
            saveDrinks()
        }
    }
    
    private func saveDrinks() {
        if let encodedData = try? JSONEncoder().encode(drinks) {
            userDefaults.set(encodedData, forKey: drinksKey)
        }
    }
    
    private func loadDrinks() {
        guard let data = userDefaults.data(forKey: drinksKey),
              let savedDrinks = try? JSONDecoder().decode([Drink].self, from: data) else {
            return
        }
        drinks = savedDrinks
    }
}
