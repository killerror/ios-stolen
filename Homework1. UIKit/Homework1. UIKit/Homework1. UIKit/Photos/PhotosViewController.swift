//
//  PhotosViewController.swift
//  Homework1. UIKit
//
//  Created by Максим Бобков on 19.01.2024.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photos"
        
        // Настраиваем переиспользование ячеек, чтобы система не создавала заново каждый раз новую ячейку, иначе будут проблемы с памятью. Система создаст новые ячейки для тех элементов, которые помещаются на экране и те, которые доступны при быстром скролле, а потом система начнёт переисползовать их для следующих ячеек.
        //collectionView.register(CustomCollectionNewCell.self, forCellWithReuseIdentifier: "cell") // Вместо "cell" можно любой набор символов
    }
}
