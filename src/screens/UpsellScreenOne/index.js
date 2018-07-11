'use strict';

import React, { Component } from 'react';

import EventBridge from 'react-native-event-bridge';
import LinearGradient from 'react-native-linear-gradient';

import { AppEvents } from '../../const';

import colors from '../../colors';

import LineImage from '../../assets/Line.png';

import Card from '../../card';
import Curve from '../../curve';

import { Dimensions, Image, View, Text, StyleSheet, TouchableOpacity } from 'react-native';

class UpsellScreenOne extends Component {
    dismissScreen = () => {
        EventBridge.emitEvent(this, AppEvents.DismissScreen);
    }

    purchase = (sku) => {
        EventBridge.emitEvent(this, AppEvents.PurchaseItem, {sku});
    }    
    
    render() {
    const {price, title, subtitle, sku, monthlyPrice} = this.props
    return (
        <LinearGradient colors={[colors.darkBlue, colors.powderBlue, colors.darkPurple]} style={styles.container}>
        <Text style={styles.title}>{title}</Text>
        <View style={styles.subTitleContainer}>
            <Text style={styles.subTitle}>{subtitle}</Text>        
        </View>
        <TouchableOpacity onPress={this.dismissScreen}>
            <View style={styles.closeButton}>
                <Text style={styles.closeX}>X</Text> 
            </View>
        </TouchableOpacity>
        <Curve color={colors.darkBlue}/>        
        <Card style={styles.cardContainer}>
            <View style={styles.lineContainer}>
                <View style={styles.lineBackground}>
                    <Image style={styles.lineImage} source={LineImage} />
                </View>
            </View>
            <Text style={styles.rnText}>React Native Screen</Text>
            <View>
                <View style={styles.priceCard}>
                    <View style={styles.priceBanner}> 
                        <Text style={styles.priceBannerText}>
                            12 outfits per year
                        </Text>
                    </View>
                    <View style={styles.priceInner}>
                        <Text style={styles.monthlyPrice}> {monthlyPrice} </Text>
                        <Text style={styles.footerPrice} > Per Month</Text>
                    </View>                    
                </View>
                <View style={styles.priceTextContainer}>
                    <Text style={styles.priceText}>{price}</Text>        
                </View>                
            </View>
            <TouchableOpacity onPress={this.purchase.bind(this, sku)}>
                <View style={styles.button}>
                    <Text style={styles.buttonText}>Purchase</Text> 
                </View>
            </TouchableOpacity>
        </Card>
        </LinearGradient>        
        );
    }
}

const width = Dimensions.get('window').width

const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
    },
    lineContainer: {
        top:-25,
        alignItems: 'center',
        justifyContent: 'center',
    },
    lineBackground: {
        alignItems: 'center',
        justifyContent: 'center',
        width: 100,
        height: 100,
        borderRadius: 100/2,
        backgroundColor: colors.white
    },
    lineImage: {
        backgroundColor: colors.white,
        justifyContent: 'center',
        alignItems: 'center'
    },
    priceBannerText: {
        color: colors.white,
        fontSize: 16,
        fontWeight: 'bold',
    },
    priceBanner:{
        backgroundColor: colors.backgroundBlue,
        borderTopLeftRadius: 2,
        alignItems: 'center',
        justifyContent: 'center', 
        borderTopRightRadius: 2,         
        height: 40, 
    },
    priceInner:{
        marginTop: 30,
        alignItems: 'center',
        justifyContent: 'center',        
    },
    footerPrice: {
        color: colors.darkText,
        fontSize: 14,
    },
    monthlyPrice: {
        color: colors.darkText,
        fontWeight: 'bold',
        fontSize: 24,
        marginBottom: 10,
    },    
    priceCard: {
        backgroundColor: colors.white,
        justifyContent: 'flex-start',        
        height: 181, 
        marginLeft: 40,
        marginRight: 40,
        borderRadius: 2,
        borderColor: '#ddd',
        borderBottomWidth: 0,
    },
    closeX: {
        color: colors.backgroundBlue,
        marginRight: 15,
        fontSize: 18,
    },
    closeButton : {
        justifyContent: 'center',
        alignItems: 'flex-end',
        height: 50, 
        width: (width * 0.8),
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
        color: colors.darkText,
        textAlign: 'center',
        fontSize: 18,
        marginTop: 20,
    },
    rnText: {
        color: colors.darkText,
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
        color: colors.darkText,
        textAlign: 'center',
      },    
    title: {
      color: colors.darkText,
      fontWeight: 'bold',
      fontSize: 20,
      textAlign: 'center',
    },
    scores: {
      textAlign: 'center',
      color: '#333333',
      marginBottom: 5,
    },
  });

export default UpsellScreenOne
