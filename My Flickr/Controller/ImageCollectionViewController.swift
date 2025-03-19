//
//  ImageCollectionViewController.swift
//  My Flickr
//
//  Created by Ajinkya Jagtap on 19/03/25.
//

import UIKit

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var photos: [ImageData] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pexels Images"
        view.addSubview(collectionView)

        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.frame = view.bounds

        fetchImages()
    }

    private func fetchImages() {
        WebService().fetchImages { [weak self] photos in
            guard let photos = photos else { return }
            
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData() // data get reload and update the UI
            }
        }
    }

    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count // create cells as per count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {return UICollectionViewCell()}
        
        let photo = photos[indexPath.item]
        cell.configure(with: photo.src.large) // configure method called to check cache and set image
        return cell
    }

    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 15) / 2
        return CGSize(width: width, height: width * 1.5) // Set cell height and width
    }
}
