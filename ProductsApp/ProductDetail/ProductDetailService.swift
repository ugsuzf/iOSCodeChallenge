//
//  ProductDetailService.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation

protocol ProductDetailServiceProtocol {
    func getReviews(request: ProductDetail.GetReviews.Request,
                    completion: @escaping (Result<[ProductDetail.GetReviews.Response], APIError>) -> Void)
}

final class ProductDetailService: ProductDetailServiceProtocol {
    
    func getReviews(request: ProductDetail.GetReviews.Request,
                    completion: @escaping (Result<[ProductDetail.GetReviews.Response], APIError>) -> Void) {
        
        APIService.callService(request: request) { (result: Result<[ProductDetail.GetReviews.Response], APIError>) in
            completion(result)
        }
    }
}
