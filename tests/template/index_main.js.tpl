#!/usr/bin/env node

/* global db */
/* global redis */
'use strict'
const $ = global.$ = require('meeko')
const sky = require('./sky')
global.paramList = {} // 全局参数表
const modelList = ['mysql', 'redis', 'socket.io', 'track']
sky.start(modelList, {}, async function () {
  $.log(modelList, '模块加载完成')
})
