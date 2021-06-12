//
//  ProductDetailPresenter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//


import UIKit



final class ProductDetailPresenter: BasePresenter, ProductDetailPresenterProtocol {
    weak var viewController: ProductDetailViewProtocol?
    
    // MARK: Present Product Detail
    
    func presentProductDetail(response: Product.GetProduct.ViewModel?) {
        viewController?.displayProductDetail(viewModel: response)
    }
    
    func presentReviews(response: [ProductDetail.GetReviews.Response]) {
        
        let viewModel = response.map({
            return ProductDetail.GetReviews.ViewModel(rating: $0.rating.stringValue, text: $0.text)
        })
        
        viewController?.displayReviews(viewModel: viewModel)
    }
    
    func presentAddReviewScene() {
        viewController?.displayAddReviewScene()
    }
}
