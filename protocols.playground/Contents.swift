import UIKit

protocol Animal{
    var species: String { get }
    var canFlay: Bool { get }
}

protocol Flyable{
    var maximumSpeed: Double { get }
}

struct Monkey: Animal{
    var species: String = "Sapajus apella"
    
    var canFlay: Bool = false
    
    
}

struct Macaw: Animal, Flyable{
    var species: String = "Anodorhynchus leari"
    
    var canFlay: Bool = true
    
    var maximumSpeed: Double
    
    
}

extension Animal{
    var canFly: Bool { return self is Flyable }
}
