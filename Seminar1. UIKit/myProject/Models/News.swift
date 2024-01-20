//
//  News.swift
//  myProject
//
//  Created by Максим Бобков on 15.01.2024.
//

struct NewsResults: Decodable {
    let results: [News]
}

struct News: Decodable {
    let publicationDate: Int
    let title: String
    let bodyText: String
    
    enum CodingKeys: String, CodingKey {
        case publicationDate = "publication_date"
        case title
        case bodyText = "body_text"
    }
}


