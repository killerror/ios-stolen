//
//  ImageViewController.swift
//  myProject
//
//  Created by Максим Бобков on 11.01.2024.
//

import UIKit

final class ImageViewController: UIViewController {
    
    private var myImage = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        addConstraints()
    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        myImage.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        view.addSubview(myImage)
    }
    
    private func addConstraints() {
        
        myImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            myImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myImage.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            myImage.heightAnchor.constraint(equalTo: myImage.widthAnchor)
        ])
    }
}
