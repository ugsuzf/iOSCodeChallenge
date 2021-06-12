//
//  AddReviewWorker.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//


import UIKit

class AddReviewBuilder {
    
    let addReviewService: AddReviewServiceProtocol
    
    init(addReviewService: AddReviewServiceProtocol) {
        self.addReviewService = addReviewService
    }
    
    func addReview(request: AddReview.Review.Request,
                   completion: @escaping (Result<AddReview.Review.Response, APIError>) -> Void) {
        addReviewService.addReview(request: request) { (result) in
            completion(result)
        }
    }
}
