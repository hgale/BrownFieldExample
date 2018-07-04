'use strict';

import React, { Component } from 'react';

import EventBridge from 'react-native-event-bridge';

import { AppEvents } from '../../const';

import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';

class UpsellScreenOne extends Component {
    dismissScreen = () => {
        EventBridge.emitEvent(this, AppEvents.DismissScreen); 
    }

    emitEvent = () => {
        EventBridge.emitEvent(this, AppEvents.EmitEvent);
    }  
    
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>UpsellScreenOne</Text>
        <TouchableOpacity onPress={this.dismissScreen}>
          <Text style={styles.text}>Tap to dismiss </Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.emitEvent}>
          <Text style={styles.text}>Tap to trigger send </Text>
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

export default UpsellScreenOne
