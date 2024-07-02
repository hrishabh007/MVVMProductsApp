//
//  AddProductViewController.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 01/07/24.
//

import UIKit

struct AddProduct: Codable {
  var id: Int? = nil
  let title: String
}

//struct AddProduct: Encodable ,Decodable{
//    var id: Int
//  let title: String
//}
//
//struct ProductResponse: Decodable {
//  let id: Int
//  let title: String
//}

class AddProductViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    addProduct()
  }

  //simple post request
  func addProduct() {
    guard let url = URL(string: "https://dummyjson.com/products/add") else { return }

    let parameter = AddProduct(title: "BMW Car")
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // Model to Data Convert (JSONEncoder() + Encodable)
    request.httpBody = try? JSONEncoder().encode(parameter)
    request.allHTTPHeaderFields = ["Content-Type": "application/json"]

    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data else { return }
      do {
        // Data to Model convert - JSONDecoder() + Decodable
        let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
        print(productResponse)

      } catch {
        print(error)
      }
    }.resume()
  }

}
