/*
dev or undefined 本地调试环境
test 测试环境
TODO:
production 生产环境
*/
var configObj = {
  dev: {
  },
  test: {
  }
}
configObj[undefined] = configObj['dev']

module.exports = configObj[process.env.NODE_ENV]
