//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 10.09.2025.
//

import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    
    weak var delegate: QuestionFactoryDelegate?
    
    func requestNextQuestion() {
        let index = (0..<questions.count).randomElement() ?? 0
        let question = questions[safe: index]
        delegate?.didRecieveNextQuestion(question: question)
    }
    
    init(delegate: QuestionFactoryDelegate?) {
        self.delegate = delegate
    }
    
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            question: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
    ]
}


