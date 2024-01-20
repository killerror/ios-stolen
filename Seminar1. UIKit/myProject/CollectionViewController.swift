//
//  CollectionViewController.swift
//  myProject
//
//  Created by Максим Бобков on 11.01.2024.
//

import UIKit

final class CollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.4353337288, green: 0.7163901925, blue: 0.9201350212, alpha: 1)
        collectionView.register(CustomCollectionNewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        guard let cell = cell as? CustomCollectionNewCell else {
            return UICollectionViewCell()
        }
        
        cell.tap = { [weak self] image in
            self?.navigationController?.pushViewController(ImageViewController(image: image), animated: true)
        }
        
        return cell
    }
}

