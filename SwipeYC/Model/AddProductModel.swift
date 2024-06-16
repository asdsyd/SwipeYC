//
//  AddProductModel.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 15/06/24.
//

import Foundation
import SwiftUI

//AddProduct model which is used for adding the product in the AddProduct Screen.
struct AddProduct: Codable {
    var product_name: String
    var product_type: String
    var price: Float
    var tax: String
    //Can include the ability to upload Image 1:1 jpg/png for future
    
//    init(product_name: String, product_type: String, price: Float, tax: String) {
//        self.product_name = product_name
//        self.product_type = product_type
//        self.price = price
//        self.tax = tax
//    }
    
    var computedTax: Float {
        guard let tax = Float(tax.self) else { return 0.0 }
        let computedTax = price * tax * 0.01
        
        return computedTax
    }
    
    var hasValidPrice: Bool {
        if price == 0 {
            return false
        }
        return true
    }
    
    var hasValidProductName: Bool {
        if product_name.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
}


// Observable
//class AddProduct: Codable {
//    var product_name: String
//    var product_type: String
//    var price: Float
//    var tax: String
//    //Can include the ability to upload Image 1:1 jpg/png for future
//    
//    init(product_name: String, product_type: String, price: Float, tax: String) {
//        self.product_name = product_name
//        self.product_type = product_type
//        self.price = price
//        self.tax = tax
//    }
//    
//    var computedTax: Float {
//        guard let tax = Float(tax.self) else { return 0.0 }
//        let computedTax = price * tax * 0.01
//        
//        return computedTax
//    }
//    
//    var hasValidPrice: Bool {
//        if price == 0 {
//            return false
//        }
//        return true
//    }
//    
//    var hasValidProductName: Bool {
//        if product_name.trimmingCharacters(in: .whitespaces).isEmpty {
//            return false
//        }
//        return true
//    }
//    
//}
//
