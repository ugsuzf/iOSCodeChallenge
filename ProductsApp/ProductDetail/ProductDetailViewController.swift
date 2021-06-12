//
//  ProductDetailViewController.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit



final class ProductDetailViewController: BaseViewController, ProductDetailViewProtocol {
    var interactor: ProductDetailInteractorProtocol?
    var router: (NSObjectProtocol & ProductDetailRouterProtocol & ProductDetailDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var reviews: [ProductDetail.GetReviews.ViewModel]?
    
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
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        // Base setup
        baseInteractor = interactor
        interactor.basePresenter = presenter
        presenter.baseViewController = self
    }
 
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = router?.dataStore?.product?.name
        
        interactor?.getProductDetail()
        interactor?.getReviews()
        setupTableView()
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        interactor?.showAddReviewScene()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ReviewTableViewCell.cellIdentifier, bundle: Bundle.main),
                           forCellReuseIdentifier: ReviewTableViewCell.cellIdentifier)
    }
    
    // MARK: Display Logic
    
    func displayProductDetail(viewModel: Product.GetProduct.ViewModel?) {
        nameLabel.text = viewModel?.name
        priceLabel.text = viewModel?.priceWithCurrency
        descriptionLabel.text = viewModel?.description
    }
    
    func displayReviews(viewModel: [ProductDetail.GetReviews.ViewModel]?) {
        reviews = viewModel
        tableView.reloadData()
    }
    
    func displayAddReviewScene() {
        router?.routeToAddReviewScene()
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (reviews?.count).intValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let reviews = reviews,
              let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier,
                                                       for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        let review = reviews[indexPath.row]
        
        cell.configure(with: review)
        
        return cell
    }
}

extension ProductDetailViewController: AddReviewDelegate {
    func newReviewAdded(review: ProductDetail.GetReviews.ViewModel) {
        let count = (reviews?.count).intValue
        reviews?.insert(review, at: count)
        tableView.reloadData()
        
        displayAlert(message: "Your review is added successfully !", type: .information)
    }
}

extension ProductDetailViewController: Instantiable {
    static var storyboardName: String {
        return "ProductDetail"
    }
}
