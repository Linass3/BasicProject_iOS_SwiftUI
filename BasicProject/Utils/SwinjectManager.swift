//
//  SwinjectManager.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 01/04/2025.
//

import Swinject
import CoreData

// swiftlint:disable:next type_name
public typealias DI = SwinjectManager

public final class SwinjectManager {
    private static let container = Container()
    
    static func registerDependencies() {
        container.register(CoreDataStack.self) { _ in
            CoreDataStack.shared
        }.inObjectScope(.container)
    }
    
    static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let resolvedService = container.resolve(serviceType) else {
            fatalError("Could not resolve servise: \(serviceType)")
        }
        
        return resolvedService
    }
}
