//
//  ContentView.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 14/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var product: [Product]?
    @State private var searchText = ""
    @State private var products:[Product] = [
        Product(image: "photo", price: 19.99, productName: "Product 1", productType: "Type A", tax: 1.99),
        Product(image: "photo", price: 29.99, productName: "Product 2", productType: "type B", tax: 2.9)
    ]
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return product ?? products
        } else {
            return product?.filter{$0.productName.lowercased().contains(searchText.lowercased()) } ?? products.filter{$0.productName.lowercased().contains(searchText.lowercased())}
        }
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if isLoading {
                    ProgressView() {
                        Text("Loading products...")
                    }
                }
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredProducts, id: \.self) { product in
                            ProductView(product: product)
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .padding()
            .task {
                do {
                    product = try await getProductData()
                    isLoading = false
                } catch ProductDataError.invalidURL {
                    print("Invalid URL...")
                } catch ProductDataError.invalidData {
                    print("Invalid Data")
                } catch ProductDataError.invalidResponse {
                    print("Invalid Response")
                } catch {
                    print("Unexpected error")
                }
            }
            .navigationTitle("Products")
            .toolbar {
                NavigationLink(destination: AddProductView()) {
                        Image(systemName: "cart.badge.plus")
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText, prompt: "Search for a product")

    }
}



#Preview {
    ContentView()
}
