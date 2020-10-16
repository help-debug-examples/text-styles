
import UIKit
import PlaygroundSupport

class PostItNoteView : UIView {
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        let topLeft = CGPoint(x: bounds.minX, y: bounds.minY)
        let topRight = CGPoint(x: bounds.maxX, y: bounds.minY)
        let bottomRight = CGPoint(x: bounds.maxX, y: bounds.maxY)
        let bottomLeft = CGPoint(x: bounds.minX + 10, y: bounds.maxY - 10)

        let bottomControlPoint1 = CGPoint(x: bottomLeft.x + 10, y: bounds.maxY - 5)
        let bottomControlPoint2 = CGPoint(x: bottomLeft.x + 25, y: bounds.maxY)
        let leftControlPoint1 = CGPoint(x: bounds.minX +  10, y: bottomLeft.y - 5)
        let leftControlPoint2 = CGPoint(x: bounds.minX, y: bottomLeft.y - 25)

        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: bottomRight)
        path.addCurve(to: bottomLeft, controlPoint1: bottomControlPoint1, controlPoint2: bottomControlPoint2)
        path.addCurve(to: topLeft, controlPoint1: leftControlPoint1, controlPoint2: leftControlPoint2)
        path.close()
        UIColor(red: 0.87, green: 0.93, blue: 0.53, alpha: 1).set()
        path.fill()
    }
}

class MyViewController : UIViewController {

    private var textViewHeightAnchor: NSLayoutConstraint?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background.png")
        //imageView.backgroundColor = .red
        return imageView
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.textAlignment = .center
        textView.font = UIFont.boldSystemFont(ofSize: 28)
        return textView
    }()

    private var noteView: PostItNoteView = {
        let noteView = PostItNoteView()
        noteView.backgroundColor = .clear
        noteView.layer.shadowColor = UIColor.black.cgColor
        noteView.layer.shadowOpacity = 0.4
        noteView.layer.shadowOffset = CGSize(width: 0, height: 2)
        noteView.layer.shadowRadius = 2
        return noteView
    }()

    override func viewDidLoad() {
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(noteView)
        view.addSubview(textView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 175).isActive = true
        textViewHeightAnchor = textView.heightAnchor.constraint(equalToConstant: 130)
        textViewHeightAnchor?.isActive = true

        noteView.translatesAutoresizingMaskIntoConstraints = false
        noteView.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -20).isActive = true
        noteView.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 20).isActive = true
        noteView.topAnchor.constraint(equalTo: textView.topAnchor, constant: -20).isActive = true
        noteView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20).isActive = true
    }
}

extension MyViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textViewHeightAnchor?.constant = max(textView.contentSize.height, 130)
        return true
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
