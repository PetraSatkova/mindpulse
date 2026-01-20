//
//  Injected.swift
//  MindPulse
//
//  Created by Petra Satkova on 20.01.2026.
//

@propertyWrapper
struct Injected<T> {
    let wrappedValue: T

    init() {
        wrappedValue = DIContainer.shared.resolve()
    }
}
