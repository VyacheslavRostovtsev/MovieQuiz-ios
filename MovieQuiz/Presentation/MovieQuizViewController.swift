import UIKit
final class MovieQuizViewController: UIViewController {
    
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    
    private var currentQuestionIndex: Int = 0
    private let questionsAmount: Int = 10
    private let questionFactory: QuestionFactory = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    //private lazy var currentQuestion = questions[currentQuestionIndex]
    private var correctAnswer: Int = 0
    private var allowAnswer: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        show(quiz: convert(model: currentQuestion))
        
    }
    
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
                    image: UIImage(named: model.image) ?? UIImage(),
                    question: model.text,
                    questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
                       
        if isCorrect == true {
            imageView.layer.borderColor = UIColor(named: "green")?.cgColor
            correctAnswer += 1
        } else {
            imageView.layer.borderColor = UIColor(named: "red")?.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            guard let self = self else {return}
            self.showNextQuestionOrResults()
        }
    }
    
    private func showNextQuestionOrResults() {
      if currentQuestionIndex == questions.count - 1 {
          let viewModel = QuizResultsViewModel (title: "Этот раунд окончен",text: "Ваш результат: \(correctAnswer) из 10",buttonText: "Сыграть еще раз")
          show(quiz: viewModel)
      } else {
          currentQuestionIndex += 1
          imageView.layer.masksToBounds = true
          imageView.layer.borderWidth = 0
          allowAnswer = true
          if let nextQuestion = questionFactory.requestNextQuestion() {
              currentQuestion = nextQuestion
              let viewModel = convert(model: nextQuestion)
              
              show(quiz: viewModel)
          }
          let viewModel = convert(model: nextQuestion)
          show(quiz: viewModel)
          
      }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
            
        let action = UIAlertAction(
            title: result.buttonText,
            style: .default) {[weak self]_ in
                guard let self = self else {return}
                self.currentQuestionIndex = 0
                self.correctAnswer = 0
                self.imageView.layer.masksToBounds = true
                self.imageView.layer.borderWidth = 0
                self.allowAnswer = true
                if let firstQuestion = self.questionFactory.requestNextQuestion() {
                    self.currentQuestion = firstQuestion
                    let viewModel = self.convert(model: firstQuestion)
                    
                    self.show(quiz: viewModel)
                }
            }
        alert.addAction(action)
        self.present(alert,animated: true, completion: nil)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        if allowAnswer == true {
            guard let currentQuestion = currentQuestion else {
                return
            }
            let givenAnswer = false
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
            allowAnswer = false
        }
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        if allowAnswer == true {
            guard let currentQuestion = currentQuestion else {
                return
            }
            let givenAnswer = true
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
            allowAnswer = false
        }
    }
    
}







