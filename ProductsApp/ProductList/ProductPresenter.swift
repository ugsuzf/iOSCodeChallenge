//
//  ProductPresenter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit



final class ProductPresenter: BasePresenter, ProductPresenterProtocol {
    
    
    weak var viewController: ProductsDisplayLogic?
    
    // MARK: Present All Products
    
    func presentProducts(response: [Product.GetProduct.Response]) {
        
        let viewModel = response.map({
            Product.GetProduct.ViewModel(id: $0.id,
                                           name: $0.name,
                                           description: $0.description,
                                           priceWithCurrency: "\($0.price.doubleValue) \($0.currency.stringValue)")
        })
        
        viewController?.displayProducts(viewModel: viewModel)
    }
}
