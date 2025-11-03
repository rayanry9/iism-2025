import React from "react";
import {
  GestureResponderEvent,
  Pressable,
  StyleSheet,
  Text,
  View,
} from "react-native";

type Props = {
  title: string;
  onPress?: (event: GestureResponderEvent) => void;
  style?: object;
};

export default function SkewedButton({ title, onPress, style }: Props) {
  return (
    <Pressable
      onPress={onPress}
      style={({ pressed }) => [
        styles.skewButton,
        pressed && styles.buttonPressed,
        style,
      ]}
    >
      <View style={styles.innerSkew}>
        <Text style={styles.buttonText}>{title}</Text>
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  skewButton: {
    backgroundColor: "#FF7A00",
    alignSelf: "center",
    paddingVertical: 12,
    paddingHorizontal: 50,
    transform: [{ skewX: "-20deg" }],
    borderRadius: 6,
    overflow: "visible",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 3,
    elevation: 3,
  },
  innerSkew: {
    transform: [{ skewX: "20deg" }],
  },
  buttonText: {
    color: "#fff",
    fontWeight: "bold",
    fontSize: 16,
    textAlign: "center",
  },
  buttonPressed: {
    opacity: 0.9,
  },
});
