//
//  HomeDataNotFound.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 17/05/21.
//

import UIKit

protocol EmptyData {
    func add()
}
protocol HomeNotFound {
    func buttonAction(_ sender: Any)
}

class HomeDataNotFound: UIView, HomeNotFound {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var buttonAdd: UIButton!
    var delegate: EmptyData?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("HomeDataNotFound", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mainView.layer.cornerRadius = 25
        buttonAdd.layer.cornerRadius = 20
    }
    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.add()
    }
}
