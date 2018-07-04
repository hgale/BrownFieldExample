'use strict';

import React, { Component } from 'react';

import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';

class NotFoundScreen extends Component {
    
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>NotFoundScreen</Text>
        <TouchableOpacity onPress={()=> {console.log('Not found');}}>
          <Text style={styles.text}>Tap </Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#FFFFFF',
    },
    text: {
      fontSize: 20,
      textAlign: 'center',
      margin: 10,
    },  
    highScoresTitle: {
      fontSize: 20,
      textAlign: 'center',
      margin: 10,
    },
    scores: {
      textAlign: 'center',
      color: '#333333',
      marginBottom: 5,
    },
  });

export default NotFoundScreen
