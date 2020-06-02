<template>
  <sign-bg>
    <div class="sign-box">
      <p class="sign-title">注册</p>
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
        <input type="text"
               v-model="name.value"
               name="name"
               @input="verifyNameCheck()"
               maxlength="10"
               placeholder="请输入真实名字"
               class="name"/>
        <img src="../assets/user2.png" style="width: 35px;"/>
        <label class="error"
               :class="name.error ? 'is-visible' : ''">
          {{name.error}}
        </label>
      </div>
      <div class="form-group clearfix">
        <input type="text"
               v-model="card.value"
               placeholder="请输入身份证号"
               class="card"
               maxlength="18"
               @input="verifyCard()"
               name="card"
               autocomplete="new-password"/>
        <img src="../assets/card.png" style="width: 30px;margin-top: 2px;margin-left: 2px;"/>
        <label class="error"
               :class="card.error ? 'is-visible' : ''">
          {{card.error}}
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
      <div class="form-group clearfix">
        <input type="password"
               v-model="passwdCheck.value"
               placeholder="确认密码"
               class="passwdCheck"
               @input="verifyPasswdCheck()"
               name="passwdCheck"
               autocomplete="new-password"/>
        <img src="../assets/pass2.png" style="width: 30px;margin-top: 2px;margin-left: 2px;"/>
        <label class="error"
               :class="passwdCheck.error ? 'is-visible' : ''">
          {{passwdCheck.error}}
        </label>
      </div>

      <div class="form-group clearfix">
        <div class="lyz-left">
          <input type="text"
                 placeholder="手机验证码"
                 class="tmsg"
                 name="tmsg"
                 @input="verifyPhoneCode()"
                 v-model="phone_code.value"
                 autocomplete="new-password"/>
          <label class="error"
                 :class="phone_code.error ? 'is-visible' : ''">
            {{phone_code.error}}
          </label>
        </div>
        <div class="lyz-right">
          <p v-if="!isCount" class="input-btn" @click="sendPhoneCode()">发送验证码</p>
          <p v-if="isCount" class="input-btn disabled">{{count}} s</p>
        </div>
      </div>
      <div class="form-group clearfix" style="margin-top: 40px">
        <button type="button" class="input-btn" @click="handleSubmit()">注册</button>
      </div>
      <p class="tologin">
        <span>已有账号</span>
        <router-link to="/signIn">立即登录</router-link>
      </p>
    </div>
  </sign-bg>
</template>
<script type="text/ecmascript-6">
  import SignBg from '@/base/signBg'
  import {register} from "../public/js/api";

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
        name: {
          value: '',
          error: '',
          isVerify: false
        },
        password: {
          value: '',
          error: '',
          isVerify: false
        },
        passwdCheck: {
          value: '',
          error: '',
          isVerify: false
        },
        phone_code: {
          value: '',
          error: '',
          isVerify: false
        },
        card: {
          value: '',
          error: '',
          isVerify: false
        },
        isShowImg: false,
        count: 120,
        isCount: false,
        timer: null,
        imgCaptcha: ''
      }
    },
    methods: {
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
        return this.phone.isVerify;
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
        return this.password.isVerify;
      },
      /**
       * 身份证验证
       */
      verifyCard() {
        const reg = /(^\d{18}$)/
        if (this.card.value === '') {
          this.card.error = '请输入身份证号'
          this.card.isVerify = false
        } else if (!reg.test(this.card.value)) {
          this.card.error = '请输入有效身份证号'
          this.card.isVerify = false
        } else {
          this.card.error = ''
          this.card.isVerify = true
        }
        return this.card.isVerify;
      },
      verifyNameCheck(){
        if(this.name.value===''){
          this.name.error = '请填写名字';
          this.name.isVerify = false;
        }else{
          this.name.error = '';
          this.name.isVerify = true;
        }
        return this.name.isVerify;
      },
      /**
       * 确认密码验证
       */
      verifyPasswdCheck() {
        if (this.passwdCheck.value === '') {
          this.passwdCheck.error = '请确认密码'
          this.passwdCheck.isVerify = false
        } else if (this.password.value !== this.passwdCheck.value) {
          this.passwdCheck.error = '两次密码不一致'
          this.passwdCheck.isVerify = false
        } else {
          this.passwdCheck.error = ''
          this.passwdCheck.isVerify = true
        }
        return this.passwdCheck.isVerify;
      },
      /**
       * 手机验证码验证
       */
      verifyPhoneCode() {
        if (this.phone_code.value === '') {
          this.phone_code.error = '请输入手机验证码'
          this.phone_code.isVerify = false
        } else {
          this.phone_code.error = ''
          this.phone_code.isVerify = true
        }
        return this.phone_code.isVerify;
      },
      /**
       * 触发验证
       */
      handleForm() {
        var boo = true;
        boo = boo && this.verifyPhone();
        boo = boo && this.verifyPasswd();
        boo = boo && this.verifyNameCheck();
        boo = boo && this.verifyPasswdCheck();
        boo = boo && this.verifyCard();
        return boo;
      },
      /**
       * 提交表单数据
       */
      handleSubmit() {
        if(this.handleForm()){
          var data = {
            "phone":this.phone.value,
            "name":this.name.value,
            "card":this.card.value,
            "password":this.password.value
          }
          register({"users":data}).then(res=>{
            if(res.status==="200"){
              this.$message.success("注册成功");
              this.$router.push('/signIn')
            }else{
              this.$message.error("该账户已经存在")
            }
          })
        }
      },
      /**
       * 提交数据
       */
      handleFormAjax() {

      },
      /**
       * 发送手机验证码
       */
      sendPhoneCode() {
        if(this.verifyPhone()){
          this.isCount = true
          this.countDown()
        }
      },

      /**
       * 倒数
       */
      countDown() {
        if (this.isCount) {
          this.timer = setInterval(() => {
            var countNum = this.count
            countNum -= 1;
            if (countNum < 1) {
              this.isCount = false
              countNum = 120
              clearInterval(this.timer)
            }
            this.count = countNum
          }, 1000)
        }
      },
    },
  }
</script>
<style scoped lang="less">

  .sign-box {
    width: 500px;
    height: 600px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-left: -200px;
    margin-top: -300px;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 20px;
    background: rgba(0, 0, 0, 0.4);
    padding: 20px 60px 28px;
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

  .tologin {
    color: #969696;
    -webkit-transition: all .3s ease-in-out;
    transition: all .3s ease-in-out;
    text-align: center;
    span {
      color: #969696;
      margin-right: 10px;
    }
    a {
      color: #3c97ee;
    }
  }
</style>
