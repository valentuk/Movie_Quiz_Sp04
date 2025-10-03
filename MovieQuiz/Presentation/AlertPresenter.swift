//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 15.09.2025.
//

import UIKit

struct AlertPresenter {
    private let alertModel: AlertModel
    
    weak var viewController: UIViewController?
    
    func requestAlert() {
        
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
    
        let action = UIAlertAction(
            title: alertModel.buttonText,
            style: .default,
            handler: {_ in
                alertModel.completion()
            })
    
        alert.view.accessibilityIdentifier = "quizAlert"
        
        alert.addAction(action)
    
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    init(alertModel: AlertModel) {
        self.alertModel = alertModel
    }
}
