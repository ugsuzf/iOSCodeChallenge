//
//  BaseViewController.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit



class BaseViewController: UIViewController, BaseViewProtocol {
    var baseInteractor: BaseInteractorProtocol?
    var baseRouter: (NSObjectProtocol & BaseRouterProtocol & BaseDataPassing)?
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let baseViewController = self
        let baseInteractor = BaseInteractor()
        let basePresenter = BasePresenter()
        let baseRouter = BaseRouter()
        baseViewController.baseInteractor = baseInteractor
        baseViewController.baseRouter = baseRouter
        baseInteractor.basePresenter = basePresenter
        basePresenter.baseViewController = baseViewController
        baseRouter.baseViewController = baseViewController
        baseRouter.dataStore = baseInteractor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showIndicator() {
        view.addSubview(indicator)
        indicator.center = view.center
        indicator.startAnimating()
        
    }
    
    func hideIndicator() {
        indicator.removeFromSuperview()
    }
    
    // MARK: Display Logic
    
    func displayErrorAlert(with error: APIError) {
        displayAlert(message: error.message, type: .error)
    }
    
    func displayAlert(message: String, type: AlertType) {
        let alertController = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Okay", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}


