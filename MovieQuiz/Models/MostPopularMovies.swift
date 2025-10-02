//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 28.09.2025.
//

import Foundation

struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let title: String
    let rating: String?
    let imageURL: URL
    
    var resizedImageURL: URL {
        let urlString = imageURL.absoluteString
        
        guard let newURL = URL(string: urlString) else {
            return imageURL
        }
        return newURL
    }
    private enum CodingKeys: String, CodingKey {
    case title = "fullTitle"
    case rating = "imDbRating"
    case imageURL = "image"
    }
}
