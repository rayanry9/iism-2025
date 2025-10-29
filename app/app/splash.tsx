import { useEffect } from "react"
import { View, Text, StyleSheet, ActivityIndicator } from "react-native"
import { useRouter } from "expo-router"
import {Image} from 'expo-image';
import { useWindowDimensions } from "react-native"
export default function SplashScreen() {
  const router = useRouter()
  const { width, height } = useWindowDimensions()

//   useEffect(() => {
//     const timer = setTimeout(() => {
//       router.replace("/login") 
//     }, 2000)

//     return () => clearTimeout(timer)
//   }, [])

  return (
    <View style={styles.container}>
        <View style={styles.ribbon}>
        </View>
        <View style={styles.auxRibbon}>
        </View>
      <Text style={styles.title}>My App</Text>
      <ActivityIndicator size="large" color="#007AFF" />
      <View style={styles.auxRibbon2}>
        </View>
      <View style={styles.ribbon2}>
        </View>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    justifyContent: "center",
    alignItems: "center",
   
  },
  title: {
    fontSize: 32,
    fontWeight: "bold",
    marginBottom: 20,
    
  },
  ribbon:{
    backgroundColor: '#191C2A',
    //flex:1,
    transform: [{ rotate: '-1deg' }],
    width: '100%',
    height: '8%',
      alignSelf: 'center',
        marginTop: -10,
    //  borderWidth: 4,
    // borderColor: 'black',
    position: 'absolute',
    top: 0,
    left: 0,
    zIndex: 1,
  },
  ribbon2:{
     backgroundColor: '#191C2A',
    //flex:1,
    transform: [{ rotate: '-1deg' }],
    width: '100%',
    height: '8%',
    alignSelf: 'center',
    marginBottom: -10,
    //  borderWidth: 4,
    // borderColor: 'black',
    position: 'absolute',
    bottom: 0,
    left: 0,
  },
  auxRibbon:{
    position: 'absolute',
    top: 30,
    left: -50,
    width: 500,
    height: 50,
    backgroundColor: '#F5A623',
    transform: [{ rotate: '-5deg' }],
  },
  auxRibbon2:{
    position: 'absolute',
    bottom: 30,
    left: -50,
    width: 500,
    height: 50,
    backgroundColor: '#F5A623',
    transform: [{ rotate: '-5deg' }],

  },  
})
