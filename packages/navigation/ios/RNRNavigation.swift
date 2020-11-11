import RenavigationCore

class RNRNavigation: UIView, RNRParent {
    var navigationController: UINavigationController = UINavigationController()

    var isReady = false
    var hasMovedToSuperview = false
    var hasUpdatedReactSubviews = false

    @objc var isInteractivePopGestureEnabled: NSNumber = 0 // 0 = nil, 1 = true, -1 = false

    var hasSetDefaults = false
    var defaultIsInteractivePopGestureEnabled: Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)
        navigationController.setViewControllers([UIViewController()], animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didUpdateReactSubviews() {
        super.didUpdateReactSubviews()
        hasUpdatedReactSubviews = true
        setup()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        hasMovedToSuperview = true
        setup()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if isReady {
            setupChildren()
        } else {
            setup()
        }
    }

    func updateSubview(_ subview: UIView) {
        setProps()
    }

    func setup() {
        setProps()
        if !isReady && hasMovedToSuperview && hasUpdatedReactSubviews && reactViewController() != nil {
            let childrenReady = (reactSubviews()[0] as! RNRChild).isReady
            if childrenReady {
                isReady = true
                setupChildren()
            }
        }

        // Sometimes, the reactViewController is not available yet, we have to wait until it is
        if !isReady && hasMovedToSuperview && hasUpdatedReactSubviews {
            DispatchQueue.main.async { [self] in
                setup()
            }
        }
    }

    func setupChildren() {
        reactSubviews().forEach { view in
            if view is RNRNavigationContainer {
                if reactViewController() != nil {
                    (view as! RNRNavigationContainer).setupViewController(reactViewController())
                }
            }
        }
    }

    @objc
    override func didSetProps(_ changedProps: [String]!) {
        setProps()
    }

    func setProps() {
        if !hasSetDefaults {
            hasSetDefaults = true
            defaultIsInteractivePopGestureEnabled = navigationController.interactivePopGestureRecognizer?.isEnabled
        }

        reactSubviews().enumerated().forEach { (index, subview) in
            if index == 0 {
                if subview is RNRNavigationBar {
                    (subview as! RNRNavigationBar).setNavigationBar(navigationController.navigationBar)
                    navigationController.navigationBar.setNeedsLayout()
                }
            }
        }

        if isInteractivePopGestureEnabled == -1 {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        } else if isInteractivePopGestureEnabled == 1 {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            navigationController.interactivePopGestureRecognizer?.isEnabled = defaultIsInteractivePopGestureEnabled != nil ? defaultIsInteractivePopGestureEnabled! : true
        }
    }
}
