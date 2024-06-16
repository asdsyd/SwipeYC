//
//  ProductView.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 14/06/24.
//

import SwiftUI

//Displays list of products in a card like view with image on left side with aspect ratio of 1:1
struct ProductView: View {
    var product: Product
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(7)
                    
            } placeholder: {
                //incase there is no image this is the default image
                Image(systemName: "square.text.square")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(7)
            }
            
            VStack(alignment: .leading) {
                Text(product.productName)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .foregroundStyle(.white)
                    .background(Color.black)
                    .clipShape(.capsule)
                
                Text(product.productType)
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .foregroundStyle(.white)
                    .background(Color.black)
                    .clipShape(.capsule)
                
                HStack {
                    //Using Zstack to include a background with a thin material to experiment on UI for future
                    ZStack {
                        HStack {
                            Spacer()
                            Text("₹ \(product.tax.formatted())")
                                .frame(maxWidth: 40, alignment: .trailing)
                                .font(.subheadline)
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                                .padding(.vertical, 10)
                                .foregroundStyle(Color.white)
                                .background(Color.black)
                                .clipShape(.capsule)
                        }
                        
                        HStack {
                            Text("₹ \(product.price.formatted())")
                                .frame(maxWidth: 90)
                                .font(.headline)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .foregroundStyle(Color.black)
                                .background(Color.yellow)
                                .clipShape(.capsule)
                            Spacer()
                        }
                        
                        
                    }
                }
            }
            .padding(10)
        }
        .frame(minWidth: 350, minHeight: 180)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(30)
        .padding()
    }
}

#Preview {
    ProductView(product: Product(image: "photo", price: 19.9, productName: "Product 1", productType: "Type A", tax: 1.9))
}
