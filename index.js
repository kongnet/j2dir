'use strict'
const $ = require('meeko')
const pack = require('./package.json')
const coMkdirp = require('co-mkdirp')
const fs = require('co-fs')
const Config = require('./config')
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
      a.push(ifLastLevAry[d] ? '    ' : '│  ')
    }
    let str = a.join('') + (ifLast ? '└─' : '├─') + i + (obj[i].status ? $.c.green + ' Suc' + $.c.none : $.c.red + ' Fail' + $.c.none)
    $.log(str)
  }
}
function* genDir (o, path) {
  let outObj = {}
  function* genMain (o, path) {
    path = path || [__dirname]
    let last = null
    for (let i in o) {
      last = i
      outObj[i] = {lev: path.length, status: 0}
      if ($.tools.isObj(o[i])) { // 是目录
        path.push(i)
        try {
          coMkdirp(path.join('/'))
          outObj[last].status = 1
        } catch (e) {
        }
        yield genMain(o[i], path)
        path.pop()
      } else {
        path.push(i)
        try {
          let f = yield fs.readFile([__dirname, Config.templateDir, ''].join('/') + i + '.tpl')
          yield fs.writeFile(path.join('/'), f)
          outObj[i].status = 1
        } catch (e) {
          yield fs.writeFile(path.join('/'), '')
        }

        path.pop()
      }
    }
    if (last) {
      outObj[last].ifLast = 1 // 本层最后一个节点
    }
  }
  yield genMain(o, path)
  return outObj
}
module.exports = {
  genDir,
  printDir
}
