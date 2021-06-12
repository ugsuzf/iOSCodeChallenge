//
//  BaseRouter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation



final class BaseRouter: NSObject, BaseRouterProtocol, BaseDataPassing {
    weak var baseViewController: BaseViewController?
    var dataStore: BaseDataStore?
}
