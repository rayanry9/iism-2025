import React from "react";
import { StyleSheet, View } from "react-native";

type Props = {
  step: number; // current step (1–4)
  total?: number; // total steps (default 4)
};

export default function StepProgress({ step, total = 4 }: Props) {
  return (
    <View style={styles.container}>
      {Array.from({ length: total }, (_, i) => {
        const isActive = i < step;
        return (
          <View
            key={i}
            style={[
              styles.segment,
              isActive ? styles.activeSegment : styles.inactiveSegment,
              // Add spacing between rectangles
              i < total - 1 && { marginRight: 8 },
            ]}
          />
        );
      })}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
    marginVertical: 40,
  },
  segment: {
    width: 30,
    height: 7,
    borderRadius: 4,
  },
  activeSegment: {
    backgroundColor: "#FF7A00", // your orange
  },
  inactiveSegment: {
    backgroundColor: "#E5E5E5",
  },
});
