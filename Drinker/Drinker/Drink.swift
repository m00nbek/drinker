import Foundation
import SwiftUI

struct Drink: Identifiable, Codable {
    let id: UUID
    var name: String
    var imageName: String
    var count: Int
    var history: [Date]
    
    init(id: UUID = UUID(), name: String, imageName: String, count: Int = 0, history: [Date] = []) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.count = count
        self.history = history
    }
    
    mutating func incrementCount() {
        count += 1
        history.append(Date())
    }
}
