//
//  GetMainInformation.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Enum that represents possible stated when downloading information.
enum DownloadResult {
    enum SyncError: Error {
        case unknown
        case notConnected
    }
    
    case success
    case failure(error: SyncError)
}

/// Use case that stars downloading information from the Internet.
protocol GetMainInformation {
    func download(_ completionHandler: @escaping (DownloadResult) -> Void)
}
