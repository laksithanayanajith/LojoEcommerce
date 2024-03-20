import SwiftUI

struct HomeView: View {
    
    @State private var isLoading = true
    @State private var items: [ItemElement] = []
    
    var body: some View {
        ZStack {
            VStack {
                Text("LOJO")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if isLoading {
                    ProgressView() // Show loading indicator if isLoading is true
                }
                
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
                await fetchItems { items in
                    isLoading = false
                    if let items = items {
                        // Update the state variable with the fetched items
                        self.items = items
                    }
                }
            }
            
        }
    }
    /*
    struct RectangleItemView: View {
        let item: ItemElement
        
        var body: some View {
            Rectangle()
                .foregroundColor(Color.gray)
                .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 250)
                .cornerRadius(20)
                .padding(5)
                .frame(maxWidth: .infinity)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .overlay(
                    VStack {
                        Text(item.name)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        Text(item.description)
                            .font(.caption2)
                            .foregroundColor(.white)
                        Text("\n$" + String(format: "%.2f", item.price))
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                )
        }
    }
    */
    
    struct RectangleItemView: View {
        let item: ItemElement
        @State private var imageURL: String?
        
        var body: some View {
            VStack {
                if let imageURL = imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.8))
                    }
                    .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 150) // Adjust size as needed
                } else {
                    Rectangle()
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 150) // Adjust size as needed
                }
                
                VStack {
                    Text(item.name)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text(item.description)
                        .font(.caption2)
                        .foregroundColor(.white)
                    Text("\n$" + String(format: "%.2f", item.price))
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .onAppear {
                Task{
                    await fetchImageURL(itemID: item.id) { imageURL in
                        self.imageURL = imageURL
                    }
                }
            }
        }
    }

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
