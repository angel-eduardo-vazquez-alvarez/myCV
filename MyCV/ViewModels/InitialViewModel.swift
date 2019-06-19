//
//  InitialViewModel.swift
//  MyCV
//
//  Created by Angel Vázquez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

class InitialViewModel {
    
    /// Current state of app while fetching data.
    enum State: Equatable {
        case idle
        case finished
        case error(message: String)
        case inProgress
    }
    
    // MARK: - Properties
    /// Selects the corresponding use case.
    private let locator: UseCaseLocatorProtocol
    var currentState: Observable<String> = Observable("")
    private(set) var appState: State = .idle {
        didSet {
            switch appState {
            case .idle:
                currentState.value = NSLocalizedString("Idle", comment: "Stationary")
            case .inProgress:
                currentState.value = NSLocalizedString("In progress", comment: "Currently doing something")
            case .finished:
                currentState.value = NSLocalizedString("Finished", comment: "Already done")
            case .error(let message):
                currentState.value = message
            }
        }
    }
    
    /// Closure to trigger behavior only when data has been fetched correctly.
    var onFinishHandler: () -> Void = { }
    
    // MARK: - Initializers
    init(locator: UseCaseLocatorProtocol) {
        self.locator = locator
        appState = .idle
    }
    
    // MARK: - Methods
    func start() { 
        guard let getInformationUseCase = locator.getUseCase(of: GetMainInformation.self) else {
            appState = .error(message: NSLocalizedString("Error", comment: "Something went wrong"))
            return
        }

        appState = .inProgress
        getInformationUseCase.download { [weak self] downloadResult in
            guard let strongSelf = self else { return }
            strongSelf.handleResult(downloadResult)
        }
    }
    
    func handleResult(_ result: DownloadResult) {
        switch result {
        case .success:
            appState = .finished
        case .failure(error: .unknown):
            appState = .error(message: NSLocalizedString("Error", comment: "Something went wrong"))
        case .failure(error: .notConnected):
            appState = .error(message: NSLocalizedString("Disconnected", comment: "Without connection to the internet"))
        }
        onFinishHandler()
    }
}
