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
        return scrollView
    }()
    
    private let waitingContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let taskingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .brown
        return scrollView
    }()
    
    private let taskingContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
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
        taskingContentView.addSubview(taskingStackView)
        taskingScrollView.addSubview(taskingContentView)
        
        [waitingScrollView, taskingScrollView].forEach { addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        setUpWaitingContentViewConstraints()
        setUpTaskingContentViewConstraints()
        setUpWaitingStackViewConstraints()
        setUpTaskingStackViewConstraints()
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
    private func setUpWaitingContentViewConstraints() {
        NSLayoutConstraint.activate([
            waitingContentView.leadingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.leadingAnchor),
            waitingContentView.trailingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.trailingAnchor),
            waitingContentView.topAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.topAnchor),
            waitingContentView.bottomAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.bottomAnchor),
            waitingContentView.widthAnchor.constraint(equalTo: waitingScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        let heightConstraint = waitingContentView.heightAnchor.constraint(equalTo: waitingScrollView.frameLayoutGuide.heightAnchor, constant: 1)
        heightConstraint.priority = .init(1)
        heightConstraint.isActive = true
    }
    
    private func setUpTaskingContentViewConstraints() {
        NSLayoutConstraint.activate([
            taskingContentView.leadingAnchor.constraint(equalTo: taskingScrollView.contentLayoutGuide.leadingAnchor),
            taskingContentView.trailingAnchor.constraint(equalTo: taskingScrollView.contentLayoutGuide.trailingAnchor),
            taskingContentView.topAnchor.constraint(equalTo: taskingScrollView.contentLayoutGuide.topAnchor),
            taskingContentView.bottomAnchor.constraint(equalTo: taskingScrollView.contentLayoutGuide.bottomAnchor),
            taskingContentView.widthAnchor.constraint(equalTo: taskingScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        let heightConstraint = taskingContentView.heightAnchor.constraint(equalTo: taskingScrollView.frameLayoutGuide.heightAnchor, constant: 1)
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
    
    private func setUpTaskingStackViewConstraints() {
        NSLayoutConstraint.activate([
            taskingStackView.leadingAnchor.constraint(equalTo: taskingContentView.leadingAnchor),
            taskingStackView.trailingAnchor.constraint(equalTo: taskingContentView.trailingAnchor),
            taskingStackView.topAnchor.constraint(equalTo: taskingContentView.topAnchor),
            taskingStackView.bottomAnchor.constraint(equalTo: taskingContentView.bottomAnchor)
        ])
    }
}
