'use strict'
const $ = require('meeko')
const pack = require('./package.json')
const coMkdirp = require('mkdirp')
const fs = require('fs')
function printDir (baseDir, obj) {
  $.option.logTime = false
  $.log(`${$.c.yellow}<-- J2dir (${pack.version})${$.c.none}`)
  $.log(baseDir[0] || __dirname)
  for (let i in obj) {
    let ary = i.split('#')
    ary.pop()
    let newI = ary.join('#')
    let ifLast = obj[i].ifLast
    let lev = obj[i].lev

    let aPath = obj[i].path.split('/')
    let blankCount = 0
    for (let i = aPath.length - 1; i >= 1; i--) {
      if (obj[aPath[i] + '#' + (i + 1)].ifLast) {
        blankCount++
      } else {
        break
      }
    }
    let preS1 = (lev > 1 ? '   ' : '') + '│  '.times(lev - 2 - blankCount) + '  '.times(blankCount)
    let s1 = (ifLast ? '└─ ' : '├─ ') + (obj[i].ifDir ? $.c.m(newI) : newI)
    let diffLen = s1.length - i.length - preS1.length
    let s2 = (obj[i].status ? $.c.green + ' success' + $.c.none : $.c.red + ' fail' + $.c.none)
    let str = preS1 + s1.fillStr(' ', 30 + diffLen) + s2.fillStr(' ', 25) + obj[i].desc
    $.log(str)
  }
}
let afterCreateDir = function (i, path) {
  // $.log(i, path)
}
function genMain (o, baseDir, option) {
  let outObj = {}
  let _baseDir = baseDir.copy()
  option = option || {}
  function genDirFile (o, path) {
    path = path || [__dirname]
    let last = null
    for (let i in o) {
      last = i + '#' + path.length // 组成唯一标识
      outObj[last] = { lev: path.length, status: 0 }
      outObj[last].desc = (o[i] || [])[2] || ''
      if ($.tools.isObj(o[i]) && i.split('.').length < 2) { // 是目录不能有 .
        path.push(i)
        try {
          coMkdirp.sync(path.join('/'))
          outObj[last].status = 1
          outObj[last].ifDir = 1
          afterCreateDir(i, path)
        } catch (e) {
        }
        genDirFile(o[i], path)
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
          outObj[last].status = 1
        } catch (e) {
          // $.log(e.stack)
          fs.writeFileSync(path.join('/'), '')
        }
        path.pop()
      }
      // 压入父结构
      let p = path.copy()
      p.shift()
      outObj[last].path = p.join('/')
    }
    if (last) {
      outObj[last].ifLast = 1 // 本层最后一个节点
    }
  }
  genDirFile(o, baseDir)
  return outObj
}
module.exports = {
  genMain,
  printDir,
  afterCreateDir
}
