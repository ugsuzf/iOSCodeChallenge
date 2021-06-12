//
//  AddReviewRouter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit


final class AddReviewRouter: NSObject, AddReviewRouterProtocol, AddReviewDataPassing {
    weak var viewController: AddReviewViewController?
    var dataStore: AddReviewDataStore?
    
    
    // MARK: Navigation
    
    func navigateToBack(source: AddReviewViewController, destination: ProductDetailViewController)
    {
      source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToBack(source: AddReviewDataStore, destination: inout ProductDetailDataStore) {
//      destination.name = source.name
    }
}
