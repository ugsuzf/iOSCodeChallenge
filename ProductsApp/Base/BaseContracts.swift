//
//  BaseContracts.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 12/06/2021.
//

import Foundation



protocol BasePresenterProtocol {
    func presentErrorAlert(with error: APIError)
}
protocol BaseInteractorProtocol {
    func showErrorAlert(with error: APIError)
}

protocol BaseDataStore {
    
}

protocol BaseViewProtocol: class {
    func displayErrorAlert(with error: APIError)
    func displayAlert(message: String, type: AlertType)
}


@objc protocol BaseRouterProtocol {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol BaseDataPassing {
    var dataStore: BaseDataStore? { get }
}

enum Base {
    // MARK: Use cases
    
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}

enum AlertType: String {
    case error = "Error"
    case information = "Information"
}
