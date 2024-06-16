//
//  ProductModel.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 15/06/24.
//

import Foundation

//Product model which is used for displaying list of products in the ProductView Screen
struct Product: Codable, Hashable {
    var image: String?
    var price: Float
    var productName: String
    var productType: String
    var tax: Float
    
}
