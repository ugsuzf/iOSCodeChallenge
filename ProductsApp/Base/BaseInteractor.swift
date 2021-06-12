//
//  BaseInteractor.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation




class BaseInteractor: BaseInteractorProtocol, BaseDataStore {
    var basePresenter: BasePresenterProtocol?
    var baseWorker: BaseBuilder?
    
    // MARK: Show Error Alert
    
    func showErrorAlert(with error: APIError) {
        basePresenter?.presentErrorAlert(with: error)
    }
}
