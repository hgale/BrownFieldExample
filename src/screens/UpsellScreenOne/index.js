'use strict';

import React, { Component } from 'react';

import EventBridge from 'react-native-event-bridge';

import { AppEvents } from '../../const';

import colors from '../../colors';

import Card from '../../card';

import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';

class UpsellScreenOne extends Component {
    dismissScreen = () => {
        EventBridge.emitEvent(this, AppEvents.DismissScreen); 
    }

    emitEvent = () => {
        EventBridge.emitEvent(this, AppEvents.EmitEvent);
    }  

    purchase = () => {
    }    
    
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>Upgrade to Premium</Text>
        <View style={styles.subTitleContainer}>
            <Text style={styles.subTitle}>Daypacks delivered everytime you travel!</Text>        
        </View>
        <Card style={styles.cardContainer}>
            <Text style={styles.redText}>MOST POPULAR</Text>
            <View>
                <View style={styles.priceCard}>
                </View>
                <View style={styles.priceTextContainer}>
                    <Text style={styles.priceText}>$179.99 per year</Text>        
                </View>                
            </View>
            <TouchableOpacity onPress={this.dismissScreen}>
                <View style={styles.button}>
                    <Text style={styles.buttonText}>Purchase</Text> 
                </View>
            </TouchableOpacity>
        </Card>
      </View>
    );
  }
}

const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: colors.backgroundBlue,
    },
    priceCard: {
        backgroundColor: colors.white,
        justifyContent: 'center',
        height: 181, 
        marginLeft: 40,
        marginRight: 40,        
        // marginBottom: 40,
        borderRadius: 2,
        borderColor: '#ddd',
        borderBottomWidth: 0,
    },
    button: {
        backgroundColor: colors.backgroundBlue,
        justifyContent: 'center',
        height: 50, 
        margin: 20,
        marginBottom: 40,
        borderRadius: 3,
        borderColor: '#ddd',
        borderBottomWidth: 0,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.8,
        shadowRadius: 2,
        elevation: 1,        
    },
    cardContainer: {
        justifyContent: 'space-between'
    },
    priceTextContainer: {
        marginTop: 5,
    },
    priceText: {
        color: colors.lightBlue,
        textAlign: 'center',
        // fontWeight: 'bold',
        fontSize: 18,
        marginTop: 20,
    },
    redText: {
        color: colors.red,
        textAlign: 'center',
        fontSize: 16,
        marginTop: 20,
    },
    text: {
      fontSize: 20,
      textAlign: 'center',
      margin: 10,
    },
    subTitleContainer: {
        marginTop: 20,
        marginBottom: 20,
        width: 190,
    },
    buttonText: {
        fontSize: 18,
        color: colors.white,        
        textAlign: 'center',
    },
    subTitle: {
        fontSize: 16,
        color: colors.white,        
        textAlign: 'center',
        margin: 10,
      },    
    title: {
      color: colors.white,
      fontWeight: 'bold',
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
