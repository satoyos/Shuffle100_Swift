//
//  DigitsButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/07/16.
//

import SwiftUI

struct DigitsButton<D: Digits> {
  @ObservedObject var viewModel: DigitsButtonViewModel<D>
  let action: () -> Void
}

extension DigitsButton: View {
  var body: some View {
    Button(action: action) {
      HStack(spacing: 20) {
        Image(viewModel.output.fillType.ngramImageName)
          .resizable()
          .frame(width: 50, height: 50)
        
        VStack (alignment: .leading) {
          Text("\(viewModel.digit.rawValue)")
            .frame(maxWidth: .infinity,
                   alignment: .leading)
          Text(viewModel.numbersDescription)
            .font(.caption)
        }
      }
    }
    .padding(.horizontal, 30)
  }
}

#Preview {
  DigitsButton<Digits01>(viewModel: .init(digit: .two)) {
    print("押されたし。")
  }
}
