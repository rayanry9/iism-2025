import { View, Text, Button, StyleSheet } from "react-native"
import { useRouter } from "expo-router"

export default function LoginScreen() {
  const router = useRouter()

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Login</Text>
      <Button title="Log In" onPress={() => router.replace("/")} />
      <Button title="Go to Register" onPress={() => router.push("/register")} />
    </View>
  )
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: "center", justifyContent: "center" },
  title: { fontSize: 28, marginBottom: 20 },
})
