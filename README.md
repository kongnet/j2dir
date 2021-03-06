# j2dir
genrate files or directories by JSON

> 将JSON格式转化为相对路径下的目录和并使用模板文件来补全相应文件

> 找不到模板文件时,将自动产生空字节文件

> config.js 设置模板文件目录

![Build Stat](https://api.travis-ci.org/kongnet/j2dir.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/kongnet/j2dir/badge.svg?branch=master)](https://coveralls.io/github/kongnet/j2dir?branch=master)

[![NPM](https://nodei.co/npm/j2dir.png?downloads=true&stars=true)](https://nodei.co/npm/j2dir/)

[![Standard - JavaScript Style Guide](https://cdn.rawgit.com/feross/standard/master/badge.svg)](https://github.com/kongnet/j2dir)

---

**npm install j2dir**

---

```
co(function*(){
  yield waitFill(db)
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
  let outObj = yield gen.genDir(inObj, baseDir, {'templateDir': 'tools'}) //模板所在目录
  gen.printDir(baseDir, outObj)
})
```