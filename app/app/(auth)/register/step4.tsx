import SkewedButton from "@/components/SkewedButton";
import StepProgress from "@/components/StepProgress";
import { useRouter } from "expo-router";
import React, { useContext } from "react";
import { Alert, StyleSheet, Text, View } from "react-native";
import OTPInput from "../../../components/OtpInput";
import { RegisterContext } from "../../../contexts/context";

export default function Step4() {
  const { data, setData } = useContext(RegisterContext)!;
  const router = useRouter();

  const handleVerify = () => {
    if (!data.verificationCode) {
      Alert.alert("Error", "Please enter verification code");
      return;
    }
    Alert.alert("Success", `Email verified! Registration completed for ${data.fullName}!`);
    //router.push("/(auth)/login"); // or redirect wherever you want
  };

  return (
    <View style={styles.container}>
      <StepProgress step={4} />
      <Text style={styles.title}>EMAIL VERIFICATION</Text>

      <Text style={styles.subTitle}>
        Enter the 4 digit otp sent on your mail
      </Text>
      <OTPInput
        length={4}
        value={data.verificationCode || ""}
        onChange={(val: string) => setData({ ...data, verificationCode: val })}
      />

      <SkewedButton
        title="FINISH"
        onPress={handleVerify}
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
    marginBottom: 20,
    color: "#000",
    textAlign: "center",
  },
  subTitle: {
    fontSize: 16,
    fontWeight: "bold",
    marginTop: 0,
    marginBottom: 80,
    textAlign: "center",
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
