//
//  PickerComponent.swift
//  MultiPicker
//
//  Created by Heiner Gerdes on 18.06.21.
//

import SwiftUI

#if os(iOS)
@available(iOS 13, *)
extension MultiPicker{
    /// Picker component for the MultiPicker which conform to LosslessStringConvertible (e.g. String, Int, Double)
    internal struct PickerComponent: View {
        /// The index of the picked value of the picker component
        @Binding private var selection: Int
        /// The values for the picker component
        private var values: [String]
        /// The text which is displayed in on the left side of the values of the picker component.
        private var valuesPrefix: LocalizedStringKey
        /// The text which is displayed in on the right side of the values of the picker component.
        private var valuesSuffix: LocalizedStringKey
        /// The height of the picker component view
        private(set) var height: CGFloat
        
        /// Picker component for the MultiPicker which conform to LosslessStringConvertible (e.g. String, Int, Double)
        /// - Parameters:
        ///   - selection: The index of the picked value of the picker component
        ///   - values: The values for the picker component
        ///   - valuesPrefix: The text which is displayed in on the left side of the values of the picker component.
        ///   - valuesSuffix: The text which is displayed in on the right side of the values of the picker component.
        ///   - height: The height of the picker component view
        internal init<T: LosslessStringConvertible>(selection: Binding<Int>,
                                                    values: [T],
                                                    valuesPrefix: LocalizedStringKey = "",
                                                    valuesSuffix: LocalizedStringKey = "",
                                                    height: CGFloat) {
            self._selection = selection
            self.values = values.map { String($0) }
            self.valuesPrefix = valuesPrefix
            self.valuesSuffix = valuesSuffix
            self.height = height
        }
        
        internal var body: some View {
            GeometryReader { geometry in
                Picker(selection: self.$selection, label: Text("")) {
                    ForEach(0 ..< self.values.count, id: \.self) { index in
                        HStack{
                            if self.valuesPrefix != ""{
                                Text(self.valuesPrefix)
                            }
                            Text("\(self.values[index])")
                                .tag(index)
                            if self.valuesSuffix != ""{
                                Text(self.valuesSuffix)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width,
                       height: self.height - 25,
                       alignment: .center)
                .clipped()
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                // addded to center the view in iOS14:
                .position(x: geometry.frame(in: .local).midX,
                          y: geometry.frame(in: .local).midY)
            }
            .frame(height:height)
        }
    }
}
#endif


//MARK: - Preview
#if os(iOS)
@available(iOS 13, *)
internal struct PickerComponent_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            Text("Row 1")
            MultiPicker.PickerComponent(selection: .constant(6),
                                        values: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"],
                                        valuesPrefix: ">",
                                        valuesSuffix: "<",
                                        height: 200)
                .border(Color.green)
            Text("Row 3")
        }
        
        MultiPicker.PickerComponent(selection: .constant(5),
                                    values: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"],
                                    valuesPrefix: ">",
                                    valuesSuffix: "<",
                                    height: 200)
            .border(Color.green)
    }
}
#endif
