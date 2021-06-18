//
//  MultiPicker.swift
//  MultiPicker
//
//  Created by Heiner Gerdes on 18.06.21.
//

import SwiftUI

#if os(iOS)
/// Picker for up to three values which conform to LosslessStringConvertible (e.g. String, Int, Double)
///
/// # Example
/// ```
/// struct ContentView: View {
///     var values1: [String] = ["-", "+"]
///     var values2: [Int] = Array(0...23)
///     var values3: [Int] = Array(0...59)
///     @State var selection1: Int = 1
///     @State var selection2: Int = 1
///     @State var selection3: Int = 0
///
///     var body: some View {
///         VStack{
///             Button(action: {
///                 withAnimation{
///                     self.selection1 = 0
///                     self.selection2 = 5
///                     self.selection3 = 30
///                 }
///             }) {
///                 Text("Set to +5h:30m")
///             }
///             MultiPicker(selection1: $selection1,
///                         selection2: $selection2,
///                         selection3: $selection3,
///                         values1: values1,
///                         values2: values2,
///                         values3: values3,
///                         values2Prefix: "",
///                         values2Suffix: "h",
///                         values3Prefix: "",
///                         values3Suffix: "m",
///                         middleText2: ":")
///             VStack(alignment: .leading){
///                 Text("Value 1: \(self.values1[selection1])")
///                 Text("Value 2: \(self.values2[selection2])")
///                 Text("Value 3: \(self.values3[selection3])")
///             }
///         }
///     }
/// }
/// ```
@available(iOS 13, *)
public struct MultiPicker: View {
    /// The height of the MultiPicker view
    private(set) var height: CGFloat = 200
    /// Number of picker components
    private(set) var numberOfComponents: Int
    /// The index of the picked value of the first picker
    @Binding private var selection1: Int
    /// The index of the picked value of the second picker
    @Binding private var selection2: Int
    /// The index of the picked value of the third picker
    @Binding private var selection3: Int
    /// The values for the first picker
    private var values1: [String]
    /// The values for the second picker
    private var values2: [String]
    /// The values for the third picker
    private var values3: [String]
    /// The text which is displayed in on the left side of the values of the first picker.
    private var values1Prefix: LocalizedStringKey
    /// The text which is displayed in on the right side of the values of the first picker.
    private var values1Suffix: LocalizedStringKey
    /// The text which is displayed in on the left side of the values of the second picker.
    private var values2Prefix: LocalizedStringKey
    /// The text which is displayed in on the right side of the values of the second picker.
    private var values2Suffix: LocalizedStringKey
    /// The text which is displayed in on the left side of the values of the third picker.
    private var values3Prefix: LocalizedStringKey
    /// The text which is displayed in on the right side of the values of the third picker.
    private var values3Suffix: LocalizedStringKey
    /// The text that is displayed between the first and second picker.
    private var middleText1: LocalizedStringKey
    /// The text that is displayed between the second and third picker.
    private var middleText2: LocalizedStringKey
    
    /// Picker for one component which conform to LosslessStringConvertible (e.g. String, Int, Double)
    /// - Parameters:
    ///   - selection1: The index of the picked value of the first picker
    ///   - values1: The values for the first picker
    ///   - values1Prefix: The text which is displayed in on the left side of the values of the first picker.
    ///   - values1Suffix: The text which is displayed in on the right side of the values of the first picker.
    public init<T: LosslessStringConvertible>(selection1: Binding<Int>,
                                              values1: [T],
                                              values1Prefix: LocalizedStringKey = "",
                                              values1Suffix: LocalizedStringKey = "") {
        self.numberOfComponents = 1
        self._selection1 = selection1
        self._selection2 = .constant(0)
        self._selection3 = .constant(0)
        self.values1 = values1.map { String($0) }
        self.values2 = []
        self.values3 = []
        self.values1Prefix = values1Prefix
        self.values1Suffix = values1Suffix
        self.values2Prefix = ""
        self.values2Suffix = ""
        self.values3Prefix = ""
        self.values3Suffix = ""
        self.middleText1 = ""
        self.middleText2 = ""
    }
    
    /// Picker for two components which conform to LosslessStringConvertible (e.g. String, Int, Double)
    /// - Parameters:
    ///   - selection1: The index of the picked value of the first picker
    ///   - selection2: The index of the picked value of the second picker
    ///   - values1: The values for the first picker
    ///   - values2: The values for the second picker
    ///   - values1Prefix: The text which is displayed in on the left side of the values of the first picker.
    ///   - values1Suffix: The text which is displayed in on the right side of the values of the first picker.
    ///   - values2Prefix: The text which is displayed in on the left side of the values of the second picker.
    ///   - values2Suffix: The text which is displayed in on the right side of the values of the second picker.
    ///   - middleText: The text that is displayed between the first and second picker.
    public init<T1: LosslessStringConvertible,
                T2: LosslessStringConvertible>(selection1: Binding<Int>,
                                               selection2: Binding<Int>,
                                               values1: [T1],
                                               values2: [T2],
                                               values1Prefix: LocalizedStringKey = "",
                                               values1Suffix: LocalizedStringKey = "",
                                               values2Prefix: LocalizedStringKey = "",
                                               values2Suffix: LocalizedStringKey = "",
                                               middleText: LocalizedStringKey = "") {
        self.numberOfComponents = 2
        self._selection1 = selection1
        self._selection2 = selection2
        self._selection3 = .constant(0)
        self.values1 = values1.map { String($0) }
        self.values2 = values2.map { String($0) }
        self.values3 = []
        self.values1Prefix = values1Prefix
        self.values1Suffix = values1Suffix
        self.values2Prefix = values2Prefix
        self.values2Suffix = values2Suffix
        self.values3Prefix = ""
        self.values3Suffix = ""
        self.middleText1 = middleText
        self.middleText2 = ""
    }
    
    /// Picker for three components which conform to LosslessStringConvertible (e.g. String, Int, Double)
    /// - Parameters:
    ///   - selection1: The index of the picked value of the first picker
    ///   - selection2: The index of the picked value of the second picker
    ///   - selection3: The index of the picked value of the third picker
    ///   - values1: The values for the first picker
    ///   - values2: The values for the second picker
    ///   - values3: The values for the third picker
    ///   - values1Prefix: The text which is displayed in on the left side of the values of the first picker.
    ///   - values1Suffix: The text which is displayed in on the right side of the values of the first picker.
    ///   - values2Prefix: The text which is displayed in on the left side of the values of the second picker.
    ///   - values2Suffix: The text which is displayed in on the right side of the values of the second picker.
    ///   - values3Prefix: The text which is displayed in on the left side of the values of the third picker.
    ///   - values3Suffix: The text which is displayed in on the right side of the values of the third picker.
    ///   - middleText1: The text that is displayed between the first and second picker.
    ///   - middleText2: The text that is displayed between the second and third picker.
    public init<T1: LosslessStringConvertible,
                T2: LosslessStringConvertible,
                T3: LosslessStringConvertible>(selection1: Binding<Int>,
                                               selection2: Binding<Int>,
                                               selection3: Binding<Int>,
                                               values1: [T1],
                                               values2: [T2],
                                               values3: [T3],
                                               values1Prefix: LocalizedStringKey = "",
                                               values1Suffix: LocalizedStringKey = "",
                                               values2Prefix: LocalizedStringKey = "",
                                               values2Suffix: LocalizedStringKey = "",
                                               values3Prefix: LocalizedStringKey = "",
                                               values3Suffix: LocalizedStringKey = "",
                                               middleText1: LocalizedStringKey = "",
                                               middleText2: LocalizedStringKey = "") {
        self.numberOfComponents = 3
        self._selection1 = selection1
        self._selection2 = selection2
        self._selection3 = selection3
        self.values1 = values1.map { String($0) }
        self.values2 = values2.map { String($0) }
        self.values3 = values3.map { String($0) }
        self.values1Prefix = values1Prefix
        self.values1Suffix = values1Suffix
        self.values2Prefix = values2Prefix
        self.values2Suffix = values2Suffix
        self.values3Prefix = values3Prefix
        self.values3Suffix = values3Suffix
        self.middleText1 = middleText1
        self.middleText2 = middleText2
    }
    
    
    public var body: some View {
        GeometryReader { geometry in
            HStack {
                if numberOfComponents == 1{
                    pickerComponent1
                }else if numberOfComponents == 2{
                    pickerComponent1
                    if self.middleText1 != ""{
                        Text(self.middleText1)
                    }
                    pickerComponent2
                }else if numberOfComponents == 3{
                    pickerComponent1
                    if self.middleText1 != ""{
                        Text(self.middleText1)
                    }
                    pickerComponent2
                    if self.middleText2 != ""{
                        Text(self.middleText2)
                    }
                    pickerComponent3
                }
            }
        }
        .frame(height: height)
    }
    
    /// The first picker component
    private var pickerComponent1: PickerComponent {
        PickerComponent(selection: $selection1,
                        values: values1,
                        valuesPrefix: values1Prefix,
                        valuesSuffix: values1Suffix,
                        height: height)
    }
    
    /// The second picker component
    private var pickerComponent2: PickerComponent {
        PickerComponent(selection: $selection2,
                        values: values2,
                        valuesPrefix: values2Prefix,
                        valuesSuffix: values2Suffix,
                        height: height)
    }
    
    /// The third picker component
    private var pickerComponent3: PickerComponent {
        PickerComponent(selection: $selection3,
                        values: values3,
                        valuesPrefix: values3Prefix,
                        valuesSuffix: values3Suffix,
                        height: height)
    }
}
#endif





//MARK: - Preview
#if os(iOS)
@available(iOS 13, *)
internal struct MultiPicker_Previews: PreviewProvider {
    static var previews: some View {
        MultiPicker(selection1: .constant(0),
                    selection2: .constant(2),
                    selection3: .constant(1),
                    values1: ["-", "+"],
                    values2: [4,5],
                    values3: [6,7],
                    values2Prefix: "",
                    values2Suffix: "h",
                    values3Prefix: "",
                    values3Suffix: "m",
                    middleText2: ":")
        
        MultiPicker(selection1: .constant(2),
                    selection2: .constant(1),
                    values1: ["Hello","World"],
                    values2: [4.0, 5.3])
        
        Form{
            Text("Row")
            MultiPicker(selection1: .constant(0),
                        selection2: .constant(2),
                        selection3: .constant(1),
                        values1: ["-", "+"],
                        values2: [4,5],
                        values3: [6,7],
                        values2Prefix: "",
                        values2Suffix: "h",
                        values3Prefix: "",
                        values3Suffix: "m",
                        middleText2: ":")
            Text("Row")
        }
    }
}
#endif
