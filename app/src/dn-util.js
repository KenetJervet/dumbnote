export const VueExt = {
  install: function (Vue, options) {
    Vue.prototype.http_get = function (res) {
      return this.$http.get(process.env.API_ROOT + '/' + res)
    }

    Vue.prototype.http_post = function (res, data) {
      return this.$http.post(process.env.API_ROOT + '/' + res, data)
    }
  }
}
