//
//  ProcessingView.swift
//  BankManagerUIApp
//
//  Created by Hyungmin Lee on 2023/07/22.
//

import UIKit

final class ProcessingView: UIStackView {
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
    
    private let taskingContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let taskingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
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
        [waitingScrollView, taskingContentView].forEach { addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        setUpWaitingScrollViewConstraints()
        setUpWaitingContenViewConstraints(waitingContentView, waitingScrollView)
        setUpWaitingStackViewConstraints()
        setUpTaskingStackViewConstraints()
    }
}

// MARK: - Client ManageMethod
extension ProcessingView {
    func addWatingClient(_ turn: Int, _ bankingType: BankingType) {
        let waitingLabel = UILabel()
        
        waitingLabel.tag = turn
        waitingLabel.text = "\(turn) - \(bankingType.rawValue)"
        waitingStackView.addArrangedSubview(waitingLabel)
    }
    
    func finishProcessingClient(_ turn: Int) {
        for subview in taskingStackView.subviews {
            if subview.tag == turn {
                guard let label = subview as? UILabel else { break }
                
                label.removeFromSuperview()
            }
        }
    }
    
    func moveClientToProcessing(_ turn: Int) {
        var clientMessage: String?
        
        for subview in waitingStackView.subviews {
            if subview.tag == turn {
                guard let label = subview as? UILabel else { break }
                
                clientMessage = label.text
                label.removeFromSuperview()
            }
        }
        
        let processingLabel = UILabel()
        
        processingLabel.text = clientMessage
        processingLabel.tag = turn
        taskingStackView.addArrangedSubview(processingLabel)
    }
    
    func resetWaitingStackView() {
        waitingStackView.subviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - Constraints
extension ProcessingView {
    private func setUpWaitingScrollViewConstraints() {
        NSLayoutConstraint.activate([
            waitingScrollView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            waitingScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            waitingScrollView.topAnchor.constraint(equalTo: topAnchor),
            waitingScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpWaitingContenViewConstraints(_ contenView: UIView, _ scrollView: UIScrollView) {
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
    
    private func setUpTaskingStackViewConstraints() {
        NSLayoutConstraint.activate([
            taskingStackView.leadingAnchor.constraint(equalTo: taskingContentView.leadingAnchor),
            taskingStackView.trailingAnchor.constraint(equalTo: taskingContentView.trailingAnchor),
            taskingStackView.topAnchor.constraint(equalTo: taskingContentView.topAnchor),
        ])
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
