//
//  ApiManager.swift
//  simpletest
//
//  Created by Max Kai on 2021/1/21.
//

import Foundation

class GetCategory {
    
    static let shared = GetCategory()
    
    private init() { }
    
    let session = URLSession.shared
    
    var id: Int?
    
    func getId(handler: @escaping () -> Void) {
        
        guard let urlString = URL(string: "https://blooming-oasis-01056.herokuapp.com/category") else { return }
        
        let task = self.session.dataTask(with: urlString) { (data, _, error) in
            
            if error != nil {
                
                print("Error: \(error!.localizedDescription)")
                
                return
            }
            do {
                
                let json = try JSONDecoder().decode(Category.self, from: data!)
                
                self.id = json.data.shopCategoryList?.categoryList[0].id
                
                handler()
                
                print("!!!!!!!\(self.id!)!!!!!!!!")
                
            } catch {
                
                print("ID Decode Fail.")
            }
        }
        
        task.resume()
    }
    
    func getProduct(handler: @escaping (Category) -> Void) {
            
        guard let urlString = URL(
                string: "https://blooming-oasis-01056.herokuapp.com/product?id=" + String(id ?? 241)) else { return }
            
            let task = self.session.dataTask(with: urlString) { (data, _, error) in
                
                if error != nil {
                    
                    print("Error: \(error!.localizedDescription)")
                    
                    return
                }
                
                do {
                    
                    let product = try JSONDecoder().decode(Category.self, from: data!)
                    
                    handler(product)
                    
                } catch {
                    
                    print("Product Decode Fail.", error)
                }
            }
            
            task.resume()
    }
    
    func getSale(handler: @escaping (Category) -> Void) {
        
        guard let urlString = URL(
                string: "https://blooming-oasis-01056.herokuapp.com/sale?id=" + String(id ?? 241)) else { return }
        
        let task = self.session.dataTask(with: urlString) { (data, _, error) in
            
            if error != nil {
                
                print("Error: \(error!.localizedDescription)")
                
                return
            }
            do {
                
                let saleData = try JSONDecoder().decode(Category.self, from: data!)
                
                handler(saleData)
                
            } catch {
                
                print("Sale Decode Fail.", error)
                
            }
        }
        
        task.resume()
    }
    
    func mixArray(detail:[SalePageListElement], sale:[SalePageListElement]) -> [SalePageListElement] {
        
        var okData: [SalePageListElement] = []
        
        for (index, _) in detail.enumerated() {
            
            let newData = SalePageListElement(
                salePageID: sale[index].salePageID,
                sellingQty: sale[index].sellingQty,
                title: detail[index].title,
                price: detail[index].price,
                suggestPrice: detail[index].suggestPrice,
                isSoldOut: detail[index].isSoldOut,
                isComingSoon: detail[index].isComingSoon,
                sellingStartDateTime: sale[index].sellingStartDateTime)
            
            okData.append(newData)
            
        }
        print(okData)
        return okData
    }
    
}

