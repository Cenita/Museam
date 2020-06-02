<template>
  <div id="app" v-cloak>
    <transition name="slide-fade">
      <router-view name="sign"></router-view>
    </transition>
    <div class="containers" v-if="pathname!=='登录' && pathname!=='注册' && pathname!=='忘记密码'">
      <div class="head">
        <Header @layout="handleLayout" :topList="topList ? topList : []"/>
        <ind-nav :logo="logo" :pathname="pathname"/>
      </div>
      <router-view/>
      <guide/>
      <Footer :number="number"/>
    </div>

    <loading :isloading="loading"></loading>
    <BackTop></BackTop>
  </div>
</template>

<script>
  import {getAjax} from '@/public/js/config'
  import Header from '@/base/Head/header'
  import IndNav from '@/base/Head/ind_nav'
  import Guide from '@/base/Foot/guide'
  import Footer from '@/base/Foot/footer'
  import Loading from '@/base/loading'
  import {mapGetters} from 'vuex'
  import {getStatus,loginOut,getViewNumber} from "./public/js/api";
  import {mapMutations} from 'vuex'

  export default {
    name: 'app',
    components: {
      Header,
      IndNav,
      Guide,
      Footer,
      Loading
    },
    data() {
      return {
        logo: '',
        foot: '',
        pathname: '',
        number:"",
        topList:[]
      }
    },
    created() {
      this.getStatus();
      this.setView();
    },
    computed: {
      ...mapGetters([
        'loading'
      ])
    },
    methods: {
      ...mapMutations(['SET_LOGIN_STATE']),
        getStatus(){
          var _this = this;
          getStatus().then(res=>{
            if(res.status==='200'){
              _this.SET_LOGIN_STATE({flag:true,name:res.data});
            }
          })
        },
      setView(){
        getViewNumber().then(res=>{
          if(res.status==='200'){
            this.number = res.data;
          }
        })
      },
      handleLayout(){
        this.SET_LOGIN_STATE({flag:false,name:""});
        loginOut();
        this.$router.push('/');
      }
    },
    watch: {
      "$route"(to, from) {
        this.pathname = to.meta[0]
        document.title = to.name + ' - 故宫博物院课程设计'
      }
    }
  }
</script>

<style lang="less">
  @import "./public/css/base.css";

  img[lazy=loading] {
    width: 202px !important;
    height: 144px !important;
  }
  .slide-fade{
    position: absolute;left:0;right: 0;
  }
  .slide-fade-enter-active {
    transition: all 0.5s ease;
  }
  .slide-fade-leave-active {

    transition: all .1s cubic-bezier(2.0, 0.5, 0.8, 1.0);
  }
  .slide-fade-enter, .slide-fade-leave-to
  {
    left:0;right: 0;
    opacity: 0;
  }

  .layout {
    width: 1200px;
    margin: 0 auto;
  }

  .item {
    .ivu-select-selection {
      background-color: #5e7482 !important;
      border: none;
      border-radius: 4px;
      height: 32px;
    }
    .ivu-select-input {
      font-size: 14px;
      height: 32px;
      text-align: center;
      color: #bbbec4;
    }
    .ivu-select-arrow {
      color: rgba(255, 255, 255, .9);
    }
  }
</style>
