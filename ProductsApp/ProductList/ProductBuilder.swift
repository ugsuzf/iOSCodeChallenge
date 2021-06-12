//
//  ProductWorker.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation


class ProductBuilder {
    let productsService: ProductServiceProtocol
    
    init(productsService: ProductServiceProtocol) {
        self.productsService = productsService
    }
    
    func getProducts(request: Product.GetProduct.Request,
                     completion: @escaping (Result<[Product.GetProduct.Response], APIError>) -> Void) {
        productsService.getProducts(request: request) { (result) in
            completion(result)
        }
    }
}
