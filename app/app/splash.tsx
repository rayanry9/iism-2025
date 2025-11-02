import { useEffect,useRef } from "react"
import { View, Text, StyleSheet, Animated } from "react-native"
import { useRouter } from "expo-router"
import { Image } from "expo-image";
import {ImageBackground} from 'react-native';
import { useWindowDimensions } from "react-native"
export default function SplashScreen() {
  const router = useRouter()
  const { width, height } = useWindowDimensions()
  

  useEffect(() => {
    const timer = setTimeout(() => {
      router.replace("/login") 
    }, 2000)

    return () => clearTimeout(timer)
  }, [])
  const scroll = useRef(new Animated.Value(0)).current

  useEffect(() => {
    Animated.loop(
      Animated.timing(scroll, {
        toValue: 200,      
        duration: 3300,    
        useNativeDriver: true,
      })
    ).start()
  }, [])

  return (
      <View   style={styles.container}  >
        <Animated.Image source={require('./assets/pattern.webp')} style={[styles.pattern,{transform: [{ translateY: scroll },{translateX:scroll}]}]}></Animated.Image>
          {/* <View style={styles.bgFade} />  */}
          <View style={styles.ribbon}>
          </View>
          <View style={styles.auxRibbon}>
          </View>
        <Image
          source={require('./assets/logo-no-text.svg')}
          style={styles.logo}
        />
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
    // width:100,
    backgroundColor: "blue",
    justifyContent: "center",
    alignItems: "center",
    opacity : 1
   
  },
  animatedContainer: {
    ...StyleSheet.absoluteFillObject, // makes it full-screen
  },
  pattern:{
    transform: [{ rotate: '10deg' }],
    opacity:0.7, 
    resizeMode:'repeat',
    width:'200%',
    height:'300%',
    left:-200,
    position:'absolute',
    // right:10,
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
  logo:{
    width: 100,
    height: 117,
    tintColor:'white'
    // borderWidth: 2,
  },
})
