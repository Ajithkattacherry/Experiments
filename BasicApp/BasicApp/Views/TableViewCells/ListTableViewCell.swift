//
//  ListTableViewCell.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var imgView: CachedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ list: ListDataModel?) {
        guard let list = list else {
            return
        }
        lblTitle.text = list.title
        lblDescription.text = list.values.description
        imgView.loadImage(from: list.values.imageName, placeholder: "Aji")
        //imgView.kf.setImage(with: URL(string: list.values.imageName))
//        loadImage(from: list.values.imageName) { [weak self] (image) in
//            DispatchQueue.main.async {
//                guard let self = self else { return }
//                self.imgView?.image = image ?? UIImage()
//                self.imgView?.contentMode = .scaleAspectFill
//                self.setNeedsLayout()
//            }
//        }
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                guard let url = URL(string: urlString) else {
                    return completion(nil)
                }
                let data = try Data(contentsOf: url)
                print("data: \(data)")
                completion(UIImage(data: data))
            } catch {
                completion(nil)
            }
        }
    }

}
