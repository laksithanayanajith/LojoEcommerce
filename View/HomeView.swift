import SwiftUI

struct HomeView: View {
    
    @State private var items: [ItemElement] = []
    
    var body: some View {
        ZStack {
            VStack {
                Text("LOJO")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    VStack {
                        ForEach(items.filter { $0.id % 2 == 0 }) { item in
                            RectangleItemView(item: item)
                        }
                    }
                    
                    VStack {
                        ForEach(items.filter { $0.id % 2 != 0 }) { item in
                            RectangleItemView(item: item)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            Task {
                do {
                    // Call the async function to fetch items
                    try await fetchItems { items in
                        if let items = items {
                            // Update the state variable with the fetched items
                            self.items = items
                        }
                    }
                } catch {
                    // Handle other errors
                    print("Error fetching items: \(error)")
                }
            }
            
        }
    }
    
    struct RectangleItemView: View {
        let item: ItemElement
        
        var body: some View {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.8))
                .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 250)
                .cornerRadius(20)
                .padding(5)
                .frame(maxWidth: .infinity)
                .overlay(
                    VStack {
                        Text(item.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                        .padding()
                )
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
