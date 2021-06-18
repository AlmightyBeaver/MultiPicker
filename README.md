# MultiPicker

Picker for up to three values which conform to LosslessStringConvertible (e.g. String, Int, Double)


![Screenshot](/example1_small.png =293x633)


### Example Code
```
 struct MultiPickerExample: View {
     var values1: [String] = ["A", "B", "C", "D", "E", "F"]
     var values2: [Int] = Array(0...23)
     var values3: [Int] = Array(0...59)
     @State var selection1: Int = 1
     @State var selection2: Int = 1
     @State var selection3: Int = 0
     @State var hidePicker: Bool = false
     
     var body: some View {
         Group{
             Toggle("Hide Picker", isOn: $hidePicker)
             if !hidePicker{
                 Button(action: {
                     withAnimation{
                         self.selection1 = 0
                         self.selection2 = 5
                         self.selection3 = 30
                     }
                 }) {
                     Text("Set to A 5 30")
                 }
                 MultiPicker(selection1: $selection1,
                             selection2: $selection2,
                             selection3: $selection3,
                             values1: values1,
                             values2: values2,
                             values3: values3,
                             values1Prefix: ">",
                             values3Suffix: "<",
                             middleText1: "-",
                             middleText2: "-")
                 VStack(alignment: .leading){
                     Text("Value 1: \(self.values1[selection1])")
                     Text("Value 2: \(self.values2[selection2])")
                     Text("Value 3: \(self.values3[selection3])")
                 }
             }
         }
     }
 }
```
