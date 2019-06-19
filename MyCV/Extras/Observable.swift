//
//  Observable.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

/// Class to wrap an observed value of any kind. This class
/// will be used to create binding as described in the MVVM architecture
/// pattern.
class Observable<V> {
    private var _value: V?
    
    init(_ value: V) {
        _value = value
    }
    
    /// Closure to handle behavior when observed value changes.
    var valueChanged: ((V?) -> ())?
    
    /// Getter and setter for external sources.
    public var value: V? {
        get {
            return _value
        }
        set {
            _value = newValue
            valueChanged?(_value)
        }
    }
    
    /// Bound object changed value. Update observed value.
    func bindingChanged(to newValue: V) {
        _value = newValue
        print("Value is now \(newValue)")
    }
}

/// `UITextField` subclass that is able to be bound to a `String`.
class BoundTextField: UITextField {
    var changedClosure: (() -> Void)?
    
    @objc func valueChanged() {
        changedClosure?()
    }
    
    func bind(to observable: Observable<String>) {
        addTarget(self, action: #selector(BoundTextField.valueChanged), for: .editingChanged)
        changedClosure = { [weak self] in
            observable.bindingChanged(to: self?.text ?? "")
        }
        
        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
}

/// A `UILabel` subclass able to be bound to a `String`.
class BoundLabel: UILabel {
    
    var changedClosure: (() -> Void)?
    
    @objc func valueChanged() {
        changedClosure?()
    }
    
    func bind(to observable: Observable<String>) {
        observable.valueChanged = { [weak self] newValue in
            DispatchQueue.main.async { [weak self] in 
                self?.text = newValue
            }
        }
    }
}
