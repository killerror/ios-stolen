//
//  FriendsViewController.swift
//  Homework1. UIKit
//
//  Created by Максим Бобков on 19.01.2024.
//

import UIKit

protocol FriendsViewControllerProtocol {
    
    func getFriends()
    func showAlert()
}

final class FriendsViewController: UITableViewController, FriendsViewControllerProtocol {
    
    private let networkService = NetworkService()
            
    private var coreDataService = CoreDataService()
    
    private var model: [Friend] = []
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        
        title = "Friends"
        
        // Создаём кнопку в navigationBar наверху справа для перехода в профиль пользователя
        setProfileButton()
        
        // Достаём сохранённые данные и обновляем список
        model = coreDataService.getFriends()
        tableView.reloadData()
        
        // Для возможности переиспользовать ячейки
        tableView.register(FriendCell.self, forCellReuseIdentifier: "cell")
        
        // Запрашиваем список друзей
        
        // Без параметров. Просто чтобы вывести данные в консоль.
        //NetworkService.getFriends()
        
        getFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    func getFriends() {
        
        // Возможность обновить данные, потянув за экран
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
  
        // Передаём в ф-ю getFriends замыкание, которое в самой ф-и обозначим как @escaping, чтобы после выполнения ф-и сюда вернулся массив, который мы сможем положить в model.
        networkService.getFriends { [weak self] result in
            
            switch result {
                
            case .success(let friends):
                
                self?.model = friends
                self?.coreDataService.saveFriends(friends: friends)
                
                // Поскольку при запросе к другому серверу система переключается на другую очередь, то вручную переводим на основную очередь.
                DispatchQueue.main.async {
                    
                    // Перезагружаем таблицу
                    self?.tableView.reloadData()
                }
                
            case .failure(_):
                
                self?.model = self?.coreDataService.getFriends() ?? []
                
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
    // Определяем количество ячеек в каждом разделе
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //5
        model.count
    }
    
    // Саму ячеку определяем в отдельном классе FriendsCell в отдельном файле
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Если без переиспользования ячеек:
        //FriendCell()
        
        // Проверяем, а точно ли ячейка, полученная через dequeueReusableCell, имеет нужный нам тип - FriendCell.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        
        cell.updateCell(friend: model[indexPath.row])
        
        cell.tap = { [weak self] text, photo in
            self?.navigationController?.pushViewController(ProfileViewController(name: text, photo: photo, isUserProfile: false), animated: true)
        }
        
        return cell
    }
    
    // Создаём кнопку в navigationBar наверху справа для перехода в профиль пользователя
    private func setProfileButton() {
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            style: .plain,
            target: self,
            action: #selector(tap)
        )
    }
    
    
    
    func showAlert() {
        
        let date = DateHelper.getDate(date: coreDataService.getFriendsDate())
        let alert = UIAlertController(
            title: "Не удалось получить данные",
            message: "Данные актуальны на \(date)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



// MARK: objc methods

// Создаём расширение для выноса всех objc-методов, чтобы лучше ориентироваться по коду
private extension FriendsViewController {
    
    // Поведение кнопки в navigationBar наверху справа для перехода в профиль пользователя
    @objc func tap() {
        
        // Задаём анимацию перехода к контроллеру с профилем
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .moveIn
        animation.duration = 1
        
        // Применяем анимацию к текущему контроллеру
        navigationController?.view.layer.add(animation, forKey: nil)
        
        // Переходим к новому контроллеру
        navigationController?.pushViewController(ProfileViewController(isUserProfile: true), animated: false)
    }
    
    // Возможность обновить данные, потянув за экран
    @objc func update() {
        
        networkService.getFriends { [weak self] result in
            
            // Всё то же самое, что и в getFriends(), только в конце ещё добавляется переход на основной поток для остановки процесса апдейта
            
            switch result {
                
            case .success(let friends):
                
                self?.model = friends
                self?.coreDataService.saveFriends(friends: friends)
                
                // Поскольку при запросе к другому серверу система переключается на другую очередь, то вручную переводим на основную очередь.
                DispatchQueue.main.async {
                    
                    // Перезагружаем таблицу
                    self?.tableView.reloadData()
                }
                
            case .failure(_):
                self?.model = self?.coreDataService.getFriends() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            
            // Переход на основной поток для остановки процесса апдейта (иконка лоадера перестанет крутиться)
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}


