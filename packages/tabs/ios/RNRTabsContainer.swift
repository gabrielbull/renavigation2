import RenavigationCore

class RNRTabsContainer: UIView, UITabBarControllerDelegate, RNRParent {
    var tabBarController: UITabBarController?

    var scenes: [UIView] = []

    @objc var selectedIndex: NSNumber?
    @objc var _isHidden: NSNumber = 0 // 0 = nil, 1 = true, -1 = false
    @objc var isBlocked: NSNumber = 0 // 0 = nil, 1 = true, -1 = false
    @objc var animationOptions: NSDictionary?
    @objc var hideAnimationOptions: NSDictionary?
    @objc var showAnimationOptions: NSDictionary?

    @objc var onWillSelect: RCTDirectEventBlock?
    @objc var onDidSelect: RCTDirectEventBlock?

    var isReady = false
    var hasUpdatedReactSubviews = false
    var hasMovedToSuperview = false
    var hasMovedToWindow = false

    override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
        scenes.insert(subview, at: atIndex)
        let scene = getSubview(subview)
        if scene is RNRTabScene {
            scene?.willMove(toSuperview: self)
            if isReady {
                tabBarController!.viewControllers?.insert((scene as! RNRTabScene).viewController, at: atIndex)
                tabBarController!.selectedIndex = Int(truncating: selectedIndex!)
            }
        }
    }

    override func removeReactSubview(_ subview: UIView!) {
        let match = getSubview(subview)
        if isReady {
            tabBarController!.viewControllers?.removeAll(where: {
                match == $0.view
            })
        }
        subview.willMove(toSuperview: nil)
        subview.willMove(toWindow: nil)
        subview.removeFromSuperview()
        scenes.removeAll(where: { $0 == subview})
    }

    override func reactSubviews() -> [UIView]! {
        scenes
    }

    override func didUpdateReactSubviews() {
        hasUpdatedReactSubviews = true
        setup()
    }

    override func reactViewController() -> UIViewController! {
        tabBarController
    }

    override func reactAddController(toClosestParent controller: UIViewController!) {}

    func setup() {
        if !isReady && hasMovedToSuperview && hasMovedToWindow && hasUpdatedReactSubviews && tabBarController != nil {
            let childrenReady = areChildrenReady(scenes)
            if childrenReady {
                isReady = true
                tabBarController!.viewControllers = scenes.compactMap {
                    let subview = getSubview($0)
                    if subview is RNRTabScene {
                        return (subview as! RNRTabScene).viewController
                    }
                    return nil
                }
                tabBarController!.selectedIndex = selectedIndex != nil ? Int(truncating: selectedIndex!) : 0
                if _isHidden == 1 {
                    tabBarController!.tabBar.isHidden = true
                    hideTabBar()
                }
            }
        }
    }


    @objc
    override func didSetProps(_ changedProps: [String]!) {
        if tabBarController != nil {
            changedProps.forEach { key in
                if key == "selectedIndex" {
                    tabBarController!.selectedIndex = selectedIndex != nil ? Int(truncating: selectedIndex!) : 0
                } else if key == "_isHidden" {
                    if _isHidden == 1 && !tabBarController!.tabBar.isHidden {
                        hideTabBar()
                    } else if _isHidden != 1 && tabBarController!.tabBar.isHidden {
                        showTabBar()
                    }
                }
            }
        }
    }

    func hideTabBar() {
        if tabBarController != nil {
            if !tabBarController!.tabBar.isHidden {
                let frame = tabBarController!.tabBar.frame
                let height = frame.height

                let options = RNRAnimationOptions.getOptions(hideAnimationOptions != nil ? hideAnimationOptions : animationOptions,
                        defaultDuration: 0.3,
                        defaultDelay: 0,
                        defaultCurve: UIView.AnimationOptions.curveEaseOut
                )

                if options.useCurve {
                    UIView.animate(withDuration: options.duration, delay: options.delay, options: [options.curve], animations: {
                        self.tabBarController!.tabBar.frame = CGRect(x: frame.minX, y: frame.minY + height, width: frame.width, height: frame.height)
                    }, completion: { _ in
                        self.tabBarController!.tabBar.isHidden = true
                        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + height)
                        self.setNeedsDisplay()
                        self.layoutIfNeeded()
                    })
                } else {
                    UIView.animate(withDuration: options.duration, delay: options.delay, usingSpringWithDamping: options.damping, initialSpringVelocity: options.velocity, options: [], animations: {
                        self.tabBarController!.tabBar.frame = CGRect(x: frame.minX, y: frame.minY + height, width: frame.width, height: frame.height)
                    }, completion: { _ in
                        self.tabBarController!.tabBar.isHidden = true
                        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + height)
                        self.setNeedsDisplay()
                        self.layoutIfNeeded()
                    })
                }
            }
        }
    }

    func showTabBar() {
        if tabBarController != nil {
            if tabBarController!.tabBar.isHidden {
                let frame = tabBarController!.tabBar.frame
                let height = frame.height
                tabBarController!.tabBar.isHidden = false
                self.tabBarController!.tabBar.frame = CGRect(x: frame.minX, y: frame.minY + frame.height, width: frame.width, height: frame.height)

                let options = RNRAnimationOptions.getOptions(showAnimationOptions != nil ? showAnimationOptions : animationOptions,
                        defaultDuration: 0.3,
                        defaultDelay: 0,
                        defaultCurve: UIView.AnimationOptions.curveEaseOut
                )

                if options.useCurve {
                    UIView.animate(withDuration: options.duration, delay: options.delay, options: [options.curve], animations: {
                        self.tabBarController!.tabBar.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
                    }, completion: { _ in
                        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height - height)
                        self.setNeedsDisplay()
                        self.layoutIfNeeded()
                    })
                } else {
                    UIView.animate(withDuration: options.duration, delay: options.delay, usingSpringWithDamping: options.damping, initialSpringVelocity: options.velocity, options: [], animations: {
                        self.tabBarController!.tabBar.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
                    }, completion: { _ in
                        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height - height)
                        self.setNeedsDisplay()
                        self.layoutIfNeeded()
                    })
                }
            }
        }
    }

    func updateSubview(_ subview: UIView) {}

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview is RNRTabs {
            tabBarController = (newSuperview as! RNRTabs).tabBarController
            tabBarController?.delegate = self
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if tabBarController != nil {
            addSubview(tabBarController!.view)
            tabBarController!.delegate = self
        }
        hasMovedToSuperview = true
        setup()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        hasMovedToWindow = true
        setup()
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if isBlocked == 1 {
            return false
        }
        var match: Int? = nil
        scenes.enumerated().forEach { (index, subview) in
            let scene = getSubview(subview)
            if scene is RNRTabScene {
                if (scene as! RNRTabScene).viewController == viewController {
                    match = index
                }
            }
        }
        if match == nil {
            return false
        }
        if onWillSelect != nil {
            onWillSelect!(["index": match!])
        }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        var match: Int? = nil
        scenes.enumerated().forEach { (index, subview) in
            let scene = getSubview(subview)
            if scene is RNRTabScene {
                if (scene as! RNRTabScene).viewController == viewController {
                    match = index
                }
            }
        }
        if match != nil {
            if onDidSelect != nil {
                onDidSelect!(["index": match!])
            }
        }
    }

    func invalidate() {
        NSLog("invalidate")
        tabBarController?.viewControllers = []
        tabBarController?.delegate = nil
        tabBarController = nil
    }
}
