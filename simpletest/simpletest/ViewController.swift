//
//  ViewController.swift
//  simpletest
//
//  Created by Michael Chang on 2021/1/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    var group = DispatchGroup()
    
    var iteamArray: [SalePageListElement] = [] {
        
        didSet {
            
            DispatchQueue.main.async {
                
                self.homeTableView.reloadData()
            }
        }
    }

    @IBOutlet weak var homeTableView: UITableView!
    
    func getData() {
        
        var detail: [SalePageListElement] = []
        
        var sale: [SalePageListElement] = []
        
        group.enter()
        GetCategory.shared.getId {
            self.group.leave()
        }
        
        group.enter()
        GetCategory.shared.getProduct { (category) in
            detail = category.data.shopCategory?.salePageList.salePageList ?? []
            self.group.leave()
        }
        
        group.enter()
        GetCategory.shared.getSale { (category) in
            sale = category.data.shopCategory?.salePageList.salePageList ?? []
            self.group.leave()
        }
        
        group.notify(queue: .global(qos: .default)) {
            
            print("detail", detail)
            
            print("sale", sale)
            
            self.iteamArray = GetCategory.shared.mixArray(detail: detail, sale: sale)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return iteamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.setUi(data: iteamArray[indexPath.row])
        
        return cell
    }
    
    
}
