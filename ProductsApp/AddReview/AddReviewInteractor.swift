//
//  AddReviewInteractor.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit


final class AddReviewInteractor: BaseInteractor, AddReviewInteractorProtocol, AddReviewDataStore {
    var presenter: AddReviewPresenterProtocol?
    var worker: AddReviewBuilder = AddReviewBuilder(addReviewService: AddReviewService())
    
    var productId: String?
    
    // MARK: Add Review
    
    func addReview(with rate: Int, and text: String) {
        guard let productId = productId else {
            return
        }
        
        let params = AddReview.Review.RequestModel(productId: productId, rating: rate, text: text)
        
        worker.addReview(request: AddReview.Review.Request(parameters: params)) { [weak self] result in
            switch result {
            case .success( _):
                self?.presenter?.presentMessage()
            case .failure(let error):
                self?.showErrorAlert(with: error)
            }
        }
    }
}
