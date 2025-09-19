//
//  ResultAlertModel.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 15.09.2025.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
