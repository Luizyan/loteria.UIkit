//
//  ViewController.swift
//  loteria
//
//  Created by Luiz Yan on 16/10/25.
//

import UIKit

enum gameType: String {
    case megaSena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    
    while result.count < total {
        let randomNumber = arc4random_uniform(UInt32(universe)) + 1
        if !result.contains(Int(randomNumber)) {
            result.append(Int(randomNumber))
        }
    }
    
    return result.sorted()
}


class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    
    @IBOutlet var balls: [UIButton]!
    
    @IBOutlet weak var scGameType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumber(for: .megaSena)
    }
    func showNumber(for type: gameType){
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case.megaSena:
                game = 6 >-< 60
                balls.last!.isHidden = false
            case.quina:
                game = 5 >-< 80
                balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
                                    
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
            case 0:
                showNumber(for: .megaSena)
            default:
                showNumber(for: .quina)
        }
    }
    
}
