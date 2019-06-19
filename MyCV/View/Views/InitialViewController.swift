//
//  ViewController.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    let viewModel = InitialViewModel(locator: UseCaseLocator.main)
    
    @IBOutlet weak var errorLabel: BoundLabel?
    @IBOutlet weak var errorContainerView: UIView?
    @IBOutlet weak var retryButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBinding()
        viewModel.start()
    }
    
    @IBAction func didTapRetry(_ sender: UIButton) {
        viewModel.start()
    }
}

// MARK: - InitialViewController Configuration
extension InitialViewController {
    
    func configureUI() {
        guard let retryButton = retryButton else { return }
        retryButton.layer.cornerRadius = 3
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor.purple.cgColor
    }
    
    @objc func handleContainerView(isHidden: Bool) {
        guard let errorContainerView = errorContainerView, let retryButton = retryButton else { return }
        errorContainerView.isHidden = isHidden
        retryButton.isHidden = isHidden
    }
    
    func configureBinding() {
        guard let errorLabel = errorLabel else { return }
        errorLabel.bind(to: viewModel.currentState)
        
        viewModel.onFinishHandler = { [weak self] in
            guard let strongSelf = self else { return }
            switch strongSelf.viewModel.appState {
            case .finished:
                strongSelf.performSelector(onMainThread: #selector(UIViewController.performSegue), with: Identifiers.Segues.ShowCV, waitUntilDone: false)
            case .inProgress:
                strongSelf.performSelector(onMainThread: #selector(InitialViewController.handleContainerView), with: true, waitUntilDone: false)
            case .error:
                strongSelf.performSelector(onMainThread: #selector(InitialViewController.handleContainerView), with: false, waitUntilDone: false)
            default:
                break
            }
        }
    }
}

