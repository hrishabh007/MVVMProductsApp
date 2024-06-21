//
//  ProductCell.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 29/05/24.
//

import Kingfisher
import UIKit

class ProductCell: UITableViewCell {
  @IBOutlet weak var productBackgroundView: UIView!
  @IBOutlet weak var productTitleLabel: UILabel!
  @IBOutlet weak var productCategoryLabel: UILabel!
  @IBOutlet weak var rateButton: UIButton!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var productImage: UIImageView!
  var product: Product? {
    didSet {
      productDetailConfiguration()
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  func productDetailConfiguration() {
    guard let product else { return }
    productTitleLabel.text = product.title
    productCategoryLabel.text = product.category
    descriptionLabel.text = product.description
    priceLabel.text = "$\(product.price)"
    rateButton.setTitle("\(product.rating.rate)", for: .normal)

    let url = URL(string: product.image)

    productImage.kf.indicatorType = .activity
    productImage.kf.setImage(
      with: url,
      placeholder: UIImage(named: "placeholderImage"),
      options: [
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage,
      ]
    ) {
      result in
      switch result {
      case .success(let value):
        print("Task done for: \(value.source.url?.absoluteString ?? "")")
      case .failure(let error):
        print("Job failed: \(error.localizedDescription)")
      }
    }
  }

}
