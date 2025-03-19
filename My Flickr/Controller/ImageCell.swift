//
//  ImageCell.swift
//  My Flickr
//
//  Created by Ajinkya Jagtap on 19/03/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"

    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 15
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with urlString: String) {
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            imageView.image = cachedImage // If image availabel in cache
        } else {
            fetchImage(from: urlString) // If image is not availabel in cache then api get called for that specific image
        }
    }

    private func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            ImageCache.shared.setImage(image, forKey: urlString) // Image data get set in cache
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
