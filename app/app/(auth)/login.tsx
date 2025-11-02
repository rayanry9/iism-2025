import { View, Text, Button, StyleSheet, TouchableOpacity } from "react-native"
import { useRouter } from "expo-router"
import {Image} from 'expo-image'
import { ImageBackground } from "react-native"
// import url('https://db.onlinewebfonts.com/c/eed066243d2331905b38c825a9c301f8?family=OptimaNovaLTPro-Regular'); 

export default function LoginScreen() {
  const router = useRouter()

  return (
    <View style={styles.container}>
      <View style={styles.top}>
        <Image
          source={require('../assets/legacy-mobile.webp')}
          style={styles.topbg}
        />
        <Image
          source={require('../assets/logo-no-text.svg')}
          style={styles.logo}
        />
      </View>
      <View style={styles.auxRibbon}></View>
      <View style={styles.bottom}>
          <ImageBackground source={require('../assets/pattern.webp')} style={[styles.pattern]} imageStyle={{resizeMode:'repeat'}}></ImageBackground>
          <Text style={styles.registered}>If you're already registered</Text>
         <TouchableOpacity style={styles.login}  onPress={() => router.replace("/register")}>
            <Text style={[styles.text,{color:'white'}]}>LOGIN</Text>
          </TouchableOpacity>
          <Text style={styles.new}>NEW HERE?</Text>
        <TouchableOpacity style={styles.register} onPress={() => router.push("/register")} > 
          <Text style={[styles.text,{color:'blue'}]}>REGISTER NOW</Text>
        </TouchableOpacity>
      </View>
    </View>
    
  )
}

const styles = StyleSheet.create({
  
  container: { flex: 1, alignItems: "center" },
  // title: { fontSize: 28, marginBottom: 20 },
  top:{
    width:'99%',
    height:'50%',
    alignItems:'center',
    flexDirection:'column',
    // borderWidth: 2,
    borderColor:'white',
  },
  topbg:{
    // borderWidth: 1,
    // marginTop:20,
    borderColor:'white',
    width:'100%',
    height:'95%',
    opacity:0.5,
    zIndex:0,

    // position:'absolute',
  },
  logo:{
    width: 100,
    height: 117,
    tintColor:'white',
    bottom:230,
    left:5,
    zIndex:1,
  },
  bottom:{
    backgroundColor:"blue",
    // borderWidth:2,
    // borderColor:"white",
    width:"100%",
    height:"100%",
    top:-33,
    zIndex:0,
    alignItems:'center'

  },
  auxRibbon:{
    // position: 'absolute',
    top: -24,
    // borderWidth:2,
    // borderColor:"white",
    left: -50,
    width: 500,
    height: 20,
    backgroundColor: '#F5A623',
    transform: [{ rotate: '-2deg' }],
    zIndex:0.5,
  },
  pattern:{
    transform: [{ rotate: '2deg' }],
    opacity:0.7, 
    // resizeMode:'repeat',
    width:'100%',
    height:'100%',
    left:-10,
    top:5,
    zIndex:-1,
    // left:100,
    position:'absolute',
    
  },
  registered:{
    position:'relative',
    fontSize:18,
    fontFamily:'OptimaNova',
    // width:10,
    color:'white',
    zIndex:1,
    // height:20,
    top:30,
    // left:70,
    
  },
  login:{
    // transform: [{ rotate: '1deg' }],
    transform: [
      { skewX: '-30deg' }, // This creates the parallelogram effect
    ],
    
    backgroundColor:'#F67E24',
    // position:'relative',
    height:40,
    // flex:1,
    alignItems:'center',
    justifyContent:'center',
    fontFamily:'OptimaNova',
    width:120,
    top:50,
    color:'white'
  },
  register:{
    top:100,
    backgroundColor:'white',
    alignItems:'center',
    justifyContent:'center',
      // fontFamily:'OptimaNova',
    height:40,
    
    width:120,
  },
  new :{
      color:'white',
      
      top:80,
      fontFamily:'OptimaNova',
      fontSize:16,
      // left:135,
  },
  text:{
    // flex:1,
    // alignItems:'center',
    // left:150,
      fontSize:16,

      fontFamily:'OptimaNova',
      transform: [
      { skewX: '30deg' }, // This creates the parallelogram effect
    ],

  }
})
