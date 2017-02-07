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
  it('1.目录文件生成', function* () {
    let inObj = {
      'out': {
        'www': {
          'index.html': null,
          'css': {
            'c1': {
              'WT.css': null
            },
            'c2': {}
          },
          'js': {},
          'img': {},
          'fonts': {}
        },
        'router': {},
        'tests': {},
        'models': {}
      }
    }
    let baseDir = [__dirname]
    let outObj = yield gen.genDir(inObj, baseDir, Config)
    gen.printDir(baseDir, outObj)
    assert.strictEqual(outObj['out'].ifLast, 1)
  })
})
