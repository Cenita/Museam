// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import axios from 'axios';
import App from './App'
import router from './router'
import store from './store'
import iView from 'iview'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css'; // 默认主题
import VueLazyLoad from '../static/js/vue-lazyload'
import VueCookie from 'vue-cookie'
import promise from 'es6-promise'
import 'babel-polyfill'


import 'iview/dist/styles/iview.css';

Vue.config.productionTip = false
//屏蔽所有控制台错误
Vue.config.errorHandler = (err, vm, info) => {
}

Vue.prototype.$http = axios;
Vue.prototype.$url = "http://127.0.0.1:5001";

Vue.use(iView);
Vue.use(ElementUI, {
  size: 'small'
});
promise.polyfill()


Vue.use(VueLazyLoad, {
  loading: require('../static/images/loading.png'),
  throttleWait: 200
})

Vue.use(VueCookie)

//loading进度条加载
router.beforeEach((to, from, next) => {
  store.dispatch('set_loading_state', true)
  iView.LoadingBar.start();
  next();
});

router.afterEach(route => {
  window.scrollTo(0, 0);
  store.dispatch('set_loading_state', false)
  iView.LoadingBar.finish();
});

/* eslint-disable no-new */
export const main = new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: {App}
})

