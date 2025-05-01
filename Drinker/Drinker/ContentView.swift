import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DrinksViewModel()
    @State private var showingAddDrinkView = false
    @State private var newDrinkName = ""
    @State private var newDrinkImageName = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.drinks) { drink in
                        DrinkCardView(drink: drink, viewModel: viewModel)
                    }
                    
                    Button(action: { showingAddDrinkView = true }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                            Text("Add Drink")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Drink Counter")
        }
        .sheet(isPresented: $showingAddDrinkView) {
            VStack {
                TextField("Drink Name", text: $newDrinkName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Image Name (SF Symbols)", text: $newDrinkImageName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Add Drink") {
                    if !newDrinkName.isEmpty {
                        viewModel.addDrink(name: newDrinkName, imageName: newDrinkImageName.isEmpty ? "cup.and.saucer" : newDrinkImageName)
                        showingAddDrinkView = false
                        newDrinkName = ""
                        newDrinkImageName = ""
                    }
                }
                .padding()
            }
        }
    }
}

struct DrinkCardView: View {
    let drink: Drink
    @ObservedObject var viewModel: DrinksViewModel
    
    var body: some View {
        VStack {
            Image(systemName: drink.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            Text(drink.name)
                .font(.headline)
            
            Text("Count: \(drink.count)")
                .font(.subheadline)
            
            HStack {
                Button(action: { viewModel.incrementDrinkCount(drink) }) {
                    Text("Drink")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: DrinkDetailView(drink: drink)) {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
