import SkewedButton from "@/components/SkewedButton";
import StepProgress from "@/components/StepProgress";
import { useRouter } from "expo-router";
import React, { useContext } from "react";
import { StyleSheet, Text, TextInput, View } from "react-native";
import { RegisterContext } from "../../../contexts/context";

export default function Step1() {
console.log("CTX:", useContext(RegisterContext));

  const { data, setData } = useContext(RegisterContext)!;
  const router = useRouter();

  return (
    <View style={styles.container}>
      <StepProgress step={1} />
      <Text style={styles.title}>ABOUT YOU</Text>

      <Text style={styles.subTitle}>Full Name</Text>
      <TextInput
        style={styles.input}
        value={data.fullName}
        onChangeText={(text) => setData({ ...data, fullName: text })}
        placeholder="Enter Here"
        placeholderTextColor="#999"
      />

      <Text style={styles.subTitle}>Age</Text>
      <TextInput
        style={styles.input}
        keyboardType="numeric"
        value={data.age}
        onChangeText={(text) => setData({ ...data, age: text })}
        placeholder="Enter Here"
        placeholderTextColor="#999"
      />

      <Text style={styles.subTitle}>Phone No.</Text>
      <TextInput
        style={styles.input}
        keyboardType="phone-pad"
        value={data.phone}
        onChangeText={(text) => setData({ ...data, phone: text })}
        placeholder="Enter Here"
        placeholderTextColor="#999"
      />

      <SkewedButton
        title="NEXT"
        onPress={() => router.push("/(auth)/register/step2")}
        style={{ position: "absolute", bottom: 150, alignSelf: "center" }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    paddingHorizontal: 20,
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
