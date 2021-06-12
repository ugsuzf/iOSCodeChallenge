//
//  ProductRouter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit


final class ProductsRouter: NSObject, ProductRouterProtocol, ProductsDataPassing {
    weak var viewController: ProductsViewController?
    var dataStore: ProductsDataStore?
    
    // MARK: Routing
    
    func routeToProductDetail(with product: Product.GetProduct.ViewModel?) {
        let destinationVC = ProductDetailViewController.instantiateFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        destinationDS.product = product
        navigateToProductDetail(source: viewController!, destination: destinationVC)
        
    }
    
    
    // MARK: Navigation
    
    
    func navigateToProductDetail(source: ProductsViewController, destination: ProductDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ProductsDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

