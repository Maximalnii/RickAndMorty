//
//  UIImageViewExtension.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 29.11.2023.
//

import UIKit

extension UIImageView {
    
    func downloaded(from link: String) {

        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "logo")
                }
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
