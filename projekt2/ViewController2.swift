import UIKit

class ViewController2: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds

    @IBOutlet weak var control: UILabel!
    
    var mode = 0
    var x = 4
    var y = 3
    var i = 12
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    
    var imgList : [String] = []

    var opened : [UIButton] = []
    var openedImg : [String] = []
    
    var isEndCounter : [Int] = []
    
    var ruchy = 0
    
    var rotateCounter = 0
    
    @objc func jazda(sender:UIButton){
        if(opened.count != 2){
            ruchy += 1
            let inx = sender.tag
            let el = imgList[inx]
            el.dropLast(4)
            let imgEl = UIImage(named : el)
            sender.setBackgroundImage(imgEl, for: UIControl.State.normal)
            opened.append(sender)
            openedImg.append(el)
            sender.isUserInteractionEnabled = false
            if(opened.count == 2){
                if(openedImg[0] == openedImg[1]){
                    isEndCounter.append(opened[0].tag)
                    isEndCounter.append(opened[1].tag)
                    opened[0].isEnabled = false
                    opened[1].isEnabled = false
                    opened[0].isUserInteractionEnabled = true
                    opened[1].isUserInteractionEnabled = true
                    opened = []
                    openedImg = []
                }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let imgNone = UIImage(named : "none")!
                        self.opened[0].setBackgroundImage(imgNone, for: UIControl.State.normal)
                        self.opened[1].setBackgroundImage(imgNone, for: UIControl.State.normal)
                        self.opened[0].isUserInteractionEnabled = true
                        self.opened[1].isUserInteractionEnabled = true
                        self.opened = []
                        self.openedImg = []
                    }
                }
            }
            if(isEndCounter.count == i){
                let alert = UIAlertController(title: "You won!", message: "Number of open fields: \(ruchy)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler: {action in self.navigationController!.popViewController(animated: true)}))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(mode == 0){
            x = 4
            y = 3
            i = 12
        }
        else{
            x = 7
            y = 4
            i = 28
        }
        do{
            let items = try fm.contentsOfDirectory(atPath: "/Users/martakurowska/Documents/xcode projekty/projekt2/img")
            
            var temp = 0
            for item in items{
                if(item != "none" && temp<i/2){
                    imgList.append(item)
                    imgList.append(item)
                    temp += 1
                }
            }
        } catch {
            print("gdzie sie podzialy tamte obrazki")
        }
        
        imgList.shuffle()
        
        
        rotateCounter = 0
        if(screenSize.width > screenSize.height){
            generate(temp: rotateCounter, rot: true)
        }
        else{
            generate(temp: rotateCounter, rot: false)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rotateCounter += 1
        generate(temp: rotateCounter, rot: UIDevice.current.orientation.isLandscape)
    }
    
    func generate(temp : Int, rot : Bool){
        if(temp == 0){
            for insideView in view.subviews {
                if ( insideView.isKind(of: UIButton.self) ) {
                    insideView.removeFromSuperview()
                }
            }
            
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let screenW = screenSize.width
            let screenH = screenSize.height
            
            let navSize = self.navigationController!.navigationBar.bounds
            let navHeight = navSize.height
            let navWidth = navSize.width
            
            var w = Int(screenW) / x
            var h = Int(screenH-statusHeight-navHeight) / y
            if w < h{
                h = w
            }
            else{
                w = h
            }
            
            
            for i in 0..<y{
                for j in 0..<x{
                    var mY = 0
                    if(!rot){
                        mY = (Int(screenH)-(h*y))/2+Int(statusHeight)
                    }
                    else{
                        mY = (Int(screenH)-(h*y))/2+Int(Float(statusHeight)*1.5)
                    }
                    let mX = (Int(screenW)-(w*x))/2
                    let posX = w*j+mX
                    let posY = h*i+mY
                    let id = Int(String(y) + String(x))
                    let button : UIButton = UIButton()
                    button.addTarget(self, action: #selector(jazda), for: UIControl.Event.touchUpInside)
                    let img = UIImage(named : "none")!
                    button.frame = CGRect(x: posX+5, y: posY+5, width: w-10, height: h-10)
                    button.tag = i*x + j
                    button.setBackgroundImage(img, for: UIControl.State.normal)
                    self.view.addSubview(button)
                }
            }
        }
        else if(temp%2==1){
            for insideView in view.subviews {
                if ( insideView.isKind(of: UIButton.self) ) {
                    insideView.removeFromSuperview()
                }
            }
            
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let screenW = screenSize.height // zmiana
            let screenH = screenSize.width // zmiana
            
            let navSize = self.navigationController!.navigationBar.bounds
            let navHeight = navSize.height
            let navWidth = navSize.width
            
            var w = Int(screenW) / x
            var h = Int(screenH-statusHeight-navHeight) / y
            if w < h{
                h = w
            }
            else{
                w = h
            }
            
            for i in 0..<y{
                for j in 0..<x{
                    var mY = 0
                    if(!rot){
                        mY = (Int(screenH)-(h*y))/2+Int(statusHeight)
                    }
                    else{
                        mY = (Int(screenH)-(h*y))/2+Int(Float(statusHeight)*1.5)
                    }
                    let mX = (Int(screenW)-(w*x))/2
                    let posX = w*j+mX
                    let posY = h*i+mY
                    let id = Int(String(y) + String(x))
                    let button : UIButton = UIButton()
                    var img = UIImage(named : "none")!
                    button.addTarget(self, action: #selector(jazda), for: UIControl.Event.touchUpInside)
                    button.frame = CGRect(x: posX+5, y: posY+5, width: w-10, height: h-10)
                    button.tag = i*x + j
                    if(isEndCounter.contains(button.tag)){
                        let nazwa = imgList[button.tag]
                        nazwa.dropLast(4)
                        img = UIImage(named : nazwa)!
                        button.isEnabled = false
                    }
                    button.setBackgroundImage(img, for: UIControl.State.normal)
                    self.view.addSubview(button)
                }
            }
        }
        else{
            for insideView in view.subviews {
                if ( insideView.isKind(of: UIButton.self) ) {
                    insideView.removeFromSuperview()
                }
            }
            
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let screenW = screenSize.width
            let screenH = screenSize.height
            
            let navSize = self.navigationController!.navigationBar.bounds
            let navHeight = navSize.height
            let navWidth = navSize.width
            
            var w = Int(screenW) / x
            var h = Int(screenH-statusHeight-navHeight) / y
            if w < h{
                h = w
            }
            else{
                w = h
            }
            
            for i in 0..<y{
                for j in 0..<x{
                    var mY = 0
                    if(!rot){
                        mY = (Int(screenH)-(h*y))/2+Int(statusHeight)
                    }
                    else{
                        mY = (Int(screenH)-(h*y))/2+Int(Float(statusHeight)*1.5)
                    }
                    let mX = (Int(screenW)-(w*x))/2
                    let posX = w*j+mX
                    let posY = h*i+mY
                    let id = Int(String(y) + String(x))
                    let button : UIButton = UIButton()
                    var img = UIImage(named : "none")!
                    button.addTarget(self, action: #selector(jazda), for: UIControl.Event.touchUpInside)
                    button.frame = CGRect(x: posX+5, y: posY+5, width: w-10, height: h-10)
                    button.tag = i*x + j
                    if(isEndCounter.contains(button.tag)){
                        let nazwa = imgList[button.tag]
                        nazwa.dropLast(4)
                        img = UIImage(named : nazwa)!
                        button.isEnabled = false
                    }
                    button.setBackgroundImage(img, for: UIControl.State.normal)
                    self.view.addSubview(button)
                }
            }
        }
        
    }


}
