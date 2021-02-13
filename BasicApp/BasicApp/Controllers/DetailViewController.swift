//
//  DetailViewController.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/8/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

enum Color {
    case green
    case red
    case yellow
}

protocol SampleProtocol: class {
    func testMemoryLeak()
}

class DetailViewController: UIViewController {
    
    @IBOutlet var detailedImageView: UIImageView!
    @IBOutlet var colorView: UIView!
    
    weak var delegate: SampleProtocol?
    
    var imageURL: String = ""
    var currentBGColor: Color?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailedImageView.kf.setImage(with: URL(string: imageURL))
        delegate?.testMemoryLeak()
        
        let date = Date().addingTimeInterval(0)
        let timer = Timer(fireAt: date, interval: 1, target: self, selector: #selector(didTap), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        
    }
    
    deinit {
        print("DetailViewController Deinitialized")
    }
    
    @IBAction @objc func didTap(_ gesture: UITapGestureRecognizer? = nil) {
        colorView.backgroundColor = toggleColor(currentBGColor ?? .red)
        self.view.backgroundColor = toggleColor(currentBGColor ?? .red)
    }
    
    @IBAction func handlePan(_ gesture: UIPanGestureRecognizer) {
      // 1
      let translation = gesture.translation(in: view)

      // 2
      guard let gestureView = gesture.view else {
        return
      }

      gestureView.center = CGPoint(
        x: gestureView.center.x + translation.x,
        y: gestureView.center.y + translation.y
      )

      // 3
      gesture.setTranslation(.zero, in: view)
    }
    
    func toggleColor(_ color: Color) -> UIColor {
        switch color {
        case .green:
            currentBGColor = .red
            return .red
        case .red:
            currentBGColor = .yellow
            return .yellow
        case .yellow:
            currentBGColor = .green
            return .green
        }
    }

}
