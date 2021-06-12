//
//  ProductDetailContracts.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 12/06/2021.
//

import Foundation



protocol ProductDetailInteractorProtocol {
    func getProductDetail()
    func getReviews()
    func showAddReviewScene()
}

protocol ProductDetailDataStore {
    var product: Product.GetProduct.ViewModel? { get set }
}

protocol ProductDetailPresenterProtocol {
    func presentProductDetail(response: Product.GetProduct.ViewModel?)
    func presentReviews(response: [ProductDetail.GetReviews.Response])
    func presentAddReviewScene()
}

protocol ProductDetailViewProtocol: class {
    func displayProductDetail(viewModel: Product.GetProduct.ViewModel?)
    func displayReviews(viewModel: [ProductDetail.GetReviews.ViewModel]?)
    func displayAddReviewScene()
}

@objc protocol ProductDetailRouterProtocol {
    func routeToAddReviewScene()
}

protocol ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore? { get }
}

enum ProductDetail {
    // MARK: Use cases
    
    enum GetReviews {
        
        struct Request: RequestProtocol {
            var url: URL?
            var method: RequestMethod = .get
            var parameters: [String: Any]? = nil
            
            init(productId: String) {
                self.url = ServiceUrls.reviews(productId: productId).url
            }
        }
        
        struct Response: Codable {
            let productId: String?
            let locale: String?
            let rating: Int?
            let text: String?
        }
        
        struct ViewModel {
            let rating: String?
            let text: String?
        }
    }
}
