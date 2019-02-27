//
//  ViewController.swift
//  protocols
//
//  Created by Paula Vaz on 19/02/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let numbers = [10,20,30,40,50,60]
        let slice = numbers[1...3]
        let reversedSlice = slice.reversed()
        
        let answer = reversedSlice.map { $0 * 10 }
        print(answer)

        let racers: [Racer] =
            [UnladenSwallow.african,
             UnladenSwallow.european,
             UnladenSwallow.unknown,
             Penguin(name: "King Penguin"),
             SwiftBird(version: 3.0),
             FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
             Motorcycle(name: "Giacomo")
        ]
        
        // print(topSpeed(of: racers[1...3])) // 42
        
        racers.topSpeed()        // 3000
        racers[1...3].topSpeed() // 42

        
    }
    
    // essa função se torna desnecessária, pois o método topSpeed foi implementado na extension de Sequence e ficou disponível para ser utilizado tendo-se um sequence de racers
    func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double
        where RacerType.Iterator.Element == Racer {
            return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
    
    


}

