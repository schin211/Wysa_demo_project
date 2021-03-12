//
//  ViewController.swift
//  Wysa Animator
//
//  Created by Sachin Madan on 08/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewToAnimate: UIView!
    private var animator: UIDynamicAnimator!
    private var snapping: UISnapBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        animator = UIDynamicAnimator(referenceView: view)
        snapping = UISnapBehavior(item: viewToAnimate, snapTo: view.center)
        animator.addBehavior(snapping)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        viewToAnimate.addGestureRecognizer(panGesture)
        viewToAnimate.isUserInteractionEnabled = true
    }

    @objc func pannedView(recognizer: UIPanGestureRecognizer){
        switch recognizer.state{
        
        case .began:
            animator.removeBehavior(snapping)
        case .changed:
            let translation = recognizer.translation(in: view)
            viewToAnimate.center = CGPoint(x: viewToAnimate.center.x + translation.x, y: viewToAnimate.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
        case .ended , .failed , .cancelled:
            animator.addBehavior(snapping)
        case .possible:
            break
        @unknown default:
            break
        }
        
    }
}

