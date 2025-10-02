//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 15.09.2025.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
<<<<<<< HEAD
    
=======
    func didLoadDataFromServer() // сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // сообщение об ошибке загрузки
>>>>>>> 6f60598 (sprint_06)
}
