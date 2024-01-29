import UIKit
import Combine

class MainViewController: UIViewController {

    // MARK: - properties

    @IBOutlet weak var calculateButton: UIButton!

    @IBOutlet weak var firstNumberTextField: UITextField!

    @IBOutlet weak var secondNumberTextField: UITextField!
    
    private var firstNumberText: String = "" {
        didSet {
            updateButtonAppearence()
        }
    }

    private var secondNumberText: String = "" {
        didSet {
            updateButtonAppearence()
        }
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        firstNumberTextField
            .textPublisher
            .removeDuplicates()
            .sink { [weak self] value in
                self?.firstNumberText = value
            }
            .store(in: &cancellables)
        
        secondNumberTextField
            .textPublisher
            .removeDuplicates()
            .sink { [weak self] value in
                self?.secondNumberText = value
            }
            .store(in: &cancellables)
    }

    @IBAction func didPressCalcualateButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let resultViewController = storyboard.instantiateViewController(
            identifier: Constants.identifier
        ) as? ResultViewController else {
            assertionFailure("Something went wrong")
            return
        }
        navigationController?.pushViewController(resultViewController, animated: true)
    }

    // MARK: - private methods

    private func updateButtonAppearence() {
        guard !firstNumberText.isEmpty || !secondNumberText.isEmpty else {
            calculateButton.setTitle("Посчитать", for: .normal)
            calculateButton.isEnabled = false
            return
        }
        calculateButton.isEnabled = true
        calculateButton.setTitle("Посчитать: \([firstNumberText, secondNumberText].filter(\.isNotEmpty).joined(separator: " + "))", for: .normal)
    }
}

// MARK: - Nested types
extension MainViewController {
    private enum Constants {
        static let identifier: String = "ResultViewController"
    }
}

fileprivate extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}
