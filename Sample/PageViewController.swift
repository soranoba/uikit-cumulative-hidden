//
//  Copyright © 2023 Hinagiku Soranoba. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIViewController {

    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.setViewControllers([ChildViewController(color: colors.first!)], direction: .forward, animated: false)
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()

    private let colors: [UIColor] = [.red, .green, .blue, .gray, .purple]
    private var index: Int = 0

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(pageViewController)
        pageViewController.view.frame = view.bounds
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
}

// MARK: - PageViewController (UIPageViewControllerDelegate)

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished else {
            return
        }

        let index = colors.firstIndex(of: pageViewController.viewControllers!.first!.view.backgroundColor!)!
        self.index = index
    }
}

// MARK: - PageViewController (UIPageViewControllerDataSource)

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return index > 0 ? ChildViewController(color: colors[index - 1]) : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return index + 1 < colors.endIndex ? ChildViewController(color: colors[index + 1]) : nil
    }
}

class ChildViewController: UIViewController {
    convenience init(color: UIColor) {
        self.init()
        view.backgroundColor = color
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("did appear \(self), window = \(String(describing: view.window))")
    }
}

