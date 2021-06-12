//
//  ProductListContracts.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 12/06/2021.
//

import Foundation

protocol ProductsInteractorProtocol {
    func getProducts()
}

protocol ProductsDataStore {

}

protocol ProductsDisplayLogic: class {
    func displayProducts(viewModel: [Product.GetProduct.ViewModel])
}


protocol ProductRouterProtocol {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToProductDetail(with product: Product.GetProduct.ViewModel?)
}

protocol ProductsDataPassing {
    var dataStore: ProductsDataStore? { get }
}

protocol ProductPresenterProtocol {
    func presentProducts(response: [Product.GetProduct.Response])
}



enum Product {
    // MARK: Use cases
    
    enum GetProduct {
        
        struct RequestModel: Codable {
            let productId: String
            let rating: Int
            let text: String
        }
        
        struct Request: RequestProtocol {
            var url: URL? = ServiceUrls.allProducts.url
            var method: RequestMethod = .get
            var parameters: [String: Any]?
        }
        
        struct Response: Codable {
            let currency: String?
            let price: Double?
            let id: String?
            let name: String?
            let description: String?
        }
        
        struct ViewModel {
            let id: String?
            let name: String?
            let description: String?
            let priceWithCurrency: String?
        }
    }
}
