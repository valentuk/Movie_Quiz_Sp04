import UIKit


final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
<<<<<<< HEAD
=======
    func didLoadDataFromServer() {
        activityIndicator.isHidden = true // скрываем индикатор загрузки
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription) // возьмём в качестве сообщения описание ошибки
    }
    
>>>>>>> 6f60598 (sprint_06)
    // MARK: - Lifecycle
    
    private var questionFactory: QuestionFactoryProtocol?
    
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    private let questionAmount: Int = 10
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenter?
    private var statisticService: StatisticService?
    
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var counterLabel: UILabel!
    
<<<<<<< HEAD
=======
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
>>>>>>> 6f60598 (sprint_06)
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.question,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionAmount)")
<<<<<<< HEAD
        return questionStep
=======
>>>>>>> 6f60598 (sprint_06)
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderWidth = 0
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        
        turnOnButtons()
    }
    @IBOutlet weak private var noUIButton: UIButton!
    
    @IBOutlet weak private var yesUIButton: UIButton!
    
    @IBAction private func noActionButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction private func yesActionButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        
        guard let statisticService = statisticService else { return }
        
        let alertModel = AlertModel(
            title: result.title,
            message: """
             Ваш результат: \(statisticService.currentGame.correct)/\(statisticService.currentGame.total)\n Количество сыгранных квизов: \(statisticService.gamesCount)\n Рекорд: \(statisticService.bestGame.correct)/\(statisticService.bestGame.total) (\(statisticService.bestGame.date.dateTimeString))\n Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy*100))%
             """,
            buttonText: result.buttonText,
            completion: { [weak self] in
                guard let self = self else { return }
                
                self.currentQuestionIndex = 0
                
                self.correctAnswers = 0
                
                self.questionFactory?.requestNextQuestion()
            }
        )
        alertPresenter = AlertPresenter(alertModel: alertModel)
        alertPresenter?.viewController = self
        
        alertPresenter?.requestAlert()
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {return}
            self.showNextQuestionOrResults()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticService = StatisticServiceImplementation()
        
<<<<<<< HEAD
        questionFactory = QuestionFactory(delegate: self)
        
        questionFactory?.requestNextQuestion()
        
        
=======
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        
        showLoadingIndicator()
    }
    
    private func showLoadingIndicator() {
        activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
        activityIndicator.startAnimating() // включаем анимацию
        
        textLabel.text = ""
        counterLabel.text = ""
    }
    
    private func hideLoadingIndicator() {
        activityIndicator.isHidden = true // говорим, что индикатор загрузки скрыт
        activityIndicator.startAnimating() // включаем анимацию
    }
    
    private func showNetworkError(message: String) {
        hideLoadingIndicator() // скрываем индикатор загрузки
        
        // создайте и покажите алерт
        
        let alertModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз",
            completion: { [weak self] in
                guard let self = self else { return }
                
                self.showLoadingIndicator()
                self.questionFactory?.loadData()
                            
            }
        )
        alertPresenter = AlertPresenter(alertModel: alertModel)
        alertPresenter?.viewController = self
        
        alertPresenter?.requestAlert()
>>>>>>> 6f60598 (sprint_06)
    }
    
    private func turnOnButtons() {
        yesUIButton.isEnabled = true
        noUIButton.isEnabled = true
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionAmount - 1 {
            
            statisticService?.store(correct: correctAnswers, total: questionAmount)
            
            let text = correctAnswers == questionAmount ?
            "Поздравляем, Вы ответили на 10 из 10!" :
            "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз!"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
        }
    }
    
    // MARK: - QuestionFactoryDelegate
    
    func didRecieveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    func didShowAlert(alert: UIAlertController?) {
        guard let alert = alert else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}



















