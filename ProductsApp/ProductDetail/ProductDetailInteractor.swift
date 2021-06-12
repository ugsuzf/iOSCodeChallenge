//
//  ProductDetailInteractor.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit



final class ProductDetailInteractor: BaseInteractor, ProductDetailInteractorProtocol, ProductDetailDataStore {
    var presenter: ProductDetailPresenterProtocol?
    var worker: ProductDetailBuilder = ProductDetailBuilder(productDetailService: ProductDetailService())
    
    var product: Product.GetProduct.ViewModel?
    
    // MARK: Get Product Detail
    
    func getProductDetail() {
        presenter?.presentProductDetail(response: product)
    }
    
    func getReviews() {
        guard let productId = product?.id else {
            return
        }

        worker.getReviews(request: ProductDetail.GetReviews.Request(productId: productId)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentReviews(response: response)
            case .failure(let error):
                self?.showErrorAlert(with: error)
            }
        }
    }
    
    func showAddReviewScene() {
        presenter?.presentAddReviewScene()
    }
}
