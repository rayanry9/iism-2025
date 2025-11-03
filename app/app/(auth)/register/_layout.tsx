import { useColorScheme } from "@/hooks/use-color-scheme.web";
import { RegisterProvider } from "../../../contexts/context";
import {
  DarkTheme,
  DefaultTheme,
  ThemeProvider,
} from "@react-navigation/native";
import { Stack } from "expo-router";
import { StatusBar } from "expo-status-bar";

export default function RootLayout() {
  const colorScheme = useColorScheme();

  return (
    <ThemeProvider value={colorScheme === "dark" ? DarkTheme : DefaultTheme}>
      <RegisterProvider>
        <Stack>
          <Stack.Screen name="(tabs)" options={{ headerShown: false }} />

          {/* <Stack.Screen name="(auth)/login" /> */}
          <Stack.Screen name="(auth)/register/step1" />
          <Stack.Screen name="(auth)/register/step2" />
          <Stack.Screen name="(auth)/register/step3" />
          <Stack.Screen name="(auth)/register/step4" />

          <Stack.Screen
            name="modal"
            options={{ presentation: "modal", title: "Modal" }}
          />
        </Stack>
      </RegisterProvider>
      <StatusBar style="auto" />
    </ThemeProvider>
  );
}
