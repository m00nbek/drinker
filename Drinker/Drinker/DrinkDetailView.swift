import SwiftUI

struct DrinkDetailView: View {
    let drink: Drink
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack {
            Text("\(drink.name) History")
                .font(.title)
                .padding()
            
            List {
                ForEach(drink.history.reversed(), id: \.self) { date in
                    Text(dateFormatter.string(from: date))
                }
            }
        }
    }
}
