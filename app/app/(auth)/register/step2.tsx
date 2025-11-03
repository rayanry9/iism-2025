import StepProgress from "@/components/StepProgress";
import { useRouter } from "expo-router";
import React, { useContext } from "react";
import { StyleSheet, Text, TextInput, View } from "react-native";
import SkewedButton from "../../../components/SkewedButton";
import { RegisterContext } from "../../../contexts/context";

export default function Step2() {
  const { data, setData } = useContext(RegisterContext)!;
  const router = useRouter();

  return (
    <View style={styles.container}>
      <StepProgress step={2} />
      <Text style={styles.title}>ABOUT YOU</Text>

      <Text style={styles.subTitle}>University</Text>
      <TextInput
        style={styles.input}
        value={data.university}
        onChangeText={(text) => setData({ ...data, university: text })}
        placeholder="Select"
        placeholderTextColor="#999"
      />

      <Text style={styles.subTitle}>Sport</Text>
      <TextInput
        style={styles.input}
        value={data.sport}
        onChangeText={(text) => setData({ ...data, sport: text })}
        placeholder="Select"
        placeholderTextColor="#999"
      />

      {/* Skewed Button */}
      <SkewedButton
        title="NEXT"
        onPress={() => router.push("/(auth)/register/step3")}
        style={{ position: "absolute", bottom: 150, alignSelf: "center" }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    padding: 20,
    paddingTop: 30,
    overflow: "visible",
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginTop: 12,
    marginBottom: 24,
    color: "#000",
    textAlign: "left",
  },
  subTitle: {
    fontSize: 16,
    fontWeight: "bold",
    marginTop: 5,
    marginBottom: 10,
  },
  input: {
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 6,
    padding: 12,
    marginBottom: 16,
    color: "#000",
  },
});
