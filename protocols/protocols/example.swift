//
//  example.swift
//  protocols
//
//  Created by Paula Vaz on 19/02/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import Foundation


// CustomStringConvertible é um protocolo da biblioteca padrão que define que o tipo possui  uma propriedade chamada "description"
protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}



//MARK: Defining Protocol-Conforming Types

// FlappyBird está em conformidade com os protocolos Bird e Flyable
struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    //let canFly = true
    
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
    //let canFly = false
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double
    //let canFly = true
    
    // Swift is FASTER every version!
    var airspeedVelocity: Double { return version * 1000.0 }
}



//MARK: Extending Protocols With Default Implementations

// comportamento default do protocolo Bird (não mais necessário canFly para cada struct)
extension Bird {
    // se o tipo for Flyable, canFly será true
    var canFly: Bool { return self is Flyable }
}

// comportamento default do protocolo CustomStringConvertible
extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I’ll just sit here :["
    }
}




// MARK: Why Not Base Classes?

enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}



// MARK: Overriding Default Behavior

extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}



// MARK: Off to the Races

class Motorcycle {
    init(name: String) {
        self.name = name
        speed = 200
    }
    var name: String
    var speed: Double
}

protocol Racer {
    var speed: Double { get }  // speed is the only thing racers care about
}

extension FlappyBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        return 42  // full waddle speed
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airspeedVelocity : 0
    }
}

extension Motorcycle: Racer {}

extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        return self.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
}



// MARK: Protocol Comparators

protocol Score: Equatable, Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    let value: Int
    
    static func ==(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value < rhs.value
    }
}


