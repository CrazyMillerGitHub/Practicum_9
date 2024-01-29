//
//  ViewController.swift
//  Practicum_9
//
//  Created by Mikhail Borisov on 29.11.2023.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    @IBOutlet weak var firstNumberTextField: UITextField!

    @IBOutlet weak var secondNumberTextField: UITextField!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didPressCalcualateButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let resultViewController = storyboard.instantiateViewController(
            identifier: "ResultViewController") as? ResultViewController else {
            assertionFailure("Something went wrong")
            return
        }
        navigationController?.pushViewController(resultViewController, animated: true)
    }
}
