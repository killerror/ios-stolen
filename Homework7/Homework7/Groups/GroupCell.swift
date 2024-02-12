//
//  GroupCell.swift
//  Homework1. UIKit
//
//  Created by Максим Бобков on 20.01.2024.
//

import UIKit

protocol GroupCellProtocol {
    func updateCell(group: Group)
}

final class GroupCell: UITableViewCell, GroupCellProtocol {
    
    // Создаём кружок слева и два лейбла справа
    
    // Кружок - это квадрат со скруглёнными углами
    private var groupAvatar: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20 // Половина длины стороны
        view.clipsToBounds = true // Включаем обрезание по границам
        return view
    }()
    
    private var groupName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .left
        label.textColor = Theme.currentTheme.textColor
        return label
    }()
    
    private var groupDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textAlignment = .left
        label.textColor = Theme.currentTheme.textColor
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // Функции viewDidLoad у ячейки нет, поэтому пользуемся инициализатором
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear // Чтобы ячейка была прозрачной (цвета фона)
        setupUI()
        addConstraints()
    }
    
    // Обязательный инициализатор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // После получения данных с сервера ВК обновляем текст в лейблах и картинку
    func updateCell(group: Group) {
        
        groupName.text = group.name
        groupDescription.text = group.description
        
        groupName.textColor = Theme.currentTheme.textColor
        groupDescription.textColor = Theme.currentTheme.textColor
        
        // Поскольку мы будем получать данные по урл (через try? Data), мы должны предварительно вручную встать на другой поток (в глобальную очередь), а потом также вручную вернуться обратно на главный поток (в основную очередь)
        DispatchQueue.global().async {
            
            // Проверяем урл картинки и следом получаем саму картинку по этому урл через try? Data
            if let url = URL(string: group.photo), let image = try? Data(contentsOf: url) {
                
                DispatchQueue.main.async {
                    self.groupAvatar.image = UIImage(data: image)
                }
            }
        }
    }
}



extension GroupCell {
    
    private func setupUI() {
        
        // В случае с ячейками элементы добавляем не на view, а на contentView, чтобы в дальнейшем наша ячейка могла подстраиваться под размеры отведённой для неё области
        contentView.addSubview(groupAvatar)
        contentView.addSubview(groupName)
        contentView.addSubview(groupDescription)
    }
    
    private func addConstraints() {
        
        groupAvatar.translatesAutoresizingMaskIntoConstraints = false
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            groupAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            groupAvatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            groupAvatar.heightAnchor.constraint(equalToConstant: 40),
            groupAvatar.widthAnchor.constraint(equalTo: groupAvatar.heightAnchor),
            
            // Чтобы ячейка изменяла свои размеры в зависимости от размера контента, нужно привязать один элемент к верху ячейки и один элемент к низу ячейки
            
            // Прижимаем лейбл к верхнему краю ячейки
            groupName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupName.leftAnchor.constraint(equalTo: groupAvatar.rightAnchor, constant: 30),
            groupName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            // Прижимаем лейбл к нижнему краю ячейки
            groupDescription.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 10),
            groupDescription.leftAnchor.constraint(equalTo: groupName.leftAnchor),
            groupDescription.rightAnchor.constraint(equalTo: groupName.rightAnchor),
            groupDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
