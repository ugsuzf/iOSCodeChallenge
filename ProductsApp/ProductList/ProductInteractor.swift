//
//  ProductInteractor.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation


final class ProductInteractor: BaseInteractor, ProductsInteractorProtocol, ProductsDataStore {
    var presenter: ProductPresenterProtocol?
    var worker: ProductBuilder = ProductBuilder(productsService: ProductService())
    
    // MARK: Get all products
    
    func getProducts() {
        worker.getProducts(request: Product.GetProduct.Request()) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentProducts(response: response)
                print(response)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(with: error)
                }
                
            }
        }
    }
}
