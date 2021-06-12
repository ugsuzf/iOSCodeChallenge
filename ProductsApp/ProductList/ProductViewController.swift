//
//  ProductViewController.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit


final class ProductsViewController: BaseViewController, ProductsDisplayLogic {
    var interactor: ProductsInteractorProtocol?
    var router: (NSObjectProtocol & ProductRouterProtocol & ProductsDataPassing)?
    
 
    @IBOutlet weak var tableView: UITableView!
    
    
    private var products: [Product.GetProduct.ViewModel]?
    private var filteredProducts: [Product.GetProduct.ViewModel]?

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
        let interactor = ProductInteractor()
        let presenter = ProductPresenter()
        let router = ProductsRouter()
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
        
        // Navigation back button
        let backItem = UIBarButtonItem(title: nil)
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
        
        setupTableView()
        
        showIndicator()
        interactor?.getProducts()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ProductViewCell.cellIdentifier, bundle: .main),
                           forCellReuseIdentifier: ProductViewCell.cellIdentifier)
    }
    
    // MARK: Display Logic
    
    func displayProducts(viewModel: [Product.GetProduct.ViewModel]) {
        hideIndicator()
        products = viewModel
        filteredProducts = products
        tableView.reloadData()
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (filteredProducts?.count).intValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let products = filteredProducts,
              let cell = tableView.dequeueReusableCell(withIdentifier: ProductViewCell.cellIdentifier,
                                                       for: indexPath) as? ProductViewCell else {
            return UITableViewCell()
        }
        
        let product = products[indexPath.row]
        cell.configure(with: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts?[indexPath.row]
        
        router?.routeToProductDetail(with: selectedProduct)
    }
}

extension ProductsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let products = products else {
            return
        }
        
        if searchText != "" {
            filteredProducts = products.filter({ (product) -> Bool in
                (product.name?.lowercased().contains(searchText.lowercased())).boolValue || (product.description?.lowercased().contains(searchText.lowercased())).boolValue
            })
        } else {
            filteredProducts = products
        }
        
        tableView.reloadData()
    }
}

extension ProductsViewController: Instantiable {
    static var storyboardName: String {
        return "Products"
    }
}
