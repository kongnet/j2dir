'use strict'
const $ = require('meeko')
const pack = require('./package.json')
const coMkdirp = require('mkdirp')
const fs = require('fs')
function printDir (baseDir, obj) {
  $.option.logTime = false
  $.log(`${$.c.yellow}<-- J2dir (${pack.version})${$.c.none}`)
  $.log(baseDir[0] || __dirname)
  let ifLastLevAry = []
  for (let i in obj) {
    let ifLast = obj[i].ifLast
    let lev = obj[i].lev
    let a = []
    if (ifLast) {
      ifLastLevAry[lev - 1] = 1
    }
    for (let d = 0; d < lev - 1; d++) {
      a.push(ifLastLevAry[d] ? '    ' : '│ ')
    }
    let str = a.join('') + (ifLast ? '└─ ' : '├─ ') + (obj[i].ifDir ? $.c.m(i) : i) + (obj[i].status ? $.c.green + ' success' + $.c.none : $.c.red + ' fail' + $.c.none)
    $.log(str)
  }
}
let afterCreateDir = function (i, path) {
  $.log(i, path)
}
function genDir (o, baseDir, option) {
  let outObj = {}
  let _baseDir = baseDir.copy()
  option = option || {}
  function genMain (o, path) {
    path = path || [__dirname]
    let last = null
    for (let i in o) {
      last = i
      outObj[i] = {lev: path.length, status: 0}
      if ($.tools.isObj(o[i]) && i.split('.').length < 2) { // 是目录不能有 .
        path.push(i)
        try {
          coMkdirp.sync(path.join('/'))
          outObj[last].status = 1
          outObj[last].ifDir = 1
          afterCreateDir(i, path)
        } catch (e) {
        }
        genMain(o[i], path)
        path.pop()
      } else {
        path.push(i)
        try { // 创建文件中发生错误
          let f
          if ($.tools.isNull(o[i])) {
            f = fs.readFileSync([_baseDir, option.templateDir || 'template', ''].join('/') + i + '.tpl')
          } else {
            f = fs.readFileSync([_baseDir, option.templateDir || 'template', ''].join('/') + (o[i][0] || (i + '.tpl')))
            if (o[i][1]) { f = $.tpl(f.toString()).render(o[i][1]) }
          }
          fs.writeFileSync(path.join('/'), f)
          outObj[i].status = 1
        } catch (e) {
          // $.log(e.stack)
          fs.writeFileSync(path.join('/'), '')
        }

        path.pop()
      }
    }
    if (last) {
      outObj[last].ifLast = 1 // 本层最后一个节点
    }
  }
  genMain(o, baseDir)
  return outObj
}
module.exports = {
  genDir,
  printDir,
  afterCreateDir
}
