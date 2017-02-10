!(function () {
  'use strict'
  var u = navigator.userAgent.toLowerCase(),
    ifMobile = (!!u.match(/applewebkit.*mobile.*/) || !!u.match(/applewebkit/)) && ((u.indexOf('android') > -1 || u.indexOf('linux') > -1) || (u.indexOf('iphone') > -1 || u.indexOf('mac') > -1)),
    isIOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
    isIE = (u.indexOf('msie') > 0),
    isFF = (u.indexOf('firefox') > 0),
    bsVer = (u.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1],
    $D = document,
    $DB = document.body,
    $LS = window.localStorage,
    $W = window,
    $DE = $D.documentElement,
    isPad = ('createTouch' in $D),
    $ = function (s) {
      if (s === '' || !s) {
        return WT.getType()
      }
      var t = typeof (s)
      if (t === 'function') {
        WT.onReady(s)
      } else {
        return (t === 'string' ? (s.charAt(0) === '{' ? (eval('(' + s + ')')) : WT.ext($D.getElementById(s), _x)) : WT.ext(s, _x))
      }
    }
  if (isIE) {
    try {
      $D.execCommand('BackgroundImageCache', false, true)
    } catch (e) {
      return 0
    }
  }
  if (!isIE) {
    HTMLElement.prototype.insertAdjacentElement = function (w, p) {
      switch (w) {
        case 'beforeBegin':
          return $(this.parentNode.insertBefore(p, this))
        case 'afterBegin':
          return $(this.insertBefore(p, this.firstChild))
        case 'beforeEnd':
          return $(this.appendChild(p))
        case 'afterEnd':
          if (this.nextSibling) {
            return $(this.parentNode.insertBefore(p, this.nextSibling))
          } else {
            return $(this.parentNode.appendChild(p))
          }
      }
    }
  }
  var $$ = (function () {
    var b = /(?:[\w\-\\.#]+)+(?:\[\w+?=([\'"])?(?:\\\1|.)+?\1\])?|\*|>/ig,
      g = /^(?:[\w\-_]+)?\.([\w\-_]+)/,
      f = /^(?:[\w\-_]+)?#([\w\-_]+)/,
      j = /^([\w\*\-_]+)/,
      h = [null, null]

    function d (o, m) {
      m = m || document
      var k = /^[\w\-_#]+$/.test(o)
      if (!k && m.querySelectorAll) {
        return c(m.querySelectorAll(o))
      }
      if (o.indexOf(',') > -1) {
        var v = o.split(/,/g),
          t = [],
          s = 0,
          r = v.length
        for (; s < r; ++s) {
          t = t.concat(d(v[s], m))
        }
        return e(t)
      }
      var p = o.match(b),
        n = p.pop(),
        l = (n.match(f) || h)[1],
        u = !l && (n.match(g) || h)[1],
        w = !l && (n.match(j) || h)[1],
        q
      if (u && !w && m.getElementsByClassName) {
        q = c(m.getElementsByClassName(u))
      } else {
        q = !l && c(m.getElementsByTagName(w || '*'))
        if (u) {
          q = i(q, 'className', RegExp('(^|\\s)' + u + '(\\s|$)'))
        }
        if (l) {
          var x = m.getElementById(l)
          return x ? [x] : []
        }
      }
      return p[0] && q[0] ? a(p, q) : q
    }

    function c (o) {
      try {
        return Array.prototype.slice.call(o)
      } catch (n) {
        var l = [],
          m = 0,
          k = o.length
        for (; m < k; ++m) {
          l[m] = o[m]
        }
        return l
      }
    }

    function a (w, p, n) {
      var q = w.pop()
      if (q === '>') {
        return a(w, p, true)
      }
      var s = [],
        k = -1,
        l = (q.match(f) || h)[1],
        t = !l && (q.match(g) || h)[1],
        v = !l && (q.match(j) || h)[1],
        u = -1,
        m, x, o
      v = v && v.toLowerCase()
      while ((m = p[++u])) {
        x = m.parentNode
        do {
          o = !v || v === '*' || v === x.nodeName.toLowerCase()
          o = o && (!l || x.id === l)
          o = o && (!t || RegExp('(^|\\s)' + t + '(\\s|$)').test(x.className))
          if (n || o) {
            break
          }
        } while ((x = x.parentNode))
        if (o) {
          s[++k] = m
        }
      }
      return w[0] && s[0] ? a(w, s) : s
    }
    var e = (function () {
      var k = +new Date()
      var l = (function () {
        var m = 1
        return function (p) {
          var o = p[k],
            n = m++
          if (!o) {
            p[k] = n
            return true
          }
          return false
        }
      })()
      return function (m) {
        var s = m.length,
          n = [],
          q = -1,
          o = 0,
          p
        for (; o < s; ++o) {
          p = m[o]
          if (l(p)) {
            n[++q] = p
          }
        }
        k += 1
        return n
      }
    })()

    function i (q, k, p) {
      var m = -1,
        o, n = -1,
        l = []
      while ((o = q[++m])) {
        if (p.test(o[k])) {
          l[++n] = o
        }
      }
      return l
    }
    return d
  })()
  var _s = {
      toMoney: function (p) {
        var num = this + ''
        num = num.replace(new RegExp(',', 'g'), '')
        var symble = ''
        if (/^([-+]).*$/.test(num)) {
          symble = num.replace(/^([-+]).*$/, '$1')
          num = num.replace(/^([-+])(.*)$/, '$2')
        }
        if (/^[0-9]+(\.[0-9]+)?$/.test(num)) {
          num = num.replace(new RegExp('^[0]+', 'g'), '')
          if (/^\./.test(num)) {
            num = '0' + num
          }
          var decimal = num.replace(/^[0-9]+(\.[0-9]+)?$/, '$1')
          var integer = num.replace(/^([0-9]+)(\.[0-9]+)?$/, '$1')
          var re = /(\d+)(\d{3})/
          while (re.test(integer)) {
            integer = integer.replace(re, '$1,$2')
          }
          if (+p) {
            decimal = decimal.substr(0, (+p + 1))
          }
          if (p === 0) {
            decimal = ''
          }
          return symble + integer + decimal
        } else {
          return p
        }
      },
      toLow: function () {
        return this.toLowerCase()
      },
      toUp: function () {
        return this.toUpperCase()
      },
      esHtml: function () {
        return this.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      },
      toHtml: function () {
        return this.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&')
      },
      reHtml: function () {
        return this.replace(/<\/?[^>]+>/gi, '')
      },
      times: function (n) {
        return n ? new Array(n + 1).join(this) : ''
      },
      format: function () {
        var s = this,
          a = []
        for (var i = 0, l = arguments.length; i < l; i++) {
          a.push(arguments[i])
        }
        return s.replace(/\{(\d+)\}/g, function (m, i) {
          return a[i] || '{' + i + '}'
        })
      },
      len: function () {
        return this.replace(/[^\x00-\xff]/g, '**').length
      },
      toInt: function () {
        return parseInt(this)
      },
      toElm: function (s) {
        var o = $(s)
        o.h(this)
        return o
      },
      isDate: function () {
        var r = this.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/)
        if (r === null) {
          return false
        }
        var d = new Date(r[1], r[3] - 1, r[4])
        return (d.getFullYear() === r[1] && (d.getMonth() + 1) === r[3] && d.getDate() === r[4])
      },
      isTime: function () {
        var r = this.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/)
        if (r === null) {
          return false
        }
        var d = new Date(r[1], r[3] - 1, r[4], r[5], r[6], r[7])
        return (d.getFullYear() === r[1] && (d.getMonth() + 1) === r[3] && d.getDate() === r[4] && d.getHours() === r[5] && d.getMinutes() === r[6] && d.getSeconds() === r[7])
      },
      replaceAll: function (s1, s2) {
        var a = this.split(s1)
        return a.join(s2)
      },
      test: function (r) {
        return r.test(this)
      },
      trim: function () {
        return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '')
      },
      camelize: function () {
        return this.replace(/(-[a-z])/g, function (s) {
          return s.substring(1).toUpperCase()
        })
      },
      ec: function (s) {
        s = s.trim()
        return (new RegExp('(^' + s + '\\s)|(\\s' + s + '$)|(\\s' + s + '\\s)|(^' + s + '$)', 'g')).test(this)
      },
      tc: function (s) {
        s = s.trim()
        if (this.ec(s)) {
          return this.dc(s)
        } else {
          return this.ac(s)
        }
      },
      dc: function (s) {
        s = s.trim()
        if (this.ec(s)) {
          return this.trim().split(s).join('').replace(/\s{2,}/g, ' ')
        } else {
          return this
        }
      },
      ac: function (s) {
        s = s.trim()
        return this.trim().dc(s) + ' ' + s
      }
    },
    _a = {
      max: function () {
        return Math.max.apply({}, this)
      },
      min: function () {
        return Math.min.apply({}, this)
      },
      copy: function () {
        return [].concat(this)
      },
      clear: function () {
        this.length = 0
        return this
      },
      re: function (v) {
        while (true) {
          var n = this.idxOf(v)
          if (n >= 0) {
            this.reAt(n)
          } else {
            return this
          }
        }
      },
      reAt: function (n) {
        this.splice(n, 1)
        return this
      },
      unique: function () {
        var a = {}
        for (var i = 0, l = this.length; i < l;) {
          a[this[i++]] = 1
        }
        this.length = 0
        for (i in a) {
          this[this.length] = i
        }
        return this
      },
      combine: function () {
        return [].concat.apply(this, arguments).unique()
      },
      ec: function (fn) {
        try {
          for (var i = 0, l = this.length; i < l;) {
            fn.call(this, i++)
          }
        } catch (e) {
          return this
        }
        return this
      },
      idxOf: function (v) {
        var me = this
        if ([].indexOf) {
          return me.indexOf(v)
        } else {
          for (var i = 0, l = me.length; i < l; i++) {
            if (me[i] === v) {
              return i
            }
          }
          return -1
        }
      }
    },
    _d = {
      date8: function (s) {
        var m = this.getMonth() + 1,
          d = this.getDate()
        m = m <= 9 ? ('0' + m) : m
        d = d <= 9 ? ('0' + d) : d
        s = s || ''
        return [this.getFullYear(), m, d].join(s)
      },
      date2Str: function () {
        var y = this.getFullYear()
        var mon = (this.getMonth() + 1)
        mon = mon < 10 ? ('0' + mon) : mon
        var date = this.getDate()
        date = date < 10 ? ('0' + date) : date
        var hour = this.getHours()
        hour = hour < 10 ? ('0' + hour) : hour
        var min = this.getMinutes()
        min = min < 10 ? ('0' + min) : min
        var sec = this.getSeconds()
        sec = sec < 10 ? ('0' + sec) : sec
        return (y + '-' + mon + '-' + date + ' ' + hour + ':' + min + ':' + sec)
      },
      str2Date: function (str) {
        if (!str) {
          return false
        }
        var a = str.match(/[0-9]+/g)
        this.setFullYear(parseInt(a[0] || 1900), parseInt(a[1] || 1) - 1, parseInt(a[2] || 1))
        this.setHours(parseInt(a[3] || 0))
        this.setMinutes(parseInt(a[4] || 0))
        this.setSeconds(parseInt(a[5] || 0))
        return this
      }
    },
    _f = {
      help: function (s, e) {
        var l = '' + this
        s = s || '/*'
        e = e || '*/'
        l = l.substring(l.indexOf(s) + 3, l.lastIndexOf(e))
        return l.trim()
      }
    },
    _w = {
      timeIntervalArray: [],
      ifMobile: ifMobile,
      isIE: isIE,
      isPad: isPad,
      $D: $D,
      $DB: $DB,
      $B: $DB,
      $LS: $LS,
      $W: $W,
      $Ef: function (s) {
        return $(s)
      },
      $DBf: function () {
        return $DB
      },
      $Fg: function () {
        return $($D.createDocumentFragment())
      },
      $C: function (id, tag) {
        var e = $D.createElement(tag)
        if (id !== '' && id !== null) {
          e.setAttribute('id', id)
        }
        return $(e)
      },
      $$: $$,
      $A: function (o, b) {
        if (!o) {
          return []
        }
        if (o.toArray) {
          return o.toArray()
        }
        var l = o.length || 0,
          r = new Array(l)
        while (l--) {
          r[l] = o[l]
        }
        return r
      },
      $S: function (s) {
        if (!s) {
          return null
        }
        return (typeof (s) === 'string' ? $(s).style : s.style)
      }
    },
    _x = {
      alpha: function (a) {
        if (a || a === '') {
          if (isIE && +bsVer < 10) {
            this.alp = a / 100
            $S(this).filter = 'alpha(opacity=' + a + ')'
          } else {
            $S(this).opacity = a / 100
          }
          return this
        } else {
          if (isIE) {
            if ($S(this).filter === '') {
              return 0
            }
            return parseInt(this.filters.alpha.opacity)
          } else {
            if ($S(this).opacity === '') {
              return 0
            }
            return parseInt($S(this).opacity * 100)
          }
        }
      },
      ease: function (propArray, endProp, during, type, backFun, ifQ, ifPx) {
        ifPx = ifPx || 'px'
        if (ifPx === '') {
          ifPx = 0
        }
        type = (type === 1 || ($.Tween[type] === undefined)) ? 'easeNone' : type
        var me = this,
          dt = [],
          pAry = [],
          bAry = [],
          eAry = [],
          sAry = [],
          l = propArray.length
        for (var i = 0; i < l; i++) {
          pAry.push(propArray[i].camelize())
          eAry.push(endProp[i])
          var _s = $S(me)[pAry[i]] || '0'
          if (pAry[i] === 'alpha') {
            _s = me.alpha()
          }
          _s = parseInt(_s)
          sAry.push(_s)
          dt.push(eAry[i] - _s)
          bAry.push(_s)
        }
        var n = 0
        var step = 16
        var time = setTimeout(anitime, step)
        timeIntervalArray.push(time)

        function anitime () {
          var tAdjust = during - step
          n += 2 * step
          if (n >= during) {
            for (var k = 0; k < l; k++) {
              if (pAry[k] === 'alpha') {
                me.alpha(eAry[k])
              } else {
                $S(me)[pAry[k]] = eAry[k] + ifPx
              }
            }
            var fun = backFun.e || ''
            if (typeof (fun) === 'string') {
              eval(fun)
            } else {
              fun()
            }
            clearTimeout(time)
            return
          }
          for (var i = 0; i < l; i++) {
            sAry[i] = $.Tween[type](n, bAry[i], dt[i], during)
            if (pAry[i] === 'alpha') {
              me.alpha(sAry[i])
            } else {
              $S(me)[pAry[i]] = Math.ceil(sAry[i]) + ifPx
            }
          }
          setTimeout(anitime, step)
          var ff = backFun.f || ''
          if (typeof (ff) === 'string') {
            eval(ff)
          } else {
            ff()
          }
        }
        return this
      },
      adElm: function (a, b) {
        var e = $C(a, b)
        this.appendChild(e)
        return $(e)
      },
      appendTo: function (o) {
        o.appendChild(this)
        return this
      },
      bbElm: function (a, b) {
        var e = $C(a, b)
        this.insertAdjacentElement('beforeBegin', e)
        return $(e)
      },
      abElm: function (a, b) {
        var e = $C(a, b)
        this.insertAdjacentElement('afterBegin', e)
        return $(e)
      },
      aeElm: function (a, b) {
        var e = $C(a, b)
        this.insertAdjacentElement('afterEnd', e)
        return $(e)
      },
      beElm: function (a, b) {
        var e = $C(a, b)
        this.insertAdjacentElement('beforeEnd', e)
        return $(e)
      },
      attr: function (a, s) {
        if (arguments.length === 1) {
          return this.getAttribute(a)
        } else {
          if (isIE && this.tagName === 'INPUT' && a === 'type') {
            var t = this.outerHTML.split(a + '=' + this.attr(a))
            if (t.length > 1) {
              this.outerHTML = t.join(a + '=' + s)
            } else {
              this.outerHTML = this.outerHTML.replace('>', ' ' + a + '=' + s + '>')
            }
          } else {
            this.setAttribute(a, s)
          }
          return $(this)
        }
      },
      reAttr: function (s) {
        this.removeAttribute(s)
        return this
      },
      ac: function (s) {
        this.cn(this.cn().ac(s))
        return this
      },
      dc: function (s) {
        var me = this,
          c = this.cn()
        me.cn(c.dc(s))
        return me
      },
      tc: function (s) {
        this.cn(this.cn().tc(s))
        return this
      },
      chn: function (n) {
        return $(this.childNodes[n])
      },
      chr: function (n) {
        return $(this.children[n])
      },
      cn: function (s) {
        if (s || s === '') {
          this.className = s
          return this
        } else {
          return this.className
        }
      },
      cs: function (s) {
        if (isIE) {
          if (s === 'top') {
            return this.offsetTop
          }
          if (s === 'left') {
            return this.offsetLeft
          }
          if (s === 'width') {
            return this.offsetWidth
          }
          if (s === 'height') {
            return this.offsetHeight
          }
          if (s === 'background-position' && +$('').split(',')[1] < 9) {
            return this.currentStyle['backgroundPositionX'] + ' ' + this.currentStyle['backgroundPositionY']
          }
          return this.currentStyle[s.camelize()]
        } else {
          return window.getComputedStyle(this, null).getPropertyValue(s)
        }
      },
      csn: function (s) {
        return parseInt(this.cs(s))
      },
      css: function (s) {
        var me = this,
          l = s.split(';')
        l.ec(function (i) {
          var t = this[i].split(':')
          var s
          if (t[2]) {
            s = t[1] + ':' + t[2]
          } else {
            s = t[1]
          }
          if (t[0] === 'float') {
            if (isIE) {
              t[0] = 'style-float'
            } else {
              t[0] = 'css-float'
            }
          }
          if (t[0]) {
            $S(me)[t[0].camelize()] = s
          }
        })
        return me
      },
      evt: function (s, f, c) {
        if (!c) {
          c = false
        }
        f = f || function () {}
        if (s === 'tap') {
          this.evt('touchstart', function (e) {
            e = WT.e.fix(e)
            var touches = e.touches[0]
            $.startTx = touches.clientX
            $.startTy = touches.clientY
          }, c)
          this.evt('touchend', function (e) {
            e = WT.e.fix(e)
            var touches = e.changedTouches[0]
            $.endTx = touches.clientX
            $.endTy = touches.clientY
            if (Math.abs($.startTx - $.endTx) < 6 && Math.abs($.startTy - $.endTy) < 6) {
              this.ac('pen')
              try {
                f(e)
              } catch (e) {
                return e
              }
              this.dc('pen')
            }
          }, c)
        }
        if (s === 'move') {
          var startPosition, endPosition, deltaX, deltaY, moveLength
          this.addEventListener('touchstart', function (e) {
            var touch = e.touches[0]
            startPosition = {
              x: touch.clientX,
              y: touch.clientY
            }
          })
          this.addEventListener('touchmove', function (e) {
            e = WT.e.fix(e), _e = e.t
            var touch = e.touches[0]
            endPosition = {
              x: touch.clientX,
              y: touch.clientY
            }
            deltaX = endPosition.x - startPosition.x
            deltaY = endPosition.y - startPosition.y
            moveLength = Math.sqrt(Math.pow(Math.abs(deltaX), 2) + Math.pow(Math.abs(deltaY), 2))
            f({
              startX: startPosition.x,
              startY: startPosition.y,
              deltaX: deltaX,
              deltaY: deltaY,
              len: moveLength,
              type: 'move',
              e: e,
              _e: _e
            })
          })
          this.addEventListener('touchend', function (e) {
            e = WT.e.fix(e)
            var touch = e.changedTouches[0]
            endPosition = {
              x: touch.clientX,
              y: touch.clientY
            }
            deltaX = endPosition.x - startPosition.x
            deltaY = endPosition.y - startPosition.y
            moveLength = Math.sqrt(Math.pow(Math.abs(deltaX), 2) + Math.pow(Math.abs(deltaY), 2))
            f({
              startX: startPosition.x,
              startY: startPosition.y,
              deltaX: deltaX,
              deltaY: deltaY,
              len: moveLength,
              type: 'end'
            })
          })
        }
        if (isFF && s === 'mousewheel') {
          s = 'DOMMouseScroll'
        }
        isIE ? this.attachEvent('on' + s, f, c) : this.addEventListener(s, f, c)
        return this
      },
      revt: function (s, f, c) {
        if (c === undefined) {
          c = false
        }
        isIE ? this.detachEvent('on' + s, f, c) : this.removeEventListener(s, f, c)
        return this
      },
      fevt: function (s) {
        var e
        if ($D.createEventObject) {
          e = $D.createEventObject()
          this.fireEvent('on' + s, e)
        } else {
          e = $D.createEvent('HTMLEvents')
          e.initEvent(s, true, true)
          this.dispatchEvent(e)
        }
        return this
      },
      fc: function () {
        return $(this.firstChild)
      },
      insertA: function (o) {
        return o.insertAdjacentElement('afterEnd', this.cloneNode(true))
      },
      insertB: function (o) {
        return o.insertAdjacentElement('beforeBegin', this.cloneNode(true))
      },
      moveA: function (o) {
        var a = this.insertA(o)
        this.r()
        return a
      },
      moveB: function (o) {
        var a = this.insertB(o)
        this.r()
        return a
      },
      ps: function () {
        return $(this.previousSibling)
      },
      ns: function () {
        return $(this.nextSibling)
      },
      fcs: function () {
        this.focus()
        return this
      },
      find: function (s, c) {
        return (function f (s, o, c) {
          o = o || $D
          s = !s || s === '.' ? '*' : s
          var r = RegExp
          if (o.length === 0) {
            return []
          }
          if (/^(\w+|\*)$/.test(s)) {
            return o.getElementsByTagName(s)
          }
          if (/^#(\w+)(?:[\s>]?(.*))?$/.test(s)) {
            return r.$2 ? f(r.$2, o.getElementById(r.$1)) : o.getElementById(r.$1)
          }
          if (/^\.(.*)$/.test(s)) {
            c = (c ? r.$1 : 'class=' + r.$1).split('=')
            for (var t, i = 0, ci, a = [], o = o.length ? o : o.getElementsByTagName('*'); ci = o[i++];)(t = ci.getAttributeNode(c[0])) && (c[1] ? t.value === c[1] : 1) && a.push(ci)
            return a
          }
          if (/^(\w+)(\..*)$/.test(s)) {
            return f(r.$2, f(r.$1, o))
          }
          if (/^(\w+):(.*)$/.test(s)) {
            return f('.' + r.$2, f(r.$1, o), 1)
          }
          return []
        })(s, this, c)
      },
      replaceHtml: function (s) {
        var e = this.cloneNode(false),
          d = this.parentNode ? this.parentNode : $D
        e.innerHTML = s
        d.replaceChild(e, this)
        return this
      },
      h: function (s) {
        if (s || s === '') {
          this.innerHTML = s
          return this
        } else {
          return this.innerHTML
        }
      },
      ht: function (s) {
        if (this.innerText) {
          if (s || s === '') {
            this.innerText = s
            return this
          } else {
            return this.innerText || ''
          }
        } else {
          if (s || s === '') {
            this.textContent = s
            return this
          } else {
            return this.textContent || ''
          }
        }
      },
      hide: function () {
        return this.css('display:none')
      },
      pos: function (p) {
        var x = 0,
          y = 0,
          w = 0,
          h = 0
        p = p || $DB
        if (this.getBoundingClientRect) {
          var box = this.getBoundingClientRect()
          x = box.left + Math.max($DE.scrollLeft, $DB.scrollLeft) - $DE.clientLeft
          y = box.top + Math.max($DE.scrollTop, $DB.scrollTop) - $DE.clientTop
        } else {}
        w = this.offsetWidth
        h = this.offsetHeight
        return {
          x: x,
          y: y,
          w: w,
          h: h
        }
      },
      posFix: function () {
        return {
          x: this.getBoundingClientRect().left,
          y: this.getBoundingClientRect().top,
          w: this.offsetWidth,
          h: this.offsetHeight
        }
      },
      pn: function (n) {
        if (!n) {
          return $(this.parentNode)
        }
        var p = this
        while (n) {
          p = p.parentNode
          n--
        }
        return $(p)
      },
      r: function () {
        if (this && this.parentNode) {
          this.parentNode.removeChild(this)
        }
      },
      val: function (s) {
        if (s || s === '') {
          this.value = s
          return this
        } else {
          return this.value
        }
      },
      show: function () {
        return this.css('display:block').dc('dn')
      },
      meeko: 'kongNet'
    },
    _e = {
      fix: function (e) {
        e = e || window.event
        e.stop = function () {
          if (isIE) {
            e.cancelBubble = true
          } else {
            e.stopPropagation()
          }
          e.pDefault()
        }
        e.pDefault = function () {
          if (isIE) {
            e.returnValue = false
          } else {
            e.preventDefault()
          }
        }
        e.kCode = e.keyCode || e.which || e.charCode || e.button
        if (isIE) {
          e.target = e.srcElement
        }
        if (e.target.nodeType === 3) {
          e.target = e.target.parentNode
        }
        if (!e.relatedTarget && e.fromElement) {
          try {
            e.relatedTarget = e.fromElement === e.target ? e.toElement : e.fromElement
          } catch (ex) {}
        }
        if (!e.pageX && e.clientX) {
          var b = $DE
          e.pageX = e.clientX + (b && b.scrollLeft || $DB && $DB.scrollLeft || 0) - (b.clientLeft || 0)
          e.pageY = e.clientY + (b && b.scrollTop || ($DB && $DB.scrollTop) || 0) - (b.clientTop || 0)
        }
        if (isFF) {
          e.wheelDelta = -e.detail * 40
        }
        e.t = $(e.target)
        return e
      },
      setInterval: function (f, t) {
        var args = [].slice.call(arguments, 2),
          fn = f
        if (args.length > 0) {
          fn = function () {
            f.apply(this, args)
          }
        }
        return window.setInterval(fn, t)
      },
      setTimeout: function (f, t) {
        var args = [].slice.call(arguments, 2),
          fn = f
        if (args.length > 0) {
          fn = function () {
            f.apply(this, args)
          }
        }
        return window.setTimeout(fn, t)
      }
    }
  var WT = {
    'G': {},
    'UI': {},
    '$': $,
    'init': function () {
      WT.ext(Number.prototype, {
        round: function (p) {
          p = Math.pow(10, p || 0)
          return Math.round(this * p) / p
        }
      })
      WT.ext(String.prototype, _s)
      WT.ext(Array.prototype, _a)
      WT.ext(Date.prototype, _d)
      WT.ext(Function.prototype, _f)
      WT.ext($W, _w)
      WT.ext($D, _x)
      WT.ext($DB, _x)
      WT.e = {}
      WT.ext(WT.e, _e)
    },
    'ajax': function (u, p, f, m) {
      var me = this
      var st = setTimeout(function () {
        me.r.abort()
        clearInterval(st)
        me.onError('Timeout')
      }, 20000)
      f = f || {}
      f.onSuccess = f.onSuccess || function () {}
      f.onError = f.onError || function () {}
      me.onSuccess = function (s) {
        f.onSuccess(s)
        me.r = null
      }
      me.onError = function (d, s) {
        f.onError(d, s)
        me.r = null
      }
      me.bindFn = function (e, d) {
        return function () {
          return e.apply(d, [d])
        }
      }
      me.stateChange = function () {
        if (me.r.readyState === 4) {
          var s = me.r.status
          if (s === 0) {
            me.onError('Network Error')
            return
          }
          if (s >= 400 && s < 500) {
            me.onError(me.r.responseText, s)
            return
          }
          if (s >= 500) {
            me.onError('Server Error')
            return
          }
          if (s >= 200 && s < 300) {
            var _s = me.r.responseText
            clearInterval(st)
            me.onSuccess(_s)
            return _s
          }
          me.onError(s)
          return
        }
      }
      me.getR = function () {
        if (window.ActiveXObject) {
          var s = 'MSXML2.XMLHTTP'
          var a = ['Microsoft.XMLHTTP', s, s + '.3.0', s + '.4.0', s + '.5.0', s + '.6.0']
          for (var n = a.length - 1; n > -1; n--) {
            try {
              return new ActiveXObject(a[n])
            } catch (e) {
              return e
            }
          }
        } else {
          return new XMLHttpRequest()
        }
      }
      p = p || ''
      me.r = me.getR()
      var c = me.r
      if (m === 'POST') {
        c.open('POST', u, 1)
        c.setRequestHeader('Content-type', 'application/x-www-form-urlencoded')
      } else {
        if ((p + '').length > 0) {
          c.open('GET', u + '?' + p, 1)
        } else {
          c.open('GET', u + '?rnd=' + Math.random())
        }
      }
      c.setRequestHeader('token', (WT.ls.get('web_access_token_2015') || ''))
      c.onreadystatechange = me.bindFn(me.stateChange, me)
      c.send(m === 'POST' ? p : null)
      clearInterval(st)
    },
    'time': function () {
      return +new Date()
    },
    'trace': function (s) {
      console.info(s)
    },
    'nCount': function () {
      var me = this
      me.i = -1
      me.getN = function () {
        me.i++
        return me.i
      }
      me.setN = function (n) {
        me.i = n
      }
    },
    'class': function () {
      var f = function () {
        this.init.apply(this, arguments)
      }
      for (var i = 0, l = arguments.length, it; i < l; i++) {
        it = arguments[i]
        if (it === null) {
          continue
        }
        $.ext(f.prototype, it)
      }
      return f
    },
    'ext': function (target, src) {
      if (!src || !target) {
        return null
      }
      for (var i in src) {
        if (src.hasOwnProperty(i)) {
          target[i] = src[i]
        }
      }
      return target
    },
    'rnd': function (a, b) {
      return Math.round(Math.random() * (b - a)) + a
    },
    'box': function (a) {
      a = a.split(',')
      return (a[0].length ? 'left:' + a[0] + 'px;' : '') + (a[1].length ? 'top:' + a[1] + 'px;' : '') + (a[2].length ? 'width:' + a[2] + 'px;' : '') + (a[3].length ? 'height:' + a[3] + 'px;' : '')
    },
    'getType': function () {
      if (arguments.length > 0) {
        var t, o = arguments[0]
        return ((t = typeof (o)) === 'object' ? o === null && 'null' || Object.prototype.toString.call(o).slice(8, -1) : t).toLow()
      } else {
        var u = navigator.userAgent.toLow(),
          v = (u.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1]
        if (u.indexOf('applewebkit/') > -1) {
          return 'safari,' + v
        } else if (window.opera) {
          return 'opera,' + v
        } else if (u.indexOf('msie') > -1) {
          return 'msie,' + v
        } else if (u.indexOf('firefox') !== -1) {
          return 'mozilla,' + v
        } else if (u.indexOf('chrome') !== -1) {
          return 'chrome,' + v
        }
      }
    },
    'onReady': function (f) {
      if (!isIE) {
        _x.evt.call($D, 'DOMContentLoaded', f, false)
      } else {
        var t = setInterval(function () {
          try {
            $DB.doScroll('left')
            clearInterval(t)
            setTimeout(f, 48)
          } catch (e) {
            return e
          }
        }, 48)
      }
    },
    'wh': function () {
      var _w, _h = 0
      if (typeof (window.innerWidth) === 'number') {
        _w = window.innerWidth
        _h = window.innerHeight
      } else if ($DE && ($DE.clientWidth || $DE.clientHeight)) {
        _w = $DE.clientWidth
        _h = $DE.clientHeight
      } else if ($DB && ($DB.clientWidth || $DB.clientHeight)) {
        _w = $DB.clientWidth
        _h = $DB.clientHeight
      }
      return [_w / 2 + ($DE.scrollLeft || $DB.scrollLeft), _h / 2 + ($DE.scrollTop || $DB.scrollTop)]
    },
    'toUrl': function (o) {
      if (typeof o !== 'object') {
        return
      }
      var r = []
      var item = ''
      for (var i in o) {
        if (o.hasOwnProperty(i)) {
          if (typeof o[i] === 'object') {
            item = JSON.stringify(o[i])
          } else {
            item = o[i]
          }
          r.push(i + '=' + item)
        }
      }
      return r.join('&')
    },
    'url2Obj': function (s) {
      var link, p, pAry
      if (s.indexOf('.html#') > 0) {
        link = s.split('#')[1].split('?')[0]
        p = s.split('?')[1]
      }
      if (s.indexOf('.html?') > 0) {
        link = s.split('#')[1]
        p = s.split('?')[1].split('#')[0]
      }
      pAry = p ? p.split('&') : []
      var o = {}
      for (var i = 0; i < pAry.length; i++) {
        var item = pAry[i].split('=')
        o[item[0]] = item[1]
      }
      o.wtLink = link
      return o
    },
    'drag': {
      init: function (o, or, minX, maxX, minY, maxY, h, v, xFn, yFn) {
        o.onmousedown = WT.drag.start
        o.ih = h ? false : true
        o.v = v ? false : true
        o.rt = or && or !== null ? or : o
        o.s = o.rt.style
        o.minX = minX || 0
        o.minY = minY || 0
        o.maxX = maxX || null
        o.maxY = maxY || null
        o.xFn = xFn ? xFn : null
        o.yFn = yFn ? yFn : null
        o.p = parseInt
        o.rt.onDragStart = o.rt.onDragEnd = o.rt.onDrag = function () {}
        return o
      },
      start: function (e, o) {
        o = WT.drag.obj = o || this
        var y = o.p(o.v ? o.s.top : o.s.bottom),
          x = o.p(o.ih ? o.s.left : o.s.right)
        o.s.display = 'block'
        e = e || $W.event
        o.rt.onDragStart(x, y, e)
        o.lx = e.clientX
        o.ly = e.clientY
        if (o.ih) {
          o.iMX = o.lx - x + o.minX
          if (o.maxX) {
            o.xMX = o.iMX + o.maxX - o.minX
          }
        } else {
          o.xMX = -o.minX + o.lx + x
          if (o.maxX) {
            o.iMX = -o.maxX + o.lx + x
          }
        }
        if (o.v) {
          o.iMY = o.ly - y + o.minY
          if (o.maxY) {
            o.xMY = o.iMY + o.maxY - o.minY
          }
        } else {
          o.xMY = -o.minY + o.ly + y
          if (o.maxY) {
            o.iMY = -o.maxY + o.ly + y
          }
        }
        $D.onmousemove = WT.drag.drag
        $D.onmouseup = WT.drag.end
        return false
      },
      drag: function (e) {
        e = WT.e.fix(e)
        e.stop()
        var o = WT.drag.obj,
          ey = e.clientY,
          ex = e.clientX,
          mi = Math.min,
          mx = Math.max,
          y = o.p(o.v ? o.s.top : o.s.bottom),
          x = o.p(o.ih ? o.s.left : o.s.right)
        if (o.dragable === false) {
          return
        }
        ex = o.ih ? mx(ex, o.iMX) : mi(ex, o.xMX)
        if (o.maxX) {
          ex = o.ih ? mi(ex, o.xMX) : mx(ex, o.iMX)
        }
        ey = o.v ? mx(ey, o.iMY) : mi(ey, o.xMY)
        if (o.maxY) {
          ey = o.v ? mi(ey, o.xMY) : mx(ey, o.iMY)
        }
        var nx = x + ((ex - o.lx) * (o.ih ? 1 : -1)),
          ny = y + ((ey - o.ly) * (o.v ? 1 : -1))
        if (o.xFn) {
          nx = o.xFn(y)
        } else if (o.yFn) {
          ny = o.yFn(x)
        }
        o.s['left'] = (nx || 0) + 'px'
        o.s[o.v ? 'top' : 'bottom'] = (ny || 0) + 'px'
        o.lx = ex
        o.ly = ey
        o.rt.onDrag(nx, ny, e)
        return false
      },
      end: function () {
        var o = WT.drag.obj
        $D.onmousemove = $D.onmouseup = null
        o.rt.onDragEnd(o.p(o.s[o.ih ? 'left' : 'right']), o.p(o.s[o.v ? 'top' : 'bottom']))
        o = null
      }
    },
    'getJsonp': function (url, onError) {
      var JSONP = $D.createElement('script')
      JSONP.onload = JSONP.onreadystatechange = function () {
        if (!this.readyState || this.readyState === 'loaded' || this.readyState === 'complete') {
          JSONP.onload = JSONP.onreadystatechange = null
          WT.$(JSONP).r()
          JSONP = null
        }
      }
      JSONP.onerror = function (ex) {
        onError({
          errMsg: ex,
          side: 'back'
        })
      }
      JSONP.type = 'text/javascript'
      JSONP.src = url
      $D.getElementsByTagName('head')[0].appendChild(JSONP)
    },
    'ck': {
      set: function (n, v, h) {
        var sc = n + '=' + encodeURIComponent(v)
        if (h) {
          var exp = new Date(WT.time() + (h || 99999) * 36E5)
          sc += '; expires=' + exp.toGMTString()
        }
        document.cookie = sc
      },
      get: function (n) {
        var oRE = new RegExp('(?:; )?' + n + '=([^;]*);?')
        if (oRE.test($D.cookie)) {
          return decodeURIComponent(RegExp['$1'])
        } else {
          return null
        }
      },
      remove: function (n) {
        this.set(n, null, -9999)
      },
      clear: function () {
        $D.cookie = null
      }
    },
    'checkParam': function (data, parmOption) {
      if (!data || !parmOption) {
        return '参数定义为空'
      }
      var typeCheck = function (type, val) {
        var t = (type || 'string').toLow()
        switch (t) {
          case 'string':
            return false
          case 'number':
            if (!isNaN(+val)) {
              return false
            }
            break
          case 'date':
            if (val) {
              if (!val.isDate()) {
                return false
              }
            }
            break
          case 'datetime':
            if (val) {
              if (!val.isTime()) {
                return false
              }
            }
            break
          default:
            break
        }
        return true
      }
      var err = {}
      for (var i in parmOption) {
        if (parmOption[i].req && (data[i] === undefined || data[i] === '') && !parmOption[i].def) {
          err.name = i
          err.err = (parmOption[i].desc || '') + ' ' + '不能为空'
          return err
        }
        if ((data[i] === '' || data[i] === undefined || data[i] === null) && (parmOption[i].def || parmOption[i].def === '')) {
          data[i] = parmOption[i].def || ''
        }
        if (typeCheck(parmOption[i].t, data[i]) && parmOption[i].req === 1) {
          err.name = i
          err.err = i + ' ' + '类型不对或有非法字符'
          return err
        }
        if (parmOption[i].t.toLow() === 'string') {
          data[i] = encodeURIComponent(data[i])
        }
      }
      return {
        err: 0,
        data: data
      }
    }
  }
  WT.init()
  window.WT = WT
})()
WT.ls = {}
if (!$LS) {
  var UserData = function (fsName) {
    if (!fsName) {
      fsName = 'user_data_default'
    }
    var dom = $D.createElement('input')
    dom.type = 'hidden'
    dom.addBehavior('#default#userData');
    ($DB || $D.getElementsByTagName('head')[0] || $DE).appendChild(dom)
    dom.save(fsName)
    this.fsName = fsName
    this.dom = dom
    return this
  }
  UserData.prototype = {
    set: function (k, v) {
      this.dom.setAttribute(k, v)
      this.dom.save(this.fsName)
    },
    get: function (k) {
      this.dom.load(this.fsName)
      return this.dom.getAttribute(k)
    },
    remove: function (k) {
      this.dom.removeAttribute(k)
      this.dom.save(this.fsName)
    },
    clear: function () {
      this.dom.load(this.fsName)
      var now = new Date()
      now = new Date(now.getTime() - 1)
      this.dom.expires = now.toUTCString()
      this.dom.save(this.fsName)
    }
  }
  WT.ls = WT.ck
} else {
  WT.ls = {
    set: function (k, v) {
      if (this.get(k) !== null) {
        this.remove(k)
      }
      $LS.setItem(k, v)
    },
    get: function (k) {
      var v = $LS.getItem(k)
      return v === undefined ? null : v
    },
    remove: function (k) {
      $LS.removeItem(k)
    },
    clear: function () {
      $LS.clear()
    },
    each: function (fn) {
      var n = $LS.length,
        i = 0,
        k
      fn = fn || function () {}
      for (; i < n; i++) {
        k = $LS.key(i)
        if (fn.call(this, k, this.get(k)) === false) {
          break
        }
        if ($LS.length < n) {
          n--
          i--
        }
      }
    }
  }
};
(function (obj) {
  var utf8 = {
    'encode': function (s) {
      var r = ''
      var len = s.length
      var fromCode = String.fromCharCode
      for (var n = 0; n < len; n++) {
        var c = s.charCodeAt(n)
        if (c < 128) {
          r += fromCode(c)
        } else if (c > 127 && c < 2048) {
          r += fromCode((c >> 6) | 192)
          r += fromCode((c & 63) | 128)
        } else {
          r += fromCode((c >> 12) | 224)
          r += fromCode(((c >> 6) & 63) | 128)
          r += fromCode((c & 63) | 128)
        }
      }
      return r
    },
    'decode': function (s) {
      var r = ''
      var i = 0
      var c1 = 0
      var c2 = 0
      var c3 = 0
      var fromCode = String.fromCharCode
      while (i < s.length) {
        c1 = s.charCodeAt(i)
        if (c1 < 128) {
          r += fromCode(c1)
          i++
        } else if (c1 > 191 && c1 < 224) {
          c2 = s.charCodeAt(i + 1)
          r += fromCode(((c1 & 31) << 6) | (c2 & 63))
          i += 2
        } else {
          c2 = s.charCodeAt(i + 1)
          c3 = s.charCodeAt(i + 2)
          r += fromCode(((c1 & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63))
          i += 3
        }
      }
      return r
    }
  }
  var lzw = {
    'compress': function (str) {
      var fromCode = String.fromCharCode
      var rStr = ''
      rStr = utf8.encode(str)
      var i = 0
      var size = 0
      var xstr = ''
      var chars = 256
      var dict = []
      for (i = 0; i < chars; i++) {
        dict[i + ''] = i
      }
      var splitted = []
      splitted = rStr.split('')
      var buffer = []
      size = splitted.length
      var current = ''
      var r = ''
      for (i = 0; i <= size; i++) {
        current = splitted[i] + ''
        xstr = (buffer.length === 0) ? String(current.charCodeAt(0)) : (buffer.join('-') + '-' + String(current.charCodeAt(0)))
        if (dict[xstr] !== undefined) {
          buffer.push(current.charCodeAt(0))
        } else {
          r += fromCode(dict[buffer.join('-')])
          dict[xstr] = chars
          chars++
          buffer = []
          buffer.push(current.charCodeAt(0))
        }
      }
      return r
    },
    'uncompress': function (str) {
      var i
      var chars = 256
      var dict = []
      var fromCode = String.fromCharCode
      for (i = 0; i < chars; i++) {
        dict[i] = fromCode(i)
      }
      var original = str + ''
      var splitted = original.split('')
      var size = splitted.length
      var buffer = ''
      var chain = ''
      var r = ''
      for (i = 0; i < size; i++) {
        var code = original.charCodeAt(i)
        var current = dict[code]
        if (buffer === '') {
          buffer = current
          r += current
        } else {
          if (code <= 255) {
            r += current
            chain = buffer + current
            dict[chars] = chain
            chars++
            buffer = current
          } else {
            chain = dict[code]
            if (chain === null) {
              chain = buffer + buffer.slice(0, 1)
            }
            r += chain
            dict[chars] = buffer + chain.slice(0, 1)
            chars++
            buffer = chain
          }
        }
      }
      r = utf8.decode(r)
      return r
    }
  }
  obj.utf8 = utf8
  obj.lzw = lzw
})(WT);
(function (window) {
  'use strict'
  var f, b = {
      open: '{{',
      close: '}}'
    },
    c = {
      exp: function (a) {
        return new RegExp(a, 'g')
      },
      query: function (a, c, e) {
        var f = ['#([\\s\\S])+?', '([^{#}])*?'][a || 0]
        return d((c || '') + b.open + f + b.close + (e || ''))
      },
      escape: function (a) {
        return String(a || '').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/"/g, '&quot;')
      },
      error: function (a, b) {
        var c = 'Laytpl Error：'
        return typeof console === 'object' && console.error(c + a + '\n' + (b || '')), c + a
      }
    },
    d = c.exp,
    e = function (a) {
      this.tpl = a
    }
  e.pt = e.prototype, e.pt.parse = function (a, e) {
    var f = this,
      g = a,
      h = d('^' + b.open + '#', ''),
      i = d(b.close + '$', '')
    a = a.replace(d(b.open + '#'), b.open + '# ').replace(/[\n\r]/g, '￥￥').replace(/[\t]/g, ' ').replace(d(b.close + '}'), '} ' + b.close).replace(/\\/g, '\\\\').replace(/(?="|')/g, '\\').replace(c.query(), function (a) {
      return a = a.replace(h, '').replace(i, ''), '";' + a.replace(/\\/g, '') + '; view+="'
    }).replace(c.query(1), function (a) {
      var c = '"+('
      return a.replace(/\s/g, '') === b.open + b.close ? '' : (a = a.replace(d(b.open + '|' + b.close), ''), /^=/.test(a) && (a = a.replace(/^=/, ''), c = '"+_escape_('), c + a.replace(/\\/g, '') + ')+"')
    }), a = '"use strict";var view = "' + a + '";return view;'
    try {
      return f.cache = a = new Function('d, _escape_', a), a(e, c.escape)
    } catch (j) {
      return delete f.cache, c.error(j, g)
    }
  }, e.pt.render = function (a, b) {
    var e, d = this
    return a ? (e = d.cache ? d.cache(a, c.escape) : d.parse(d.tpl, a).replace(/￥￥/g, '\n'), b ? (b(e), void 0) : e) : c.error('no data')
  }, f = function (a) {
    return typeof a !== 'string' ? c.error('Template not found') : new e(a)
  }, f.config = function (a) {
    a = a || {}
    for (var c in a) {
      b[c] = a[c]
    }
  }, f.v = '1.1', typeof define === 'function' ? define(function () {
    return f
  }) : typeof exports !== 'undefined' ? module.exports = f : window.laytpl = f
})(window);
(function (window) {
  var base64 = {}
  base64.map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='
  base64.decode = function (s) {
    s += ''
    var len = s.length
    if ((len === 0) || (len % 4 !== 0)) {
      return s
    }
    var pads = 0
    if (s.charAt(len - 1) === base64.map[64]) {
      pads++
      if (s.charAt(len - 2) === base64.map[64]) {
        pads++
      }
      len -= 4
    }
    var i, b, map = base64.map,
      x = []
    for (i = 0; i < len; i += 4) {
      b = (map.indexOf(s.charAt(i)) << 18) | (map.indexOf(s.charAt(i + 1)) << 12) | (map.indexOf(s.charAt(i + 2)) << 6) | map.indexOf(s.charAt(i + 3))
      x.push(String.fromCharCode(b >> 16, (b >> 8) & 0xff, b & 0xff))
    }
    switch (pads) {
      case 1:
        b = (map.indexOf(s.charAt(i)) << 18) | (map.indexOf(s.charAt(i)) << 12) | (map.indexOf(s.charAt(i)) << 6)
        x.push(String.fromCharCode(b >> 16, (b >> 8) & 0xff))
        break
      case 2:
        b = (map.indexOf(s.charAt(i)) << 18) | (map.indexOf(s.charAt(i)) << 12)
        x.push(String.fromCharCode(b >> 16))
        break
    }
    return unescape(x.join(''))
  }
  base64.encode = function (s) {
    if (!s) {
      return
    }
    s += ''
    if (s.length === 0) {
      return s
    }
    s = escape(s)
    var i, b, x = [],
      map = base64.map,
      padchar = map[64]
    var len = s.length - s.length % 3
    for (i = 0; i < len; i += 3) {
      b = (s.charCodeAt(i) << 16) | (s.charCodeAt(i + 1) << 8) | s.charCodeAt(i + 2)
      x.push(map.charAt(b >> 18))
      x.push(map.charAt((b >> 12) & 0x3f))
      x.push(map.charAt((b >> 6) & 0x3f))
      x.push(map.charAt(b & 0x3f))
    }
    switch (s.length - len) {
      case 1:
        b = s.charCodeAt(i) << 16
        x.push(map.charAt(b >> 18) + map.charAt((b >> 12) & 0x3f) + padchar + padchar)
        break
      case 2:
        b = (s.charCodeAt(i) << 16) | (s.charCodeAt(i + 1) << 8)
        x.push(map.charAt(b >> 18) + map.charAt((b >> 12) & 0x3f) + map.charAt((b >> 6) & 0x3f) + padchar)
        break
    }
    return x.join('')
  }
  window.base64 = base64
})(window);
(function (global) {
  var k, _handlers = {},
    _mods = {
      16: false,
      18: false,
      17: false,
      91: false
    },
    _scope = 'all',
    _MODIFIERS = {
      '⇧': 16,
      shift: 16,
      '⌥': 18,
      alt: 18,
      option: 18,
      '⌃': 17,
      ctrl: 17,
      control: 17,
      '⌘': 91,
      command: 91
    },
    _MAP = {
      backspace: 8,
      tab: 9,
      clear: 12,
      enter: 13,
      'return': 13,
      esc: 27,
      escape: 27,
      space: 32,
      left: 37,
      up: 38,
      right: 39,
      down: 40,
      del: 46,
      'delete': 46,
      home: 36,
      end: 35,
      pageup: 33,
      pagedown: 34,
      ',': 188,
      '.': 190,
      '/': 191,
      '`': 192,
      '-': 189,
      '=': 187,
      ';': 186,
      '\'': 222,
      '[': 219,
      ']': 221,
      '\\': 220
    },
    code = function (x) {
      return _MAP[x] || x.toUpperCase().charCodeAt(0)
    },
    _downKeys = []
  for (k = 1; k < 20; k++) _MAP['f' + k] = 111 + k

  function index (array, item) {
    var i = array.length
    while (i--) { if (array[i] === item) return i }
    return -1
  }

  function compareArray (a1, a2) {
    if (a1.length !== a2.length) return false
    for (var i = 0; i < a1.length; i++) {
      if (a1[i] !== a2[i]) return false
    }
    return true
  }
  var modifierMap = {
    16: 'shiftKey',
    18: 'altKey',
    17: 'ctrlKey',
    91: 'metaKey'
  }

  function updateModifierKey (event) {
    for (k in _mods) _mods[k] = event[modifierMap[k]]
  };

  function dispatch (event) {
    var key, handler, k, i, modifiersMatch, scope
    key = event.keyCode
    if (index(_downKeys, key) === -1) {
      _downKeys.push(key)
    }
    if (key === 93 || key === 224) key = 91
    if (key in _mods) {
      _mods[key] = true
      for (k in _MODIFIERS) {
        if (_MODIFIERS[k] === key) assignKey[k] = true
      }
      return
    }
    updateModifierKey(event)
    if (!assignKey.filter.call(this, event)) return
    if (!(key in _handlers)) return
    scope = getScope()
    for (i = 0; i < _handlers[key].length; i++) {
      handler = _handlers[key][i]
      if (handler.scope === scope || handler.scope === 'all') {
        modifiersMatch = handler.mods.length > 0
        for (k in _mods) {
          if ((!_mods[k] && index(handler.mods, +k) > -1) || (_mods[k] && index(handler.mods, +k) === -1)) modifiersMatch = false
        }
        if ((handler.mods.length === 0 && !_mods[16] && !_mods[18] && !_mods[17] && !_mods[91]) || modifiersMatch) {
          if (handler.method(event, handler) === false) {
            if (event.preventDefault) event.preventDefault()
            else event.returnValue = false
            if (event.stopPropagation) event.stopPropagation()
            if (event.cancelBubble) event.cancelBubble = true
          }
        }
      }
    }
  };

  function clearModifier (event) {
    var key = event.keyCode,
      k, i = index(_downKeys, key)
    if (i >= 0) {
      _downKeys.splice(i, 1)
    }
    if (key === 93 || key === 224) key = 91
    if (key in _mods) {
      _mods[key] = false
      for (k in _MODIFIERS) {
        if (_MODIFIERS[k] === key) assignKey[k] = false
      }
    }
  };

  function resetModifiers () {
    for (k in _mods) _mods[k] = false
    for (k in _MODIFIERS) assignKey[k] = false
  };

  function assignKey (key, scope, method) {
    var keys, mods
    keys = getKeys(key)
    if (method === undefined) {
      method = scope
      scope = 'all'
    }
    for (var i = 0; i < keys.length; i++) {
      mods = []
      key = keys[i].split('+')
      if (key.length > 1) {
        mods = getMods(key)
        key = [key[key.length - 1]]
      }
      key = key[0]
      key = code(key)
      if (!(key in _handlers)) _handlers[key] = []
      _handlers[key].push({
        shortcut: keys[i],
        scope: scope,
        method: method,
        key: keys[i],
        mods: mods
      })
    }
  };

  function unbindKey (key, scope) {
    var multipleKeys, keys, mods = [],
      i, j, obj
    multipleKeys = getKeys(key)
    for (j = 0; j < multipleKeys.length; j++) {
      keys = multipleKeys[j].split('+')
      if (keys.length > 1) {
        mods = getMods(keys)
      }
      key = keys[keys.length - 1]
      key = code(key)
      if (scope === undefined) {
        scope = getScope()
      }
      if (!_handlers[key]) {
        return
      }
      for (i = 0; i < _handlers[key].length; i++) {
        obj = _handlers[key][i]
        if (obj.scope === scope && compareArray(obj.mods, mods)) {
          _handlers[key][i] = {}
        }
      }
    }
  };

  function isPressed (keyCode) {
    if (typeof (keyCode) === 'string') {
      keyCode = code(keyCode)
    }
    return index(_downKeys, keyCode) !== -1
  }

  function getPressedKeyCodes () {
    return _downKeys.slice(0)
  }

  function filter (event) {
    var tagName = (event.target || event.srcElement).tagName
    return !(tagName === 'INPUT' || tagName === 'SELECT' || tagName === 'TEXTAREA')
  }
  for (k in _MODIFIERS) assignKey[k] = false

  function setScope (scope) {
    _scope = scope || 'all'
  };

  function getScope () {
    return _scope || 'all'
  };

  function deleteScope (scope) {
    var key, handlers, i
    for (key in _handlers) {
      handlers = _handlers[key]
      for (i = 0; i < handlers.length;) {
        if (handlers[i].scope === scope) handlers.splice(i, 1)
        else i++
      }
    }
  };

  function getKeys (key) {
    var keys
    key = key.replace(/\s/g, '')
    keys = key.split(',')
    if ((keys[keys.length - 1]) === '') {
      keys[keys.length - 2] += ','
    }
    return keys
  }

  function getMods (key) {
    var mods = key.slice(0, key.length - 1)
    for (var mi = 0; mi < mods.length; mi++) {
      mods[mi] = _MODIFIERS[mods[mi]]
    }
    return mods
  }

  function addEvent (object, event, method) {
    if (object.addEventListener) {
      object.addEventListener(event, method, false)
    } else if (object.attachEvent) {
      object.attachEvent('on' + event, function () {
        method(window.event)
      })
    }
  };
  addEvent(document, 'keydown', function (event) {
    dispatch(event)
  })
  addEvent(document, 'keyup', clearModifier)
  addEvent(window, 'focus', resetModifiers)
  var previousKey = global.key

  function noConflict () {
    var k = global.key
    global.key = previousKey
    return k
  }
  global.key = assignKey
  global.key.setScope = setScope
  global.key.getScope = getScope
  global.key.deleteScope = deleteScope
  global.key.filter = filter
  global.key.isPressed = isPressed
  global.key.getPressedKeyCodes = getPressedKeyCodes
  global.key.noConflict = noConflict
  global.key.unbind = unbindKey
})(WT)
