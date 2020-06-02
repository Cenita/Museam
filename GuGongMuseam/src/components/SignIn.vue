<template>
  <sign-bg>
    <div class="sign-box">
      <p class="sign-title">登录</p>
      <div class="form-group clearfix">
        <input type="text"
               v-model="phone.value"
               name="phone"
               @input="verifyPhone()"
               placeholder="请输入手机号"
               class="phone"/>
        <img src="../assets/mobile.png" style="width: 35px;"/>
        <label class="error"
               :class="phone.error ? 'is-visible' : ''">
          {{phone.error}}
        </label>
      </div>
      <div class="form-group clearfix">
        <input type="password"
               v-model="password.value"
               placeholder="请输入密码"
               class="passwd"
               @input="verifyPasswd()"
               name="passwd"
               autocomplete="new-password"/>
        <img src="../assets/pass2.png" style="width: 30px;margin-top: 2px;margin-left: 2px;"/>
        <label class="error"
               :class="password.error ? 'is-visible' : ''">
          {{password.error}}
        </label>
      </div>

      <div class="checkbox-wr clearfix">
        <label class="remember">
          <input type="checkbox" ref="checkbox" checked class="checkbox"/>
          <span>记住密码</span>
        </label>
        <p class="tologin" style="float: right">
          <span>没有账号</span>
          <router-link to="/signUp">立即注册</router-link>
        </p>
      </div>

      <div class="form-group clearfix" style="margin-top: 25px">
        <button type="button" class="input-btn" @click="handleSubmit()">登录</button>
      </div>

    </div>
  </sign-bg>
</template>
<script type="text/ecmascript-6">
  import SignBg from '@/base/signBg'
  import {getAjax} from '@/public/js/config'
  import {login,getSuccinct,getSuccincts} from "../public/js/api";
  import {mapMutations} from 'vuex'
  export default {
    components: {
      SignBg
    },
    data() {
      return {
        phone: {
          value: '',
          error: '',
          isVerify: false
        },
        password: {
          value: '',
          error: '',
          isVerify: false
        },
      }
    },
    mounted() {
      this.phone.value = this.$cookie.get('phone')
      this.password.value = this.$cookie.get('password')
    },
    methods: {
      ...mapMutations(['SET_LOGIN_STATE']),
      /**
       * 手机号验证
       */
      verifyPhone() {
        if (this.phone.value === null || this.phone.value === '' || this.phone.value === undefined) {
          this.phone.error = '请输入手机号'
          this.phone.isVerify = false
        } else if (!/^1[0-9]{10}$/.test(this.phone.value)) {
          this.phone.error = '请输入正确手机号'
          this.phone.isVerify = false
        } else {
          this.phone.error = ''
          this.phone.isVerify = true
        }
      },
      /**
       * 密码验证
       */
      verifyPasswd() {
        if (this.password.value === null || this.password.value === '' || this.password.value === undefined) {
          this.password.error = '请输入密码'
          this.password.isVerify = false
        } else if (this.password.value.length < 6) {
          this.password.error = '至少6位密码'
          this.password.isVerify = false
        } else {
          this.password.error = ''
          this.password.isVerify = true
        }
      },

      /**
       * 触发验证
       */
      handleForm() {
        this.verifyPhone()
        this.verifyPasswd()
      },
      /**
       * 提交表单数据
       */
      handleSubmit() {
        this.handleForm()
        if (
          this.phone.isVerify && this.password.isVerify
        ) {
          this.handleFormAjax()
        }
      },
      /**
       * 提交数据
       */
      handleFormAjax() {
        var data = {
          "phone":this.phone.value,
          "password":this.password.value
        };
        var _this = this;
        login(data).then(res=>{
          if(res.status==="200"){
            this.$message.success("登录成功");
            _this.SET_LOGIN_STATE({flag:true,name:res.data.name});
            this.$router.push('/');
          }else{
            this.$message.error("登陆失败")
          }
        })
      },
    },
  }
</script>
<style scoped lang="less">

  .sign-box {
    width: 420px;
    height: 390px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-left: -150px;
    margin-top: -195px;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 20px;
    background: rgba(0, 0, 0, 0.4);
    padding: 20px 30px 28px;
    .sign-title {
      font-size: 30px;
      text-align: center;
      margin-bottom: 20px;
      color: #fff;
      margin-top: 25px;
    }
  }

  .form-group {
    width: 100%;
    position: relative;
    margin-bottom: 15px;
    input {
      width: 100%;
      border: 2px solid rgba(0, 0, 0, 0.2);
      padding: 12px 20px 12px 60px;
      -webkit-transition: all .3s ease-in-out;
      transition: all .3s ease-in-out;
      background: rgba(0, 0, 0, 0.6);
      box-shadow: none;
      color: white;
      font-size: 14px;
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
      &:focus {
        border: 2px solid #008fcb;
        -webkit-transition: all .3s ease-in-out;
        transition: all .3s ease-in-out;
      }
    }
    & > img {
      position: absolute;
      top: 6px;
      left: 15px;
    }
    label.error.is-visible {
      visibility: visible;
      opacity: 1;
      right: 8px;
      -ms-filter: "alpha(Opacity=100)";
      -webkit-transform: translate(0, 0);
      -ms-transform: translate(0, 0);
      transform: translate(0, 0);
      -webkit-transition: .3s ease-out;
      transition: .3s ease-out;
    }
    label.error {
      position: absolute;
      top: 0;
      right: -70px;
      padding: 0 8px;
      line-height: 44px;
      color: #c33;
      cursor: text;
      background: 0 0;
      opacity: 0;
      -webkit-transform: translate(20px, 0);
      -ms-transform: translate(20px, 0);
      transform: translate(20px, 0);
      -webkit-transition: .25s ease-out;
      transition: .25s ease-out;
    }
    .lyz-left {
      float: left;
      width: 58%;
      position: relative;
      input {
        width: 100%;
        padding: 12px 20px 12px 13px;
      }
    }
    .lyz-right {
      float: right;
      width: 38%;
      height: 44px;
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
      overflow: hidden;
      img {
        width: 100%;
        height: 44px;
        cursor: pointer;
      }
    }
    .input-btn {
      width: 100%;
      display: block;
      border: none;
      height: 44px;
      line-height: 44px;
      background-color: #3c97ee;
      background-image: linear-gradient(90deg, #00d0fb, #00acf6);
      color: #fff;
      overflow: hidden;
      cursor: pointer;
      font-size: 14px;
      text-align: center;
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
    }
    .disabled {
      background: gray;
    }
  }

  .checkbox-wr {
    width: 100%;
    margin: 20px 0 15px;
    .remember {
      position: relative;
      float: left;
      margin-right: 10px;
      cursor: pointer;
      span {
        font-size: 14px;
        color: #c8c8c8;
        font-weight: 400;
      }
    }

  }

  .tologin {
    color: #c8c8c8;
    -webkit-transition: all .3s ease-in-out;
    transition: all .3s ease-in-out;
    text-align: center;
    span {
      color: #c8c8c8;
      margin-right: 10px;
    }
    a {
      color: #3c97ee;
    }
  }
</style>
