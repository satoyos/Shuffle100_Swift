//
//  PoemRow.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/08/17.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

struct PoemRow: View {
  let poem: Poem
  let isSelected: Bool
  let onTap: () -> Void
  let onDetailTap: () -> Void
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        Text(poem.strWithNumberAndLiner())
          .font(.system(.body, design: .serif, weight: .bold))
          .foregroundColor(.primary)
          .lineLimit(1)
        
        Text("          \(poem.poet) \(poem.living_years)")
          .font(.caption)
          .foregroundColor(.secondary)
          .padding(.top, 2)
      }
      
      Spacer()
      
      Button(action: onDetailTap) {
        Image(systemName: "info.circle")
          .foregroundColor(.accentColor)
      }
      .buttonStyle(PlainButtonStyle())
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 16)
    .background(isSelected ? selectedPoemBackColor : Color.clear)
    .contentShape(Rectangle())
    .onTapGesture {
      onTap()
    }
  }
  
  private var selectedPoemBackColor: Color {
    // StandardColor.selectedPoemBackColor をSwiftUIのColorに変換
    Color(StandardColor.selectedPoemBackColor)
  }
}

#Preview {
  VStack(spacing: 0) {
    PoemRow(
      poem: PoemSupplier.originalPoems[0],
      isSelected: false,
      onTap: { print("Poem tapped") },
      onDetailTap: { print("Detail tapped") }
    )
    
    PoemRow(
      poem: PoemSupplier.originalPoems[1],
      isSelected: true,
      onTap: { print("Poem tapped") },
      onDetailTap: { print("Detail tapped") }
    )
  }
  .padding()
}
