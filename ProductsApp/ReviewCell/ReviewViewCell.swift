//
//  ReviewViewCell.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configure(with viewModel: ProductDetail.GetReviews.ViewModel?) {
        rateLabel.text = viewModel?.rating
        commentLabel.text = viewModel?.text
    }
}
