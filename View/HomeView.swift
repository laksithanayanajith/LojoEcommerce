import SwiftUI
import URLImage

struct HomeView: View {
    
    @State private var isLoading = true
    @State private var items: [ItemElement] = []
    
    var body: some View {
        ZStack {
            VStack {
                
                if isLoading {
                    ProgressView()
                }
                
                if !isLoading {
                    Text("LOJO")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
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
                        self.items = items
                    }
                }
            }
            
        }
    }
    
    struct RectangleItemView: View {
        let item: ItemElement
        
        var body: some View {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 250)
                .cornerRadius(20)
                .padding(5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.8)
                .overlay(
                    
                    VStack(spacing: 0) {
                        URLImage(URL(string: item.defaultImage)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            Text(item.description)
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            Text("$\(String(format: "%.2f", item.price))")
                                .font(.headline)
                                .foregroundColor(.black)
                                .opacity(0.65)
                        }
                        .padding()
                    }
                )
        }
    }

    
    /*
    struct RectangleItemView: View {
        let item: ItemElement
        
        var body: some View {
            VStack {
                URLImage(URL(string: item.defaultImage)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 150) // Adjust size as needed
                }
                .padding(5)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(20)
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
            .padding()
        }
    }
*/
    
       struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
