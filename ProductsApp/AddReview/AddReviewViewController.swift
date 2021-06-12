//
//  AddReviewViewController.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit


final class AddReviewViewController: UIViewController, AddReviewViewProtocol {
    var interactor: AddReviewInteractorProtocol?
    var router: (NSObjectProtocol & AddReviewRouterProtocol & AddReviewDataPassing)?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var rateButtonStackView: UIStackView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    var selectedRate: Int = 1
    
    weak var delegate: AddReviewDelegate?
    
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
        let viewController = self
        let interactor = AddReviewInteractor()
        let presenter = AddReviewPresenter()
        let router = AddReviewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, view.frame.size.height, 0)
        self.containerView.layer.transform = transform
        
        commentTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisappear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        UIView.animate(withDuration: 0.4) {
            self.containerView.layer.transform = CATransform3DIdentity
        }
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.4) {
                self.containerViewHeightConst.constant += keyboardHeight
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: Notification) {
        
    }
    
    @objc func textFieldEditingChanged() {
        
        if commentTextField.text != "" {
            submitButton.isEnabled = true
            submitButton.alpha = 1
        } else {
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        rateButtonStackView.arrangedSubviews.forEach({ $0.backgroundColor = .gray })
        sender.backgroundColor = .black
        selectedRate = (sender.title(for: .normal)).intValue
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        if let text = commentTextField.text {
            interactor?.addReview(with: selectedRate, and: text)
        }
    }
    
    func dismissModal(completion: (() -> Void)? = nil) {
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, view.frame.size.height, 0)
        
        commentTextField.resignFirstResponder()
       
        
        UIView.animate(withDuration: 0.4, animations: {
            self.containerView.layer.transform = transform
        }, completion: { _ in
            self.dismiss(animated: true, completion: {
                completion?()
            })
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        if touch.view != containerView {
            dismissModal()
        }
    }
    
    // MARK: Display Logic
    
    func displayMessage() {
        let review = ProductDetail.GetReviews.ViewModel(rating: String(selectedRate), text: commentTextField.text)
        
        dismissModal {
            self.delegate?.newReviewAdded(review: review)
        }
    }
}

extension AddReviewViewController: Instantiable {
    static var storyboardName: String {
        return "AddReview"
    }
}

