//
//  HomeTableViewCell.swift
//  simpletest
//
//  Created by Max Kai on 2021/1/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mSRPLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setUi(data: SalePageListElement) {
        
        nameLabel.text = data.title
        
        priceLabel.text = "\(data.price ?? 0)"
        
        mSRPLabel.text = "\(data.suggestPrice ?? 0)"
        
        amountLabel.text = "\(data.sellingQty ?? 0)"
        
        dateLabel.text = timeStringToDate(data.sellingStartDateTime ?? 0)
        
    }
    
    
    func timeStringToDate(_ dateStr: Int) -> String {
        
        let timeInterval: TimeInterval = TimeInterval(dateStr)
        
        let date = Date(timeIntervalSince1970: timeInterval/1000)
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
}
