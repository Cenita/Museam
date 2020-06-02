<template>
  <!--最顶部登录注册栏-->
  <div class="header">
    <div class="layout header-con clearfix">
      <vue-seam-less :data="topList" :class-option="optionLeft" class="notice">
        <ul class="item clearfix">
          故宫博物馆WEB课程设计 - 陈慧涛 陈林
        </ul>
      </vue-seam-less>
      <ul class="sign" v-if="!isLogin">
        <li>
          <router-link to="/signIn">登录</router-link>
        </li>
        <li>|</li>
        <li>
          <router-link to="/signUp">注册</router-link>
        </li>
        <li>|</li>
      </ul>
      <ul class="sign" v-else>
        <li>
          欢迎：
          {{user_name}}
        </li>
        <li>
          <span class="layout" @click="layout">退出</span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script type="text/ecmascript-6">
  import vueSeamLess from 'vue-seamless-scroll'
  import {mapGetters } from 'vuex';
  export default {
    props:{
      topList:{
        type:Array,
        default:[]
      }
    },
    components:{
      vueSeamLess
    },
    data() {
      return {
      }
    },
    computed: {
      user_name() {
        return this.$store.state.name;
      },
      isLogin(){
        return this.$store.state.islogin;
      },
      optionLeft() {
        return {
          direction: 2,
          limitMoveNum: 2
        }
      }
    },
    watch:{

    }
    ,
    methods: {
      layout() {
        this.$message.success("退出成功");
        this.$emit('layout')
      }
    }
  }
</script>
<style scoped lang="less">
  .header {
    width: 100%;
    background: #fff;
    border-bottom: 1px solid #e7e7e7;
    .header-con {
      padding: 0 10px;
      .notice {
        float: left;
        font-size: 12px;
        height: 40px;
        line-height: 40px;
        color: #666;
        width: 800px;
        overflow: hidden;
        .item{
          width: 2000px;
          list-style: none;
          padding: 0;
          margin: 0 auto;
          li{
            display: inline-block;
            vertical-align: middle;
            margin-right: 30px;
            color: #666;
            font-size: 12px;
            a{
              color: #666;
              &:hover{
                color: #2d8cf0;
              }
            }
          }
        }
      }
      .sign {
        float: right;
        li {
          display: inline-block;
          line-height: 40px;
          margin-left: 10px;
          vertical-align: middle;
          .layout {
            cursor: pointer;
            &:hover {
              color: #279ee4;
            }
          }
          a {
            color: #666;
            &:hover {
              color: #279ee4;
            }
          }
        }
      }
    }
  }
</style>
