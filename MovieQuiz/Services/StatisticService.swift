//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by  Павел Валентюк on 15.09.2025.
//

import Foundation

struct GameRecord: Codable, Comparable {
    let correct: Int //Количество правильных ответов
    let total: Int //Количество вопросов квиза
    let date: Date //Дата завершения раунда
    
    static func < (lhs: GameRecord, rhs: GameRecord) -> Bool {
        
        //Решил сравнивать через процент чтоб если мы захотим изменить количество вопросов то статистика осталась релевантной
        let lhsPercent = lhs.total == 0 ? 0.0 : Double(lhs.correct) / Double(lhs.total)
        let rhsPercent = rhs.total == 0 ? 0.0 : Double(rhs.correct) / Double(rhs.total)
        
        return lhsPercent < rhsPercent
    }
}

struct Top: Codable {
    let totalAccuracy: Double
    let gamesCount: Int
    let bestGame: GameRecord
}

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    
    var totalAccuracy: Double { get } // Отображает среднюю точность правильных ответов за все игры в процентах.
    var gamesCount: Int { get } // Количество завершённых игр.
    var bestGame: GameRecord { get } //Информация о лучшей попытке.
    
    var currentGame: GameRecord { get set }
}

final class StatisticServiceImplementation: StatisticService {
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount, correctTotal, questionsTotal
    }
    
    var currentGame: GameRecord
    
    private let userDefaults = UserDefaults.standard
    
    private(set) var correctTotal: Int  {
        get {
            userDefaults.integer(forKey: Keys.correctTotal.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Keys.correctTotal.rawValue)
        }
    }
    
    private(set) var questionsTotal: Int  {
        get {
            userDefaults.integer(forKey: Keys.questionsTotal.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Keys.questionsTotal.rawValue)
        }
    }
    
    private(set) var totalAccuracy: Double {
        get {
            userDefaults.double(forKey: Keys.total.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    private(set) var gamesCount: Int  {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    private(set) var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        
        gamesCount += 1
        correctTotal = correctTotal + count
        questionsTotal = questionsTotal + amount
        
        totalAccuracy = Double(correctTotal) / Double(questionsTotal)
        
        currentGame = GameRecord(correct: count, total: amount, date: Date())
        
        if bestGame < currentGame {
            bestGame = currentGame
        }
        
    }
    init() {
        currentGame = GameRecord(correct: 0, total: 0, date: Date())
    }
}
