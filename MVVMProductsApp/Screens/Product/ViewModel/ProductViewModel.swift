//
//  ProductViewModel.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 29/05/24.
//

import Foundation

final class ProductViewModel {
  var products: [Product] = []
  var eventHandler: ((_ event: Event) -> Void)?  //data binding Cousure
  func fetchProducts() {
    self.eventHandler?(.loading)
    ApiManager.shared.fetchProducts {
      responce in
      self.eventHandler?(.stopLoading)
      switch responce {
      case .success(let products):
        self.products = products
        self.eventHandler?(.dataLoaded)
      case .failure(let error):
        self.eventHandler?(.error(error))
      }
    }
  }

}
extension ProductViewModel {
  enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
  }
}
