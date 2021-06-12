//
//  AddReviewPresenter.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//


import UIKit


final class AddReviewPresenter: AddReviewPresenterProtocol {
    weak var viewController: AddReviewViewProtocol?
    
    // MARK: Present Adding Review Result
    
    func presentMessage() {
        viewController?.displayMessage()
    }
}
