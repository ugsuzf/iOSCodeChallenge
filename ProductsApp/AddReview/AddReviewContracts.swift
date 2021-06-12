//
//  AddReviewContracts.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 12/06/2021.
//

import Foundation
import UIKit


protocol AddReviewPresenterProtocol {
    func presentMessage()
}

@objc protocol AddReviewRouterProtocol {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AddReviewDataPassing {
    var dataStore: AddReviewDataStore? { get }
}

protocol AddReviewDelegate: class {
    func newReviewAdded(review: ProductDetail.GetReviews.ViewModel)
}

protocol AddReviewViewProtocol: class {
    func displayMessage()
}

protocol AddReviewInteractorProtocol {
    func addReview(with rate: Int, and text: String)
}

protocol AddReviewDataStore {
    var productId: String? { get set }
}





enum AddReview {
    // MARK: Use cases
    
    enum Review {
        struct RequestModel: Codable {
            let productId: String
            let rating: Int
            let text: String
        }
        
        struct Request: RequestProtocol {
            var url: URL?
            var method: RequestMethod = .post
            var parameters: [String: Any]?
            
            init(parameters: RequestModel) {
                self.url = ServiceUrls.reviews(productId: parameters.productId).url
                self.parameters = parameters.dictionary
            }
        }
        
        struct Response: Codable {
            let productId: String
            let rating: Int
            let text: String
        }
        
        struct ViewModel {
            
        }
    }
    
}
