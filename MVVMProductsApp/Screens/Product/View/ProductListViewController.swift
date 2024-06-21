//
//  ProductListViewController.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 29/05/24.
//

import UIKit

class ProductListViewController: UIViewController {

  @IBOutlet weak var productTableView: UITableView!

  private var viewModel = ProductViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.

    configure()
  }

  /*; #warning("[NoBlockComments] replace block comment with line comments")
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductListViewController {
  func configure() {

    productTableView.register(
      UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    initViewModel()
    observeEvent()

  }
  func initViewModel() {
    viewModel.fetchProducts()

  }
  // Data binding event observe karega - communication
  func observeEvent() {
    viewModel.eventHandler = {
      [weak self]
      event in
      guard let self else {
        return
      }
      switch event {
      case .loading: break
      case .dataLoaded:
        DispatchQueue.main.async {

          self.productTableView.reloadData()
        }
        //          do {
        //              let jsonData = try JSONEncoder( ).encode(self.viewModel.products)
        //              if let jsonString = String(data: jsonData, encoding: .utf8) {
        //                  print("JSON String: \(jsonString)")
        //              }
        //          } catch {
        //              print("Failed to encode product: \(error)")
        //          }
        print(self.viewModel.products)
      case .stopLoading: break
      case .error(let error): print(error)
      }
    }

  }
}
// MARK: - CodeAI Output
// *** PLEASE SUBSCRIBE TO GAIN CodeAI ACCESS! ***
/// To subscribe, open CodeAI MacOS app and tap SUBSCRIBE
extension ProductListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.products.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell
    else {
      return UITableViewCell()

    }
    let product = viewModel.products[indexPath.row]
    cell.product = product
    return cell
  }

}
