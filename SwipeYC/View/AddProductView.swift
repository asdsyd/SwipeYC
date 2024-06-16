//
//  AddProductView.swift
//  SwipeYC
//
//  Created by Asad Sayeed on 15/06/24.
//

import SwiftUI

struct AddProductView: View {
    @State private var showingAlert = false
    @State private var showingError = false
    
    @State private var isRunning = false
    
    @State private var listOfProductType = ["Electronics", "Furniture", "Medicines", "Product", "Misc"]
    
    @State private var taxRate = ["0.0", "5.0", "12.0", "18.0", "28.0"]
    
    @State private var addProduct = AddProduct(product_name: "", product_type: "Electronics", price: 0.0, tax: "5.0")
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Section("Enter Product details*") {
                            Picker("Select Product Type",selection: $addProduct.product_type) {
                                ForEach(listOfProductType, id: \.self) { type in
                                    Text(type)
                                }
                            }
                            
                            TextField("Product Name", text: $addProduct.product_name)
                            
                            HStack {
                                //Product price uses Float type
                                Text("Selling Price:")
                                Spacer()
                                TextField("Selling Price:", value: $addProduct.price, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                            }
                        }
                        
                        //Tax Rate Segmented Picker uses String type for tax
                        Section("Tax Rate*") {
                            Picker("Tax Rate:", selection: $addProduct.tax) {
                                ForEach(taxRate, id: \.self) {
                                    Text("\($0)%")
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            Text("Selected value: \(addProduct.tax) % -> ₹\(addProduct.computedTax.formatted())")
                            
                        }
                        
                        //Submit button
                        Button {
                            isRunning = true
                            Task {
                                do {
                                    let success = try await addProductData(product: addProduct)
                                    if success {
                                        showingAlert = true
                                    }
                                } catch {
                                    showingError = true
                                }
                                isRunning = false
                                
                            }
                        } label: {
                            Text("Submit")
                                .frame(maxWidth: 90)
                                .font(.headline)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .foregroundStyle(Color.black)
                                .background(Color.yellow)
                                .clipShape(.capsule)
                        }
                        .buttonStyle(.plain)
                        //Button validation here (check AddProductModel for the methods)
                        .disabled(isRunning || !addProduct.hasValidProductName || !addProduct.hasValidPrice)
                    
                    }
                }
            }
            .navigationTitle("Add Product")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("✅"),
                      message: Text("Product successfully added."),
                      dismissButton: .default(Text("OK"))
                )
            }
            .alert("❌\nError in adding product", isPresented: $showingError) {
                Button("OK") { }
            }
//            .alert(isPresented: $showingError) {
//                Alert(title: Text("❌"),
//                      message: Text("Error in adding product."),
//                      dismissButton: .default(Text("Dismiss"))
//                )
//            }
        }
    }
}

#Preview {
    AddProductView()
}
