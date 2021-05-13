//
//  DevExamTableViewCell.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import UIKit

class DevExamTableViewCell: UITableViewCell {
    
    static let cellIdentifare = "DevExamTableViewCell"
    
    // MARK: - @IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    public func getImage(from string: String) -> UIImage? {
        
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        if let cachedImage = DevExamInteractor.shared.imageCached.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            
            image = UIImage(data: data)
            
            if let image = image {
                DevExamInteractor.shared.imageCached.setObject(image, forKey: url.absoluteString as NSString)
            }
            else {return nil}
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
    
    
    func setupCell(data: [News], indexPath: IndexPath) {
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.black.cgColor
        let item = data[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let theDate = formatter.date(from: "\(item.date)")
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let date = newDateFormater.string(from: theDate!)
        
        
        DispatchQueue.global().async {
            let string = "http://dev-exam.l-tech.ru\(item.image)"
            let image = self.getImage(from: string)!
    
        DispatchQueue.main.async {
            
            self.mainImage.image = image
        }
        }
        self.dateLabel.text = "\(date)"
        self.detailLabel.text = item.text
        self.titleLabel.text = item.title
        
        
    }
}
