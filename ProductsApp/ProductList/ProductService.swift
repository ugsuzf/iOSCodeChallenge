//
//  ProductService.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation

protocol ProductServiceProtocol {
    func getProducts(request: Product.GetProduct.Request,
                     completion: @escaping (Result<[Product.GetProduct.Response], APIError>) -> Void)
}

final class ProductService: ProductServiceProtocol {
    func getProducts(request: Product.GetProduct.Request,
                     completion: @escaping (Result<[Product.GetProduct.Response], APIError>) -> Void) {
        
        APIService.callService(request: request) { (result: Result<[Product.GetProduct.Response], APIError>) in
            completion(result)
        }
    }
}
