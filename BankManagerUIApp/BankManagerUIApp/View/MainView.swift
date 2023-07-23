//
//  MainView.swift
//  BankManagerUIApp
//
//  Created by Hyungmin Lee on 2023/07/22.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func didTappedAddClientButton()
    func didTappedResetClientButton()
}

final class MainView: UIView {
    weak var delegate: MainViewDelegate?
    private let taskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var addClientButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTappedAddClientButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetClientButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTappedResetClientButton), for: .touchUpInside)
        return button
    }()
    
    private let taskTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "업무 시간"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    private let processingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.backgroundColor = .green
        return label
    }()
    
    private let taskingLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.backgroundColor = .purple
        return label
    }()
    
    private let processingView = ProcessingView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = .white
        configureUI()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [addClientButton, resetClientButton].forEach { taskStackView.addArrangedSubview($0) }
        [waitingLabel, taskingLabel].forEach { processingStackView.addArrangedSubview($0) }
        [taskStackView, taskTimeLabel, processingStackView, processingView].forEach { mainStackView.addArrangedSubview($0) }
        addSubview(mainStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            processingStackView.heightAnchor.constraint(equalToConstant: 50),
            taskStackView.heightAnchor.constraint(equalToConstant: 40),
            taskTimeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func addWatingClient(_ turn: Int, _ bankingType: BankingType) {
        processingView.addWatingClient(turn, bankingType)
    }
    
    func moveClientToProcessing(_ turn: Int) {
        processingView.moveClientToProcessing(turn)
    }
    
    func finishProcessingClient(_ turn: Int) {
        processingView.finishProcessingClient(turn)
    }
}

// MARK: - Button Action
extension MainView {
    @objc func didTappedAddClientButton() {
        delegate?.didTappedAddClientButton()
    }
    
    @objc func didTappedResetClientButton() {
        delegate?.didTappedResetClientButton()
        processingView.resetWaitingStackView()
    }
}
