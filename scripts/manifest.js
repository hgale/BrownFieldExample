#!/usr/bin/env node
'use strict';

var fs = require('fs');
var path = require('path');

console.log("Build manifest from files on disk");

try {
    const screenPath = path.join(__dirname, '..', 'src', 'screens');
    const iosPath = path.join(__dirname, '..', 'ios', 'BrownFieldExample', 'screens.json');
    fs.readdir(screenPath, function(err, items) {
        const skipFiles = ['NotFoundScreen'];
        let screens = {}
        if (items && items.length > 0) {
            items.forEach( (item) => {
                if (skipFiles.indexOf(item) == -1) {
                    console.log(item);
                    screens[item] = {}
                    screens[item]['screen'] = item               
                    screens[item]['config'] = item + 'Config'
                }
            })
        }
        console.log('Screens config file is', screens);
        fs.writeFileSync(iosPath, JSON.stringify(screens), 'utf8')            
        
    });
} catch(error) {
    console.log('Error reading screens directory ', error);
}