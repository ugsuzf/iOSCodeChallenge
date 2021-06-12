//
//  BasePresenter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation



class BasePresenter: BasePresenterProtocol {
    weak var baseViewController: BaseViewProtocol?
    
    // MARK: Present Alert
    
    func presentErrorAlert(with error: APIError) {
        baseViewController?.displayErrorAlert(with: error)
    }
}
