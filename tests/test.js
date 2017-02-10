/* global describe */
/* global it */
/* global before */
/* assert before */
'use strict'
let assert = require('assert')
let $ = require('meeko')
const gen = require('../index')
const Config = require('../config')
describe('JSON格式转目录文件模块单元测试', function () {
  before(function* () {
    yield $.tools.wait(1000)
  })
  let proName = '自动化构建项目'
  it('1.目录文件生成', function* () {
    let inObj = {
      'out': {
        'www': {
          'index.html': ['index.html.tpl', {body: 'Hello World'}, '静态站点主页'],
          'css': {
            'WT.css': null,
            'WT.white.css': null
          },
          'js': {
            'WT.js': null
          },
          'img': {},
          'fonts': {}
        },
        'router': {},
        'socket-router': {},
        'tools': {},
        'tests': {},
        'models': {},
        'README.md': [null, {proName: proName}],
        'pm2.json': null,
        'package.json': null,
        'index.js': null,
        'config.js': null,
        '.gitlab-ci.yml': null,
        '.gitignore': null
      }
    }
    let baseDir = [__dirname]
    let outObj = yield gen.genDir(inObj, baseDir, Config)
    gen.printDir(baseDir, outObj)
    assert.strictEqual(outObj['out'].ifLast, 1)
  })
})
