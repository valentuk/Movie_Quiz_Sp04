//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 15.09.2025.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
    
}
