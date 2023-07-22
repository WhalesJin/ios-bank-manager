//
//  ProcessingScrollView.swift
//  BankManagerUIApp
//
//  Created by Hyungmin Lee on 2023/07/22.
//

import UIKit

final class ProcessingScrollView: UIStackView {
    private let waitingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .magenta
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let waitingContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let waitingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let taskingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .orange
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        axis = .horizontal
        distribution = .fillEqually
        backgroundColor = .gray
        
        configureUI()
        setUpConstraints()
//        setUpLabels()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        waitingContentView.addSubview(waitingStackView)
        waitingScrollView.addSubview(waitingContentView)
        
        [waitingScrollView, taskingStackView].forEach { addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        setUpWaitingScrollViewConstraints()
        setUpContenViewConstraints(waitingContentView, waitingScrollView)
        setUpWaitingStackViewConstraints()
    }
    
    private func setUpLabels() {
        for _ in 0...4 {
            let label = UILabel()
            label.text = "TEST"
            
            waitingStackView.addArrangedSubview(label)
        }
        
        for _ in 0...4 {
            let label = UILabel()
            label.text = "TEST"
            
            taskingStackView.addArrangedSubview(label)
        }
    }
    
}

// MARK: - Constraints
extension ProcessingScrollView {
    private func setUpWaitingScrollViewConstraints() {
        NSLayoutConstraint.activate([
            waitingScrollView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            waitingScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            waitingScrollView.topAnchor.constraint(equalTo: topAnchor),
            waitingScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpContenViewConstraints(_ contenView: UIView, _ scrollView: UIScrollView) {
        NSLayoutConstraint.activate([
            contenView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contenView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contenView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contenView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contenView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        let heightConstraint = contenView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, constant: 1)
        heightConstraint.priority = .init(1)
        heightConstraint.isActive = true
    }
    
    private func setUpWaitingStackViewConstraints() {
        NSLayoutConstraint.activate([
            waitingStackView.leadingAnchor.constraint(equalTo: waitingContentView.leadingAnchor),
            waitingStackView.trailingAnchor.constraint(equalTo: waitingContentView.trailingAnchor),
            waitingStackView.topAnchor.constraint(equalTo: waitingContentView.topAnchor),
            waitingStackView.bottomAnchor.constraint(equalTo: waitingContentView.bottomAnchor)
        ])
    }
}