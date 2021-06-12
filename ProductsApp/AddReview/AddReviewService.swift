//
//  AddReviewService.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation


protocol AddReviewServiceProtocol {
    func addReview(request: AddReview.Review.Request,
                   completion: @escaping (Result<AddReview.Review.Response, APIError>) -> Void)
}

final class AddReviewService: AddReviewServiceProtocol {
    
    func addReview(request: AddReview.Review.Request,
                   completion: @escaping (Result<AddReview.Review.Response, APIError>) -> Void) {
        
        APIService.callService(request: request) { (result: Result<AddReview.Review.Response, APIError>) in
            completion(result)
        }
    }
}
