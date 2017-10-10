//
//  TodoListViewController.swift
//  Todos
//
//  Created by Jan Krukowski on 09/10/2017.
//  Copyright © 2017 Krukowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class TodoListViewController: UIViewController {
    fileprivate var viewModel: TodoListViewModelType!
    fileprivate var bag = DisposeBag()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    static func instantiate(viewModel: TodoListViewModelType = TodoListViewModel()) -> TodoListViewController {
        let storyboard = UIStoryboard(name: "Todo", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load(sort: .defaultValue)
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        let viewController = DetailViewController.instantiate()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapSort(_ sender: Any) {
        let viewController = UIAlertController.sorting(sort: viewModel.sort) { sort in
            self.viewModel.load(sort: sort)
        }
        present(viewController, animated: true, completion: nil)
    }
    
    fileprivate func bindViewModel() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = 100
        viewModel.todos
            .bind(to: tableView.rx.items(cellIdentifier: TodoTableViewCell.id, cellType: TodoTableViewCell.self)) { _, model, cell in
                cell.configure(model: model)
            }.addDisposableTo(bag)
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.didTapCell(indexPath.row)
            }).addDisposableTo(bag)
        
        searchBar.rx
            .text
            .orEmpty
            .debounce(0.2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] name in
                self?.viewModel.filter(name: name)
            }).addDisposableTo(bag)
    }
    
    fileprivate func didTapCell(_ row: Int) {
        let todoViewModel = TodoViewModel(todo: viewModel.get(byIndex: row))
        let viewController = DetailViewController.instantiate(viewModel: todoViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
