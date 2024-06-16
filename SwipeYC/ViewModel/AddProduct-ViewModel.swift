//
//  AddProduct-ViewModel.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 15/06/24.
//

import Foundation
import PhotosUI
import SwiftUI

func addProductData(product: AddProduct) async throws -> Bool {
    
//    guard let encoded = try? JSONEncoder().encode(product) else {
//        throw AddProductDataError.encodingError
//    }
    let endpoint = "https://app.getswipe.in/api/public/add"
    
    guard let url = URL(string: endpoint) else { throw AddProductDataError.invalidURL }
    print("Hello workld ")
    
    let boundary = "Boundary-\(UUID().uuidString)"
    
    var request = URLRequest(url: url)
//    request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    
    let body = createMultipartFormDataBody(for: product, boundary: boundary)
    print(body)
    request.httpMethod = "POST"
    
    let (data, response) = try await URLSession.shared.upload(for: request, from: body)
    
    print("data response")
    print(request.value)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        print("rspon here below")
        print(response)
        throw ProductDataError.invalidResponse
    }

    print(response)
    
    do {
        let decoder = try JSONDecoder().decode(Response.self, from: data)
        print(decoder.message)
        if decoder.success {
            return true
        }
    } catch {
        throw AddProductDataError.invalidData
    }
    return false
}

func createMultipartFormDataBody(for product: AddProduct, boundary: String) -> Data {
    var body = Data()
    
    // Add product properties
    body.append("--\(boundary)\r\n")
    body.append("Content-Disposition: form-data; name=\"product_name\"\r\n\r\n")
    body.append("\(product.product_name)\r\n")
    
    body.append("--\(boundary)\r\n")
    body.append("Content-Disposition: form-data; name=\"product_type\"\r\n\r\n")
    body.append("\(product.product_type)\r\n")
    
    body.append("--\(boundary)\r\n")
    body.append("Content-Disposition: form-data; name=\"price\"\r\n\r\n")
    body.append("\(product.price)\r\n")
    
    body.append("--\(boundary)\r\n")
    body.append("Content-Disposition: form-data; name=\"tax\"\r\n\r\n")
    body.append("\(product.tax)\r\n")
    
    body.append("--\(boundary)--\r\n")
    
    return body
}

public extension Data {

    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8
    ) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
}

struct Response: Decodable {
    let message: String
    let success: Bool
}

enum AddProductDataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case encodingError
}
