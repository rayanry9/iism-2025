import React, { useRef } from "react";
import { StyleSheet, TextInput, View } from "react-native";

export default function OTPInput({ length = 4, value, onChange }) {
  const inputs = Array.from({ length }, () => useRef(null));

  const handleChange = (text, index) => {
    if (/^\d*$/.test(text)) {
      const newVal = value.split("");
      newVal[index] = text;
      onChange(newVal.join(""));

      if (text && index < length - 1) {
        inputs[index + 1].current?.focus(); // move forward
      }
    }
  };

  const handleKeyPress = ({ nativeEvent }, index) => {
    if (nativeEvent.key === "Backspace" && !value[index] && index > 0) {
      // Move focus to previous box if empty
      inputs[index - 1].current?.focus();
      const newVal = value.split("");
      newVal[index - 1] = ""; // remove previous digit
      onChange(newVal.join(""));
    }
  };

  return (
    <View style={styles.container}>
      {Array.from({ length }).map((_, i) => (
        <TextInput
          key={i}
          ref={inputs[i]}
          value={value[i] || ""}
          onChangeText={(text) => handleChange(text, i)}
          onKeyPress={(e) => handleKeyPress(e, i)}
          maxLength={1}
          keyboardType="numeric"
          style={styles.box}
        />
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    justifyContent: "center",
    marginVertical: 20,
    gap: 6,
  },
  box: {
    width: 50,
    height: 50,
    borderWidth: 1,
    borderColor: "#FF7A00",
    borderRadius: 6,
    textAlign: "center",
    fontSize: 20,
    fontWeight: "bold",
    color: "#000",
    backgroundColor: "#fff",
  },
});
