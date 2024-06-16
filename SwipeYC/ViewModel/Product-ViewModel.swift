//
//  ProductViewModel.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 15/06/24.
//

import Foundation
import SwiftUI


func getProductData() async throws -> [Product] {
    let endpoint = "https://app.getswipe.in/api/public/get"
    
    guard let url = URL(string: endpoint) else { throw ProductDataError.invalidURL }
    
    let (data, response) = try await URLSession.shared.data(from: url)
//    print(data)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw ProductDataError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode([Product].self, from: data)
//        print(decodedData)
        return decodedData
    } catch {
        throw ProductDataError.invalidData
    }
}

enum ProductDataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
