//
//  UseCaseImplementation.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Represents what a single use case needs to work properly.
protocol UseCaseProtocol {
    var service: FetchService { get set }
    var repository: DataRepository { get set }
    
    init(service: FetchService, repository: DataRepository)
}

