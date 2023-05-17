//
//  ViewController.swift
//  InertialSquare
//
//  Created by Андрей Фроленков on 16.05.23.
//

import UIKit

class ViewController: UIViewController {
  
  lazy var square: UIView = {
    let square = UIView(frame: CGRect(x: self.view.bounds.width / 2 - 50, y: self.view.bounds.height / 2 - 50, width: 100, height: 100))
    square.backgroundColor = .systemBlue
    square.layer.cornerRadius = 10
    return square
  }()
  
  var snap: UISnapBehavior!
  var animator: UIDynamicAnimator!
  var collision: UICollisionBehavior!
  var itemBehaviour: UIDynamicItemBehavior!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    self.view.addSubview(square)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    animator = UIDynamicAnimator(referenceView: view)
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    animator.removeAllBehaviors()
    
    for touch in touches {
      
      let location = touch.location(in: self.view)
      
      self.snap = UISnapBehavior(item: self.square, snapTo: location)
      self.snap.damping = 0.2
      self.animator.addBehavior(self.snap)
      
      itemBehaviour = UIDynamicItemBehavior(items: [square])
      itemBehaviour.resistance = 40
      animator.addBehavior(itemBehaviour)
      
      collision = UICollisionBehavior(items: [square])
      collision.translatesReferenceBoundsIntoBoundary = true
      animator.addBehavior(collision)
      
    }
  }
  
}


