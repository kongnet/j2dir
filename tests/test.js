/* global describe */
/* global it */
'use strict'
let assert = require('assert')
const gen = require('../index')
const Config = require('../config')
describe('JSON格式转目录文件模块单元测试', function () {
  let proName = 'autoGen'
  it('1.SKY框架目录文件生成', function () {
    let inObj = {
      'out': {
        'models': {
          'api': {
            a: {
              b: {
                'index.js': ['index_read_all.js.tpl', null, '测试多层目录']
              }
            }
          }
        },
        'router': {
          'index.js': ['index_read_all.js.tpl', null, '路由模块加载文件']
        },
        'ws_router': {},
        'www': {
          'index.html': ['index.html.tpl', { body: 'Hello World' }, '静态站点主页'],
          'css': {
            'WT.css': [null, null, 'Meeko框架核心CSS'],
            'WT.white.css': [null, null, 'Meeko框架项目CSS']
          },
          'js': {
            'WT.js': [null, null, 'Meeko框架核心JS']
          },
          'img': {},
          'fonts': {}
        },
        'tools': {},
        'tests': {
          'zzz_zend.js': [null, null, '测试结束跳出文件']
        },
        'sql': {},
        'README.md': [null, { proName: proName }, '说明文档'],
        'nodemon.json': [null, null, '开发环境AutoReload配置文件'],
        'pm2_v4.json': [null, null, 'Test环境PM2运行文件'],
        'pm2_v5.json': [null, null, 'PreRelease环境PM2运行文件'],
        'pm2_v8.json': [null, null, 'Production环境PM2运行文件'],
        'package.json': [null, null, '第三方模块配置文件'],
        'index.js': ['index_main.js.tpl', null, '主执行文件'],
        'config.js': [null, null, '主配置文件'],
        '.gitlab-ci.yml': [null, null, '自动化部署文件'],
        '.gitignore': [null, null, 'Git忽略文件列表'],
        'a': {
          'b': {
            'index.js': ['index_read_all.js.tpl', null, '测试多层目录']
          }
        }
      }
    }
    inObj.out.sql[proName + '.sql'] = [null, null, '数据库SQL文件'] // 动态加入文件
    let baseDir = [__dirname]
    let outObj = gen.genMain(inObj, baseDir, Config)
    gen.printDir(baseDir, outObj)
    // console.log(outObj)
    assert.strictEqual(outObj['out#1'].ifLast, 1)
  })
})
