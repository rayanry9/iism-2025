import SkewedButton from "@/components/SkewedButton";
import StepProgress from "@/components/StepProgress";
import { Ionicons } from "@expo/vector-icons"; // Expo vector icons
import { useRouter } from "expo-router";
import React, { useContext, useState } from "react";
import {
  Alert,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";
import { RegisterContext } from "../../../contexts/context";

export default function Step3() {
  const { data, setData } = useContext(RegisterContext)!;
  const router = useRouter();

  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  const handleNext = () => {
    if (data.password !== data.confirmPassword) {
      Alert.alert("Error", "Passwords do not match");
      return;
    }
    router.push("/(auth)/register/step4");
  };

  return (
    <View style={styles.container}>
      <StepProgress step={3} />
      <Text style={styles.title}>ABOUT YOU</Text>

      <Text style={styles.subTitle}>Email</Text>
      <TextInput
        style={styles.input}
        value={data.email}
        onChangeText={(text) => setData({ ...data, email: text })}
        keyboardType="email-address"
        autoCapitalize="none"
        placeholder="Enter Here"
        placeholderTextColor="#999"
      />

      <Text style={styles.subTitle}>Password</Text>
      <View style={styles.passwordContainer}>
        <TextInput
          style={styles.passwordInput}
          secureTextEntry={!showPassword}
          value={data.password}
          onChangeText={(text) => setData({ ...data, password: text })}
          placeholder="Enter Here"
          placeholderTextColor="#999"
        />
        <TouchableOpacity onPress={() => setShowPassword(!showPassword)}>
          <Ionicons
            name={showPassword ? "eye-off" : "eye"}
            size={24}
            color="#FF7A00"
          />
        </TouchableOpacity>
      </View>

      <Text style={styles.subTitle}>Confirm Password</Text>
      <View style={styles.passwordContainer}>
        <TextInput
          style={styles.passwordInput}
          secureTextEntry={!showConfirmPassword}
          value={data.confirmPassword}
          onChangeText={(text) => setData({ ...data, confirmPassword: text })}
          placeholder="Enter Here"
          placeholderTextColor="#999"
        />
        <TouchableOpacity
          onPress={() => setShowConfirmPassword(!showConfirmPassword)}
        >
          <Ionicons
            name={showConfirmPassword ? "eye-off" : "eye"}
            size={24}
            color="#FF7A00"
          />
        </TouchableOpacity>
      </View>

      <SkewedButton
        title="NEXT"
        onPress={handleNext}
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
  passwordContainer: {
    flexDirection: "row",
    alignItems: "center",
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 6,
    marginBottom: 16,
    paddingHorizontal: 12,
    backgroundColor: "#fff",
  },
  passwordInput: {
    flex: 1,
    height: 50,
    color: "#000",
  },
});
