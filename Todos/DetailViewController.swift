//
//  DetailViewController.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var detailsTextView: UITextView!
    fileprivate var bag = DisposeBag()
    fileprivate var viewModel: TodoViewModelType!
    fileprivate let dateFormatter = DateFormatter()
    
    static func instantiate(viewModel: TodoViewModelType = TodoViewModel()) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Todo", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.load()
    }
    
    fileprivate func bindViewModel() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.rx
            .controlEvent(.editingDidBegin)
            .bind(onNext: { [unowned self] in
                self.showDatePicker(self.dateTextField)
            }).addDisposableTo(bag)
        
        viewModel.todo
            .subscribe(onNext: { [weak self] todo in
                self?.display(todo: todo)
            }).addDisposableTo(bag)
    }
    
    fileprivate func display(todo: Todo?) {
        nameTextField.text = todo?.name
        if let date = todo?.due {
            dateTextField.text = dateFormatter.string(from: date)
        }
        detailsTextView.text = todo?.text ?? ""
    }
    
    fileprivate func showDatePicker(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self,
                                 action: #selector(DetailViewController.datePickerValueChanged),
                                 for: .valueChanged)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
}
