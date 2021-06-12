//
//  ProductDetailWorker.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit

class ProductDetailBuilder {
    
    let productDetailService: ProductDetailServiceProtocol
    
    init(productDetailService: ProductDetailServiceProtocol) {
        self.productDetailService = productDetailService
    }
    
    func getReviews(request: ProductDetail.GetReviews.Request,
                    completion: @escaping (Result<[ProductDetail.GetReviews.Response], APIError>) -> Void) {
        productDetailService.getReviews(request: request) { (result) in
            completion(result)
        }
    }
}
