//
//  ProductDetailRouter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit



final class ProductDetailRouter: NSObject, ProductDetailRouterProtocol, ProductDetailDataPassing {
    weak var viewController: ProductDetailViewController?
    var dataStore: ProductDetailDataStore?
    
    // MARK: Routing
    
    func routeToAddReviewScene() {
        let destinationVC = AddReviewViewController.instantiateFromStoryboard()
        destinationVC.delegate = viewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToAddReviewScene(source: dataStore!, destination: &destinationDS)
        navigateToAddReviewScene(source: viewController!, destination: destinationVC)
        
    }
    
    // MARK: Navigation
    
    func navigateToAddReviewScene(source: ProductDetailViewController, destination: AddReviewViewController) {
        source.present(destination, animated: false, completion: nil)
    }
    
    // MARK: Passing data
    
    func passDataToAddReviewScene(source: ProductDetailDataStore, destination: inout AddReviewDataStore) {
        destination.productId = source.product?.id
    }
}
